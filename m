From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] hard-code the empty tree object
Date: Fri, 15 Feb 2008 09:42:26 -0800
Message-ID: <7vhcgaglq5.fsf@gitster.siamese.dyndns.org>
References: <20080214103256.GA17951@coredump.intra.peff.net>
 <7vabm2i1pf.fsf@gitster.siamese.dyndns.org>
 <20080215172043.GA24221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ4bO-0003se-9L
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbYBORn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbYBORnZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:43:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbYBORnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:43:22 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 58179364A;
	Fri, 15 Feb 2008 12:43:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 6DB043645; Fri, 15 Feb 2008 12:43:13 -0500 (EST)
In-Reply-To: <20080215172043.GA24221@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Feb 2008 12:20:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73966>

Jeff King <peff@peff.net> writes:

> By "it" I assume you mean "the sha1 of the empty tree", meaning to not
> include the {} bit at all?

Yes, that's what I meant.

> I am fine with that, as I don't think anyone has even mentioned a
> workflow where such a shorthand would be beneficial to users. The only
> one I can think of is to represent some tree using diff tools (e.g., "git
> diff --stat {} HEAD" instead of some variant on ls-files), but I have
> never once actually wanted to do that.

Likewise.

> Should I re-send, or do you want to just markup the existing patches?

Shouldn't the previous one that uses the hardcoded empty tree
object name good enough that is already on 'pu'?
