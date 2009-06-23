From: Andreas Ericsson <ae@op5.se>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 15:21:06 +0200
Message-ID: <4A40D6C2.2060700@op5.se>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org> <4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 15:21:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ5wD-0008EZ-UE
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 15:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbZFWNVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 09:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756874AbZFWNVI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 09:21:08 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45605 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752337AbZFWNVH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2009 09:21:07 -0400
Received: from source ([72.14.220.156]) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkDWxL0G06WkzMSa1hQQgyj3EEm2bQKk@postini.com; Tue, 23 Jun 2009 06:21:11 PDT
Received: by fg-out-1718.google.com with SMTP id l27so20859fgb.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 06:21:08 -0700 (PDT)
Received: by 10.86.26.11 with SMTP id 11mr154752fgz.45.1245763268660;
        Tue, 23 Jun 2009 06:21:08 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm2207577fge.8.2009.06.23.06.21.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 06:21:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090623131131.GA7011@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122088>

Finn Arne Gangstad wrote:
> On Tue, Jun 23, 2009 at 02:59:10PM +0200, Paolo Bonzini wrote:
> [...]
>> Before going on, can you explain your use case for --push=tracking (in a  
>> case where --push=current wouldn't do the same)?
> 
> The idea with "tracking" is to push the current branch to wherever it
> would pull from, making push & pull "equivalent" in some sense.
> 
> This is different from "current" if you have/choose to name the local
> branch something else than the remote branch. This happens a lot when
> using multiple remotes.
> 
> E.g. some remotes have only a single active branch called "master",
> and you have to name it something else locally, or several people have
> local branches called "beta", and you have to name it something like
> "fred-beta" locally if you are working on fred's beta.
> 

Umm. Why not name it after the feature you're working on instead of the
branch you started from? That way, you get fred/beta (assuming you've
added Fred's repo as a remote named "fred" ofcourse) and all your
branches have names that never (in theory) clash with any of your
upstreams.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
