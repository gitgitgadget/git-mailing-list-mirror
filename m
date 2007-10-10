From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] git-gui: add mingw specific startup wrapper
Date: Wed, 10 Oct 2007 18:10:21 +0200
Message-ID: <BBE6D747-4CD2-4D10-914B-F3149A8591E4@zib.de>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de> <11919995392158-git-send-email-prohaska@zib.de> <11919995392881-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710101653400.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 18:09:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ife7M-0005bn-0V
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 18:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbXJJQIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 12:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbXJJQIz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 12:08:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:47817 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXJJQIy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 12:08:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9AG8noh029778;
	Wed, 10 Oct 2007 18:08:49 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9AG8ngQ009211
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 10 Oct 2007 18:08:49 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710101653400.4174@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60517>


On Oct 10, 2007, at 5:56 PM, Johannes Schindelin wrote:

> On Wed, 10 Oct 2007, Steffen Prohaska wrote:
>
>> The wrapper adds the directory it is installed in to PATH.
>> This is required for the git commands implemented in shell.
>> git-gui fails to launch them if PATH is not modified.
>>
>> The wrapper script also accepts an optional command line
>> switch '--working-dir <dir>' and changes to <dir> before
>> launching the actual git-gui. This is required to implement
>> the "Git Gui Here" Explorer shell extension.
>
> It should be mentioned here that the Explorer shell extension you talk
> about is the very simple extension provided by the Inno Installer.

Yes, but it's already there. And Shawn even finds --working-dir  
interesting
as a general feature.


> I have a much larger and versatile shell extension in mind: git- 
> cheetah.
> And fixing it is probably trivial; it can both change directory to the
> current directory (sounds wrong, doesn't it?) and extend the PATH
> appropriately before calling git-gui.

I know, but it's not yet there.


> Note: the latter is not even necessary once we (correctly) add git  
> to the
> PATH in the installer.

(wrongly ;) Adding git to the PATH will only become an option. git-gui
should also work if it's not added.

I comment on the PATH question in reply to another mail.

	Steffen
