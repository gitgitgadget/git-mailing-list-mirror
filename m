From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Mon, 3 Dec 2007 18:33:12 -0800
Message-ID: <21AA9521-0FED-471F-AFBC-B5CEF4B4A5E9@midwinter.com>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203040108.GS14735@spearce.org> <Pine.LNX.4.64.0712031146520.27959@racer.site> <20071204015108.GV14735@spearce.org> <Pine.LNX.4.64.0712040211270.27959@racer.site> <20071204022020.GA14735@spearce.org> <Pine.LNX.4.64.0712040224080.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNbS-0006nY-Dc
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbXLDCdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbXLDCdO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:33:14 -0500
Received: from tater.midwinter.com ([216.32.86.90]:41307 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbXLDCdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:33:13 -0500
Received: (qmail 24409 invoked from network); 4 Dec 2007 02:33:13 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=XGNDxKhcdiB9HS2g6C6PAF0L3R39ImelHkouWoaCz2vmqsZuRuseoutCR3QJDCZy  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 4 Dec 2007 02:33:13 -0000
In-Reply-To: <Pine.LNX.4.64.0712040224080.27959@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66998>

On Dec 3, 2007, at 6:25 PM, Johannes Schindelin wrote:
> I am somewhat wary of using environment variables in that context,  
> since
> the variables could leak to subprocesses, or (even worse), they  
> could be
> set inadvertently by the user or other scripts.

Agreed on the inadvertent setting, but isn't leaking to subprocesses  
the whole point of the exercise here?

-Steve
