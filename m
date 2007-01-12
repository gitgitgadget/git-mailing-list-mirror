From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git and announcing GIT v1.5.0-rc1
Date: Fri, 12 Jan 2007 15:01:07 +0000
Message-ID: <200701121501.24642.andyparkins@gmail.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 12 16:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Nx8-0004K2-8V
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 16:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbXALPEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 10:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXALPEL
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 10:04:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:34714 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbXALPEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 10:04:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so804946uga
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 07:04:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NLu25ufz4g3dTaFuMcItGauti7Pi4S85kzCL9P8VuKi5WEHspyfHDAJTUPCt1YJB5sbjiFT17U0NLMp8daSb2B4V7Qq1plN/jACdkciySBAKbUZUZz2yPdAL52VTKXRyh/lNx67vA77QiYB5tHdRTaj9xg0/CPaxuqvh7E5+MN0=
Received: by 10.66.232.9 with SMTP id e9mr1016635ugh.1168614247820;
        Fri, 12 Jan 2007 07:04:07 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id e1sm2421079ugf.2007.01.12.07.04.07;
        Fri, 12 Jan 2007 07:04:07 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36677>

On Friday 2007, January 12 02:43, Junio C Hamano wrote:

>  - I'll change my $PATH to use the 'master' version, not 'next',
>    for my own use until v1.5.0 final.  I ask people who usually
>    follow 'next' to do the same so that we can catch breakages
>    on 'master'.

Minor thing: git-rebase, git-cherry-pick and git-pull (and presumably 
git-merge) all need to be the repository root to work.  If that is 
intentional, a better message than "fatal: Not a git repository: '.git'" 
would be appropriate.

For me, I'd prefer that they worked in subdirectories.  I do all almost all 
development in "src/" and having to change up a directory just to run git 
commands is inconvenient.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
