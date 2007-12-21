From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 16:23:11 +0100
Message-ID: <476BDA5F.4070306@isy.liu.se>
References: <20071220203211.GA12296@bit.office.eurotux.com> <1198237002-21470-1-git-send-email-hendeby@isy.liu.se> <20071221133412.GA15198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: luciano@eurotux.com, git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 16:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5jit-0003SX-Lk
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 16:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbXLUPXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 10:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbXLUPXQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 10:23:16 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:43841 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbXLUPXP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 10:23:15 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 8A29325AAD;
	Fri, 21 Dec 2007 16:23:13 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 00226-04; Fri, 21 Dec 2007 16:23:12 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id C4B7325AAB;
	Fri, 21 Dec 2007 16:23:12 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20071221133412.GA15198@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69067>

On 12/21/2007 02:34 PM, Jeff King wrote:
> On Fri, Dec 21, 2007 at 12:36:42PM +0100, Gustaf Hendeby wrote:
> 
>> -	system($editor, $compose_filename);
>> +	system("$editor $compose_filename");
> 
> If you are going to do it that way, I suspect you want to quotemeta
> $compose_filename.
> 
> -Peff

Generally that would be true, but is that really necessary when I know
$compose_filename is defined as:

my $compose_filename = ".msg.$$";

Or, should I take it that you prefer the version using split?  I didn't
really feel good about the possibility of splitting paths with spaces
that came with that one though.

/Gustaf
