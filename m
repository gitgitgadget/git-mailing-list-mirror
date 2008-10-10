From: marcreddist@aim.com
Subject: Re: Really remove a file ?
Date: Fri, 10 Oct 2008 05:38:25 -0400
Message-ID: <8CAF8D313562BEE-1588-259E@webmail-da15.sysops.aol.com>
References: <8CAF851B91FEF07-660-20E9@webmail-da15.sysops.aol.com> <81b0412b0810091156v15dea27an95050a06cfb4f8df@mail.gmail.com> <d4bc1a2a0810091643u3903a1f4h44d3579b98fe6922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 11:48:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoEb9-0000yB-Ti
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 11:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757417AbYJJJqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 05:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757376AbYJJJqj
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 05:46:39 -0400
Received: from imo-m13.mx.aol.com ([64.12.143.101]:13394 "EHLO
	imo-m13.mail.aol.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757316AbYJJJqh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 05:46:37 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Oct 2008 05:46:37 EDT
Received: from marcreddist@aim.com
	by imo-m13.mx.aol.com  (mail_out_v39.1.) id x.d0b.36ef32bd (37056)
	 for <git@vger.kernel.org>; Fri, 10 Oct 2008 05:38:26 -0400 (EDT)
Received: from smtprly-ma01.mx.aol.com (smtprly-ma01.mx.aol.com [64.12.207.140]) by cia-db04.mx.aol.com (v121_r3.13) with ESMTP id MAILCIADB042-90c048ef229227e; Fri, 10 Oct 2008 05:38:26 -0400
Received: from webmail-da15 (webmail-da15.webmail.aol.com [205.188.212.210]) by smtprly-ma01.mx.aol.com (v121_r3.13) with ESMTP id MAILSMTPRLYMA012-5c4448ef2290b1; Fri, 10 Oct 2008 05:38:24 -0400
X-AOL-IP: 62.23.145.195
In-Reply-To: <d4bc1a2a0810091643u3903a1f4h44d3579b98fe6922@mail.gmail.com>
X-MB-Message-Source: WebUI
X-MB-Message-Type: User
X-Mailer: AIM WebMail 39155-STANDARD
Received: from 62.23.145.195 by webmail-da15.sysops.aol.com (205.188.212.210) with HTTP (WebMailUI); Fri, 10 Oct 2008 05:38:24 -0400
X-Spam-Flag: NO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97920>

Hi,



Thank you both, that's exactly what i needed.



In case someone finds this post in the future, this :

> $ git filter-branch --index-filter 'git update-index --remove

' --force -- --all

worked perfectly. Although, it told me that git can't work on a dirty 
directory so I did this :

$ git add .

$ git commit

And after the filter-branch

$ git reset --hard HEAD^



> You'll probably also want to run "git gc" on your repo to

> actually get rid of the huge object that was added (or does

> filter-branch do this automatically?).

I'm not sure it's required by git-filter-branch alone. In this case :

git-gc saves almost 5% after the file deletion

it saves 4.5% before the file deletion

If I run git gc before and after the git filter-branch, it saves 4.5% 
and then 0.2%.



But maybe my tests applies to my particular environment and cannot be 
generalized.





Thank you again for the help.

Take care,

Marc, happy git user.



-- 
