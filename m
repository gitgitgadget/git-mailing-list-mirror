From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc5
Date: Tue, 29 Jan 2008 01:36:42 +0100
Message-ID: <479E751A.1080308@isy.liu.se>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <7vsl0r3nvc.fsf@gitster.siamese.dyndns.org> <7vk5lutdzq.fsf@gitster.siamese.dyndns.org> <20080128183851.GB31140@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 01:37:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJeTX-0005ZK-DT
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 01:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbYA2Agq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 19:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbYA2Agq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 19:36:46 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:43302 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYA2Agp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 19:36:45 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id C587C25A9E;
	Tue, 29 Jan 2008 01:36:43 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 07692-06; Thu,  3 Jan 2008 00:53:57 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 3BBA325A9C;
	Tue, 29 Jan 2008 01:36:43 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080128183851.GB31140@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71909>

On 01/28/2008 07:38 PM, Jeff King wrote:
> On Mon, Jan 28, 2008 at 02:56:41AM -0800, Junio C Hamano wrote:
> 
>> Gustaf Hendeby (1):
>>       send-email, fix breakage in combination with --compose
> 
> I submitted a followup test for this problem, but there was no
> response. Can I please get an ACK/NAK/"resend after 1.5.4"?

FWIW, I think it looks like a good extension to the test suit,
but the added option should probably put it post 1.5.4 just to
play it safe?  I also think it is the right thing to do not to
document that new option.

The last patch also needs a trivial fix-up to apply nicely.

/Gustaf

> 
> For reference, the original message-id was:
> 
>   <20080122032353.GB24758@coredump.intra.peff.net>
