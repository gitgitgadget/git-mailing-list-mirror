From: Patrick Altman <paltman@gmail.com>
Subject: Re: Git Library?
Date: Mon, 28 Apr 2008 16:17:22 -0500
Message-ID: <F427C4D4-7264-4341-A714-23D9DD39E229@gmail.com>
References: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com> <m3y76xofgm.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:18:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqaju-0006Li-W3
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbYD1VR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936733AbYD1VR2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:17:28 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:5784 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936776AbYD1VR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:17:27 -0400
Received: by py-out-1112.google.com with SMTP id u52so8061312pyb.10
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=0PkoE38mxNqQv6cuonIjhyCFkLLb0WBi7f1/Fa0xgwY=;
        b=Bbuqhlv0XHyedi2rFo/4cW2KSwLQdP6itpn5N4glKvizUco70gjxWDQp0gwmyZziLhuqG6fEqCn82k+IealobLSjp5iwDL/Upnj2xxptZuJnv6IxgT7rqOSH2Vz2Cb14EFkGWX7hvYdkqvgjNAkgsj4Occ/paPjISnBcWbmr7oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=HVVt5crGFogF1Yd0o65mZGNA+7xKcmPJwvOTefZJ/KBB8U7JYVhQ5HY5JHD3+kNhZzFoMcgCAyb8pO4AHIlkQv6TvJlzI/Ue9VritBRGgbVYUAWY4S6Wuc5M0uagDHT7kIUv1mHf+fS3UnTEliN9t1XJ9RmuX8LVZE2Lk3MiNL8=
Received: by 10.35.92.18 with SMTP id u18mr13988899pyl.33.1209417444691;
        Mon, 28 Apr 2008 14:17:24 -0700 (PDT)
Received: from PatrickMac.SME ( [71.4.241.34])
        by mx.google.com with ESMTPS id w67sm17718720pyg.20.2008.04.28.14.17.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 14:17:23 -0700 (PDT)
In-Reply-To: <m3y76xofgm.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80617>


On Apr 28, 2008, at 4:08 PM, Jakub Narebski wrote:

> Patrick Altman <paltman@gmail.com> writes:
>
>> I want to write a Mac OSX UI for git.
>
> Something like GitNub?

Not really.  GitNub is really an interface for GitHub.  I am thinking  
something more like ZigVersion, http://zigzig.com/, for Git instead of  
Subversion.

>> Is there a documented/undocumented API for interacting with git in
>> process?  Or would I be better off "shelling out" to the git command
>> line?
>
> Take a look how other GUIs does it.

git-gui is written in TCL I believe, which I do not want to use.
GitNub is the only other GUI of sorts that i am aware of but like I  
mentioned above, that really is more of a GitHub interface and less of  
a git interface.

I think that this point I am just going to use NTask and the like in  
Cocoa/Objective-C to wrap the command line utilities.

Thanks,
Patrick
