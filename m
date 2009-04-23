From: Alex Blewitt <alex@bandlem.com>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 22:12:40 +0100
Message-ID: <C4403889-A699-4138-9AD5-EE04915657B7@bandlem.com>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904232226.22240.robin.rosenberg@dewire.com> <480EAB35-0032-42E9-B6C1-6712A7EB7ED1@bandlem.com> <200904232309.28680.robin.rosenberg@dewire.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 23:14:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx6FV-0006kp-Lw
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 23:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbZDWVMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755652AbZDWVMv
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 17:12:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:41507 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098AbZDWVMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 17:12:50 -0400
Received: by fg-out-1718.google.com with SMTP id d23so69167fga.17
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 14:12:48 -0700 (PDT)
Received: by 10.86.33.10 with SMTP id g10mr443662fgg.57.1240521168786;
        Thu, 23 Apr 2009 14:12:48 -0700 (PDT)
Received: from apple.int.bandlem.com (server.bandlem.com [217.155.97.60])
        by mx.google.com with ESMTPS id 4sm484356fgg.23.2009.04.23.14.12.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 14:12:46 -0700 (PDT)
In-Reply-To: <200904232309.28680.robin.rosenberg@dewire.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117387>


On 23 Apr 2009, at 22:09, Robin Rosenberg wrote:

> torsdag 23 april 2009 22:36:49 skrev Alex Blewitt <alex@bandlem.com>:
>> I don't know of any other SCM that allows you to un-ignore files in
>> the way that Git does; my guess is that most people wouldn't miss it
>> if it weren't there. A .gitignore customised editor is probably
>> overkill too - after all, you can just open it up in a text editor  
>> and
>> make changes yourself. I've amended a few .cvsignore files in my time
>> manually, but I wouldn't want to overcomplicate the menu for that.
>
> Why do we want a plugin for git? We have the command line.

I mean, it's trivial to open up the .gitignore file in Eclipse as a  
text file. I was doing that to check the implementation worked whilst  
adding entries to the .gitignore.

I've seen all manner of bad UIs in applications created because the  
developer wanted 'total flexibility' and exposed everything via the  
UI. For something as simple as ignoring a file, which is already a  
pretty standardised operation across SCMs, I don't see any benefit in  
making it more complicated than it needs to be.

Alex
