From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why is it important to learn git?
Date: Tue, 04 Aug 2009 16:09:26 +0200
Message-ID: <4A784116.2050508@op5.se>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com> <200907220952.27385.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 04 16:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYKhw-0000n2-1b
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 16:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbZHDOJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 10:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbZHDOJc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 10:09:32 -0400
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47964 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755287AbZHDOJb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 10:09:31 -0400
Received: from source ([209.85.219.222]) by na3sys009aob107.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSnhBGgExQgSkTGDsN+xUQ9Qfcpnyse76@postini.com; Tue, 04 Aug 2009 07:09:32 PDT
Received: by ewy22 with SMTP id 22so3816675ewy.4
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 07:09:30 -0700 (PDT)
Received: by 10.210.66.13 with SMTP id o13mr8743873eba.88.1249394969772;
        Tue, 04 Aug 2009 07:09:29 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 5sm107442eyf.38.2009.08.04.07.09.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 07:09:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200907220952.27385.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124789>

Thomas Rast wrote:
> Tim Harper wrote:
>> How has mastering the advanced features of git helped you to be a
>> better programmer?
> 
> I came from SVN, and I guess the most important change for me was:
> 
>   Learning to make nice, reviewable, working, one-change-per-revision
>   commits.
> 

Seconded. During the CVS days, noone bothered about history, but with
git a it's a veritable goldmine of important information, so it's
important to keep it clean with minimal changesets.

One of our developers was very sloppy about this until he ended up
with a bisection run landing him on a commit that fixed no less
than seven different issues. He spent four days debugging it and
finally had to resort to breaking the issues up and creating the
commits as they should have been on a temporary side-branch and
then bisecting that side-branch. Having done that, he spotted the
error in about 15 minutes. After some swearing, he finally saw the
light. He's actually a happier person now, since bugs that take a
long time to solve upset him quite enormously and now he never runs
into any :-)

Apart from that, the various ways of cooperating over large distances
(easy branching + merging, patch sending/applying utilities) are a
huge benefit for us.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
