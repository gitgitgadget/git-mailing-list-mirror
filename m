From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: Why do we need [PATCH]?
Date: Fri, 16 Dec 2005 16:14:27 -0500
Message-ID: <43A32E33.6040709@didntduck.org>
References: <20051216210145.GA25311@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:15:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnMsa-0007ml-V7
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVLPVMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVLPVMg
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:12:36 -0500
Received: from quark.didntduck.org ([69.55.226.66]:44483 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932420AbVLPVMf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:12:35 -0500
Received: from [172.21.26.77] (ip-2.provia.com [208.224.1.2])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id jBGLCVS26561;
	Fri, 16 Dec 2005 16:12:31 -0500
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20051216210145.GA25311@mars.ravnborg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13751>

Sam Ravnborg wrote:
> Hi git's.
> 
> I've just applied a patch to my git tree using git-applymbox.
> It worked like a charm as it often do.
> But then when I did a quick check with gitk it stuck me that
> the subject was prefixed with [PATCH].
> I am aware that the [PATCH] in subject tell me:
> "patch is received from somewhere and applied by me to the .git tree".
> This is in comparsion to patches received when I merge a git tree for
> example.
> 
> But with common practice to use sign-off I wonder the value of this
> patch marker.
> When browsing the kernel shortlog I often focus on first word in subject
> - cause this tells me what system/drivers is changed. But with the
>   [PATCH] marker I have to read some non-sense to see actual subject.
> 
> The information is redundant since metadata already tell me who is the
> author and who committed the change.
> So could we have it removed or if people continue to find it usefull
> then at least hide it behind some option. Using the [PATCH] prefix is
> not the natural thing to do with git.
> 
> I looked at the source and found the -k option, but adding [PATCH]
> should not be default behaviour so this is not the correct solution.
> 
> 	Sam

[PATCH] makes sense for the actual email message so that the recipient 
knows that the message contains a patch.  But I agree that it does not 
add any value to the commit message in git.  It actually detracts value, 
because it takes up limited space in the shortlog message.

--
				Brian Gerst
