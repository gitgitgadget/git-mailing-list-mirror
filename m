From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in
 packs with a .keep file
Date: Wed, 12 Nov 2008 09:10:45 -0800
Message-ID: <7vzlk4q38q.fsf@gitster.siamese.dyndns.org>
References: <20081103161202.GJ15463@spearce.org>
 <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <20081112080909.GA29176@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:13:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JHP-0006rK-Q6
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbYKLRLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbYKLRLw
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:11:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbYKLRLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:11:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 707CC7CFA2;
	Wed, 12 Nov 2008 12:11:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B9D5D7CF82; Wed,
 12 Nov 2008 12:10:52 -0500 (EST)
In-Reply-To: <20081112080909.GA29176@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Nov 2008 03:09:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE2AA04C-B0DC-11DD-9029-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100776>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 03, 2008 at 02:37:05PM -0600, Brandon Casey wrote:
>
>> This version replaces the use of 'head -n -1' with a grep, and should work on
>> all platforms.
>
> Hmm. I'm not sure what happened, but the version in 'next' has "head -n
> -1" in it.

You mean this one?

commit 31d92611e45d1286b805e362dbc451936af24121
Author:     Brandon Casey <drafnel@gmail.com>
AuthorDate: Sat Nov 1 22:35:19 2008 -0500
Commit:     Junio C Hamano <gitster@pobox.com>
CommitDate: Sun Nov 2 15:58:09 2008 -0800

    t7700: demonstrate mishandling of objects in packs with a .keep file
