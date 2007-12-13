From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 15:03:18 +0100
Message-ID: <47613BA6.1060705@viscovery.net>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com> <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com> <Pine.LNX.4.64.0712121814260.27959@racer.site> <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com> <Pine.LNX.4.64.0712121931050.27959@racer.site> <7vhcin3rv4.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0712131248500.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 15:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ofD-0007sY-Aa
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 15:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbXLMODY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 09:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbXLMODY
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 09:03:24 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33402 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbXLMODX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 09:03:23 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J2of4-0004HG-Pp; Thu, 13 Dec 2007 15:03:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E98B869F; Thu, 13 Dec 2007 15:03:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0712131248500.27959@racer.site>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68156>

Johannes Schindelin schrieb:
> On Thu, 13 Dec 2007, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> For this to work, apply has to be called with --unidiff-zero, since
>>> the new hunks can start or stop with a "-" or "+" line.
>> You do not have to do "unidiff zero".  Suppose you have this hunk you
>> need to split.
>>
>> [describes to pick zero or more '-' lines and zero or more '+' lines]
> 
> I thought about that, but the UI is not trivial.  The UI for my solution 
> is.

It's probably sufficient to have an option "Stage this Line": Once you have
staged enough lines, the hunk will be split automatically by the current
number-of-context-lines setting.

-- Hannes
