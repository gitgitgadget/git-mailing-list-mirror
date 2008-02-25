From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] help: use parseopt
Date: Sun, 24 Feb 2008 23:16:30 -0800
Message-ID: <7vbq65o69d.fsf@gitster.siamese.dyndns.org>
References: <cover.1203890846.git.peff@peff.net>
 <20080224221655.GB31309@coredump.intra.peff.net>
 <200802250750.53047.chriscool@tuxfamily.org>
 <20080225065710.GA3765@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 08:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTXaj-0000St-9U
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 08:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbYBYHQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 02:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbYBYHQx
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:16:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYBYHQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:16:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 58285122A;
	Mon, 25 Feb 2008 02:16:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 097F31228; Mon, 25 Feb 2008 02:16:40 -0500 (EST)
In-Reply-To: <20080225065710.GA3765@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 25 Feb 2008 01:57:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74998>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 25, 2008 at 07:50:52AM +0100, Christian Couder wrote:
>
>> > Sorry, the diff turned out quite messy because of the cleanups. It's
>> > probably easier to just read the result.
>> 
>> Or could you send the cleanups in some separated patches ?
>
> Looking at it again, it's actually not too bad except for the cmd_help()
> function itself, which isn't due to the cleanups at all, but because the
> flow changes quite a bit. So I don't think splitting it actually will
> make the diff any friendlier.

Your patch is fine as-is.
