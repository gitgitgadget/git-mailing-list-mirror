From: "rollinsdr@gmail.com" <rollinsdr@gmail.com>
Subject: Re: Submodule status inside nested submodule fails
Date: Tue, 8 May 2012 11:11:15 -0700 (PDT)
Message-ID: <1336500675427-7540130.post@n2.nabble.com>
References: <loom.20120224T104003-230@post.gmane.org> <loom.20120224T142455-253@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 20:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRosa-0007DR-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 20:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab2EHSLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 14:11:16 -0400
Received: from sam.nabble.com ([216.139.236.26]:43345 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab2EHSLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 14:11:16 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <rollinsdr@gmail.com>)
	id 1SRosV-0001rg-E3
	for git@vger.kernel.org; Tue, 08 May 2012 11:11:15 -0700
In-Reply-To: <loom.20120224T142455-253@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197414>

I'm having the same issue. Did it ever get resolved, or is there a hack to
fix it, or is there some link I can track it on?

Thanks in advance for the help!



Charles Brossollet wrote
> 
> Charles Brossollet <chbrosso <at> lltech.fr> writes:
> Using MSysGit 1.7.9 on Win7 (64 bit), I have a repo with the following 
> structure: 
> 
> main/ 
>   src/ 
>   ext/ 
>     submodule/ 
>        modules/module1 
>        modules/module2 
> 
> submodule is... a submodule, having itself submodules. 
> 
> When I query submodule status --recursive in main/, no problem. 
> But when I query submodule status in  ext/submodule, I get error "You need
> to 
> run this command from the toplevel of the working tree.", which is a wrong 
> error message. 
> 
> Searching for message in git source I found the test triggering the
> message to 
> be an empty result for "git rev-parse --show-cdup". Running the command in 
> ext/submodule strangely returns the *absolute* path of ext/submodule,
> which 
> should not happen because this command returns path of current dir
> relative to 
> the containing working tree. 
> 
> Is there something wrong with my repo? Or have I found a bug? Any help 
> appreciated 
> 


Charles Brossollet wrote
> 
> Charles Brossollet <chbrosso <at> lltech.fr> writes:
>  
>> Searching for message in git source I found the test triggering the
>> message to
>> be an empty result for "git rev-parse --show-cdup". Running the command
>> in
>> ext/submodule strangely returns the *absolute* path of ext/submodule,
>> which
>> should not happen because this command returns path of current dir
>> relative to
>> the containing working tree.
> 
> Things are OK if I run the commands from Windows' CMD, but it fails when
> run in
> MinGW shell, so I believe the problem is related to MsysGit, discussion
> follows
> up on their list.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@.kernel
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
View this message in context: http://git.661346.n2.nabble.com/Submodule-status-inside-nested-submodule-fails-tp7314413p7540130.html
Sent from the git mailing list archive at Nabble.com.
