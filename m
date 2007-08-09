From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Thu, 9 Aug 2007 12:33:35 +0200
Message-ID: <DFEB6116-ABB4-4D61-92E4-0688604069DE@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <f99nm6$9vi$1@sea.gmane.org>  <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org>  <20070807145825.GO21692@lavos.net>  <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>  <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>  <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>  <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <2F00D32E-8D0C-48D6-86E1-6F6E7611E364@zib.de> <7E22DF40-1E28-4B8A-B132-18B05136B5E9@zib.de> <46BAADC8.9020003@trolltech.com> <Pine.LNX.4.64.0708090949200.21857@racer.site> <46BAD793.9040906@trolltech.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 12:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ5Mz-0007bm-Gq
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 12:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760970AbXHIKfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 06:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759809AbXHIKfx
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 06:35:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:44168 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517AbXHIKfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 06:35:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l79AWsOx000429;
	Thu, 9 Aug 2007 12:34:44 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l79AWinP018593
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 9 Aug 2007 12:32:45 +0200 (MEST)
In-Reply-To: <46BAD793.9040906@trolltech.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55441>


On Aug 9, 2007, at 11:00 AM, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 09.08.2007 10:50:
>> On Thu, 9 Aug 2007, Marius Storm-Olsen wrote:
>>> Try running gitme from a terminal.
>> And there I thought that you download GitMe-3.exe, and then double
>> click on it...
>
> Heh, yeah, normally that's indeed what you do. However, in this  
> case I asked him to start it from the terminal to make sure that it  
> wasn't affected by anything suspicious in his system PATH.
>
> Clearly having Cygwin in his path messed things up.

I think checking for a proper setup in the installer would
be a good idea, like checking if 'cygpath' runs and if so,
die with the request to cleanup the system PATH first.

The problem was not too hard to solve, but the first
impression was not optimal.

Where would I have to look to add something like this?

	Steffen
