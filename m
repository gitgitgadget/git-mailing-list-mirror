From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL svn-fe/maint] t0081-*.sh: Fix failure of the 'long read'
 tests
Date: Thu, 26 May 2011 09:03:22 -0700
Message-ID: <7v8vttzbxx.fsf@alter.siamese.dyndns.org>
References: <4DB70972.20308@ramsay1.demon.co.uk>
 <20110426234850.GC32491@sigill.intra.peff.net>
 <4DBC45F9.7090804@ramsay1.demon.co.uk> <20110526043335.GB17479@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:03:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPd2F-00080Z-DK
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120Ab1EZQDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:03:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab1EZQDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:03:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A07334B63;
	Thu, 26 May 2011 12:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O1Kw0EWDfhT6tPVxRD08v4pQsss=; b=QyrndD
	eTy/cUdBU9jjaA86Cfa9SgL+SiiSgtO/QpzQMAACWDaMbuex3DW+LPUyyw+zU5RM
	dO5GMiw/nVcbPtcgeCZFgWQT0VaoNxMxRbXMNwAxGxRByeNBooQUeWx5nWXJUV0E
	V24KPpCH3STTboPzwL3GtY4hqD80HP0gJJw7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9gOprihvvBxTx8x3JPtdJqIQjV+ALlu
	xbocD5kEWv6Yl0/hwRVTXXvMjeAsdXbxKZ5WjtsNsEbo0ENwpc7tZq/X0gtqPMnr
	fZdTgAJmrkjN8EPQrQ7/TAbgN1up8eeNGzEck7NXEkIgcXQRAN75rjAiYeIbsTSz
	TGBVt/z5+68=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B4774B5F;
	Thu, 26 May 2011 12:05:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8B4794B5B; Thu, 26 May 2011
 12:05:31 -0400 (EDT)
In-Reply-To: <20110526043335.GB17479@elie> (Jonathan Nieder's message of
 "Wed, 25 May 2011 23:33:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFD1EBD6-87B1-11E0-985F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174538>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio, please pull
>
>   git://repo.or.cz/git/jrn.git svn-fe-maint
>
> to receive the following fix.  The patch first visited the list two
> months ago[1] and was discussed again last month[2] and seems to have
> been well liked both times (well, I know I like it).
>
> The tests it removes
>
>  - are missing an EXECKEEPSPID prerequisite on Windows
>  - use a : $((i = i + 1)) construct which does not seem to be portable
>    to old versions of dash
>  - are pointless, an eyesore, and a pain to maintain

Done, and thanks.
