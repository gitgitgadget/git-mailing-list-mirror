From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Library?
Date: Tue, 29 Apr 2008 00:01:37 +0200
Message-ID: <200804290001.39226.jnareb@gmail.com>
References: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com> <m3y76xofgm.fsf@localhost.localdomain> <F427C4D4-7264-4341-A714-23D9DD39E229@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Altman <paltman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:03:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqbQf-00059f-BO
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 00:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965803AbYD1WBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 18:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965778AbYD1WBl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 18:01:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:32839 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965796AbYD1WBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 18:01:38 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2008996nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=z/dCudvz6R7NQQFk3q8MsmyGNlwGuFxCRdYaJFXQ5wQ=;
        b=Bhw97xB5u8nVJDwYexPWrFzCKViHHib2Dd0e5tGvSQhzh0IcSvJeYf2qCuEMdkUGpZgj7eI7opHgEwUNw8YVScx2He7KFziTFlMkvol+lv9FBqC4y0FLjQcFZGX37DC8U3fB8AX7mp4kbv7tMl5YhG3WpA4r+BITOQlukXn45l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZE6+wAqOGmZO+1TqTDGqWKOHo+k/vRulRQFJMrNQayJBO1yU9qdzXzWEfg/kuRMXTCeOZEj67TMPa4GhpC+GLqXwkCUVYoL8ibC8fnJfzeZ6fbLbRkC+MnC+Zh5OvpFNRWWK0XAP8wB9vKuPfICgFUb42XmM2xMF6YZihiVtptc=
Received: by 10.210.144.13 with SMTP id r13mr6353482ebd.60.1209420095389;
        Mon, 28 Apr 2008 15:01:35 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.217.96])
        by mx.google.com with ESMTPS id b36sm10438363ika.2.2008.04.28.15.01.32
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 15:01:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <F427C4D4-7264-4341-A714-23D9DD39E229@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80626>

On Mon, 28 Apr 2008, Patrick Altman wrote:
> On Apr 28, 2008, at 4:08 PM, Jakub Narebski wrote:
>> Patrick Altman <paltman@gmail.com> writes:
>>
>>> I want to write a Mac OSX UI for git.
>>
>> Something like GitNub?
> 
> Not really.  GitNub is really an interface for GitHub.  I am thinking  
> something more like ZigVersion, http://zigzig.com/, for Git instead of  
> Subversion.

Well, I thought that GitNub is something similar to gitk, i.e. it is
history browser, but in Ruby/Cocoa instead of Tcl/Tk.
 
>>> Is there a documented/undocumented API for interacting with git in
>>> process?  Or would I be better off "shelling out" to the git command
>>> line?
>>
>> Take a look how other GUIs does it.
> 
> git-gui is written in Tcl I believe, which I do not want to use.
> GitNub is the only other GUI of sorts that i am aware of but like I  
> mentioned above, that really is more of a GitHub interface and less of  
> a git interface.

Take a look at http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
page: there is a list of GUIs there.  There is gitk and git-gui,
there is QGit and varipus PyQt GUIs, there is Giggle, there is tig.

> I think that this point I am just going to use NTask and the like in  
> Cocoa/Objective-C to wrap the command line utilities.

I think best would be to see how QGit does it...

-- 
Jakub Narebski
Poland
