From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Mon, 06 Oct 2008 10:55:11 +0200
Message-ID: <48E9D26F.1030007@viscovery.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net> <20081006065212.GA19175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 06 10:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmlt7-0000f8-Jd
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 10:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYJFIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 04:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbYJFIzI
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 04:55:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16846 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbYJFIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 04:55:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kmlrr-0003zq-Ui; Mon, 06 Oct 2008 10:55:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B928D4FB; Mon,  6 Oct 2008 10:55:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081006065212.GA19175@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97574>

Jeff King schrieb:
> On Mon, Oct 06, 2008 at 08:29:10AM +0200, Johannes Sixt wrote:
> 
>> Does the series in any way change whether plumbing and porcelain invoke
>> the external diff drivers? I have this particular use-case, which I'd like
>> that still works:
> 
> No, it tries to keep the behavior the same as it is now (in 2/4, note
> how the diff driver config reading is split into porcelain and plumbing
> sections). Let me know if you have a test case that doesn't work, or
> that you would like me to try.

A quick check shows that my use-case still works as expected. Thanks.

-- Hannes
