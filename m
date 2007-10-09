From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [msysGit] Re: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Tue, 9 Oct 2007 14:42:05 +0200
Message-ID: <4A4F8FC7-E0AB-4C07-B4C8-AFE2EBD9C3DD@zib.de>
References: <11917925011987-git-send-email-prohaska@zib.de> <20071007233023.GE2137@spearce.org> <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de> <Pine.LNX.4.64.0710091240540.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEOE-0001w7-HD
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbXJIMki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbXJIMki
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:40:38 -0400
Received: from mailer.zib.de ([130.73.108.11]:46304 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbXJIMkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:40:37 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l99CeWNr014434;
	Tue, 9 Oct 2007 14:40:33 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l99CeWe8022615
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 14:40:32 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710091240540.4174@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60394>


On Oct 9, 2007, at 1:43 PM, Johannes Schindelin wrote:

> On Mon, 8 Oct 2007, Steffen Prohaska wrote:
>
>> commit a483fdd562d6c44d68a998224e0bbb17933b624a
>> Author: Steffen Prohaska <prohaska@zib.de>
>> Date:   Mon Oct 8 08:25:47 2007 +0200
>>
>>    git-gui: offer a list of recent repositories on startup
>
> May I suggest not putting this list into ~/.gitconfig, but rather
> ~/.gitguirc?  It is not really a user-specific git configuration...

git-gui already stores other options as global variables gui.*.
(see git-gui/lib/option.tcl). I just added gui.recentrepo. The
list of recent repos should go to wherever git-gui stores its options.

Right now this is in ~/.gitconfig, if I understand correctly. Shawn?

	Steffen
