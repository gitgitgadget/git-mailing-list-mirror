From: Dan Zwell <dzwell@zwell.net>
Subject: Re: [PATCH] git-gui: Update russian translation
Date: Wed, 12 Aug 2009 10:51:58 -0500
Message-ID: <4A82E51E.3040806@zwell.net>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org> <4A81B738.7090507@zwell.net> <20090811202927.GZ1033@spearce.org> <4A81BD58.8070300@zwell.net> <20090812144345.GC1033@spearce.org> <20090812152409.GA5407@blimp.localdomain> <20090812154016.GG1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbI00-0007vm-Kp
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 19:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbZHLRwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 13:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZHLRwX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 13:52:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:7387 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZHLRwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 13:52:22 -0400
Received: by wa-out-1112.google.com with SMTP id j5so36370wah.21
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=NbiBRnA0/SKU1qlAbvu1mzAkuTu+F4NgCgc4hov5w+8=;
        b=vS69m9sq4HcS2CUJhlVwJRD0pR8VKFuG7GUCGyMx3p5aXxHUV5A8KGDdJEmJJXUKoP
         ETpMIl67cgSAemn29kXL3jKY17BzAfMFtJmTn3D4zF8Kat2rUXmTbHvVR8jfxvpMMd9y
         YnndKk4wsurU3Rv+IuKDVKdX03gIFh8BSspJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Qjhib+HpfHVbf8qswMVjBKpHx+xUKnHcyomGffm1nPjMmNMfGjng7ctOTGVEdL+Arm
         uH0bbLqVwi6zHHYc71GqW5PUbUM8cprqpHZaaL5aTAOs0Jl7T2Ic2gdSm/+eX5MmeWyE
         cn4euXivmlxw0rcpj1yXf9+S9LWPHl/or+oJw=
Received: by 10.115.38.39 with SMTP id q39mr252076waj.149.1250099543544;
        Wed, 12 Aug 2009 10:52:23 -0700 (PDT)
Received: from ?192.168.1.105? (c-76-21-120-57.hsd1.ca.comcast.net [76.21.120.57])
        by mx.google.com with ESMTPS id n6sm13020999wag.39.2009.08.12.10.52.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 10:52:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090719)
In-Reply-To: <20090812154016.GG1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125721>

> Alex Riesen <raa.lkml@gmail.com> wrote:
>> But now, when I really think about the change, it looks useless.
>> What has the _number_ of files has to do with the files you actually
>> have to handle? As the sorting of the file list cannot be changed (and
>> it wouldn't be a big help anyway), you have no chance to get to your
>> file if it happens to be past the limit!

> Good point.  I suspect the problem wasn't so much with Tcl doing the
> list processing as it was with Tk actually creating the underlying
> icons and stuff for each file name.  But with the list clipped,
> you are right, you are basically SOL.  You can't do much beyond
> dropping back to the CLI and using the CLI tools.
> 
> IMHO, if we aren't going to handle 20k file names, we should at least
> punt and tell the user we aren't going to handle 20k file names,
> rather than just play Outlook wannabe and lockup the entire UI until
> the user gets bored and kill -9's us.  So this patch is better than
> nothing, it at least lets the user know we have given up on them.
> 

A warning would be good, but this gives users more information. In my 
case, I only wanted to see a few files, but the rest were from a 
directory that should have been in .gitignore. If I had seen the 
filenames, I would have known which directory was the culprit. This way, 
you don't need to drop to the command line to fix the problem.

-Dan
