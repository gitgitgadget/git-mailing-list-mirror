From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] null sha1 in trees
Date: Sun, 29 Jul 2012 15:15:11 -0700
Message-ID: <7v8ve2uscw.fsf@alter.siamese.dyndns.org>
References: <20120728150132.GA25042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 00:16:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvbmI-0000Xu-DX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 00:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab2G2WPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 18:15:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab2G2WPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 18:15:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05EC982A8;
	Sun, 29 Jul 2012 18:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bclmy0XRkJoppV/irQmH5hhfFI8=; b=n2Xpid
	dXFKGB4ayadUTjSeqvzCNvxt/u38xTVTgY4nFB1WoFjYJSZqVHHCcuMI26JZn5SM
	0nZNaJ9Ql8AGwJAZZtnWwvWGDRFosfXYQ8++pff+7TzYMifLOMXU+UlVNpihfRAT
	Hnvnwj16pAw4AJ4qr596eUa8UcqTG7SC9jFtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fM02h5kco2eY40SSSTO22xwn/5KJDt0H
	eQRzV36HJXXAbESw+IU3FK73HstRXJgxdpndWT3l+MM5E+nvsjva/HePgNwkzQ4g
	jsR5Cb5qDGAfceTRa/ND+5661z5JjA74CF1QMdAS5LE3aWiutkhYcovdmiFJNfiT
	HLrCu2B2MFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E745B82A7;
	Sun, 29 Jul 2012 18:15:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 651B082A6; Sun, 29 Jul 2012
 18:15:13 -0400 (EDT)
In-Reply-To: <20120728150132.GA25042@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 28 Jul 2012 11:01:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE4FD786-D9CA-11E1-8C63-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202504>

All looked reasonable, even though I'd want to read the
surrounding codepath over for 2/3 a few more times.

Will queue; thanks.
