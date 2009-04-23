From: Alex Blewitt <alex@bandlem.com>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 21:36:49 +0100
Message-ID: <480EAB35-0032-42E9-B6C1-6712A7EB7ED1@bandlem.com>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904232119.36707.robin.rosenberg@dewire.com> <49F0CCF4.20808@pelagic.nl> <200904232226.22240.robin.rosenberg@dewire.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx5gx-0003AE-Nc
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZDWUg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbZDWUg4
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:36:56 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:52547 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZDWUgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 16:36:55 -0400
Received: by ewy24 with SMTP id 24so745641ewy.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 13:36:54 -0700 (PDT)
Received: by 10.210.51.18 with SMTP id y18mr1406011eby.97.1240519014232;
        Thu, 23 Apr 2009 13:36:54 -0700 (PDT)
Received: from apple.int.bandlem.com (server.bandlem.com [217.155.97.60])
        by mx.google.com with ESMTPS id 7sm603103eyg.7.2009.04.23.13.36.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 13:36:53 -0700 (PDT)
In-Reply-To: <200904232226.22240.robin.rosenberg@dewire.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117382>

On 23 Apr 2009, at 21:26, Robin Rosenberg wrote:

> torsdag 23 april 2009 22:17:56 skrev "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl 
> >:
>> while we're on the subject...
>> how about also adding the reverse: when a file is ignored then add  
>> it to
>> the .gitignore file for 'un-ignoring' (the '!' pattern)
>
> I'm not convinced each and everything should have a menu entry.  
> Advanced
> use of .gitignore should have a .gitignore editor. When we have that  
> the
> option could perhaps launch the editor automatically if it  
> recognized no-trivial ignore rules. For trivial cases it would just  
> append to the file.

I don't know of any other SCM that allows you to un-ignore files in  
the way that Git does; my guess is that most people wouldn't miss it  
if it weren't there. A .gitignore customised editor is probably  
overkill too - after all, you can just open it up in a text editor and  
make changes yourself. I've amended a few .cvsignore files in my time  
manually, but I wouldn't want to overcomplicate the menu for that.

Alex
