From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] staging: brcm80211: SDIO/MMC cleanups
Date: Fri, 06 May 2011 07:37:51 -0700
Message-ID: <7viptn3neo.fsf@alter.siamese.dyndns.org>
References: <20110504165947.40EED208186@grundler.mtv.corp.google.com>
 <4DC3B086.90802@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Grant\@google.com" <Grant@google.com>,
	"\"Grundler \<grundler\"\@chromium.org \<Grundler" 
	<grundler@chromium.org>, "Greg Kroah-Hartman" <greg@kroah.com>,
	"devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"Dowan Kim" <dowan@broadcom.com>,
	"Henry Ptasinski" <henryp@broadcom.com>,
	"Venkat Rao" <vrao@broadcom.com>, git@vger.kernel.org
To: "Arend van Spriel" <arend@broadcom.com>
X-From: git-owner@vger.kernel.org Fri May 06 16:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIMAe-00054t-SR
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 16:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab1EFOiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 10:38:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab1EFOiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 10:38:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 415554EF3;
	Fri,  6 May 2011 10:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jSz22P8vxg9bbDZfwHOzLkimxgM=; b=K0dYFk
	2X8XQ70nSzDrmvxH+Lc96HRB25aVNz/Rawl+sEpI9gIVaYjrVoddmUemmP2aUeE8
	Y97O/6B18JHsZIk7oP9+HdhZXfYqzc1hnqE3D3GPHAbuHNJ+f06/OVPyAq1tCQmy
	0EcX0MFh6Rc+N7Vu2mUBbrFm7maBRNa4Vxc+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vmo+OyfBEeK9Fb6xrwOPywyqLWF0XdmI
	QBF4j319jcWqYpK3ruF5CSl0a4JrYHVglR3Fj+Do/qg/iXyEu0uttYF/ZRSj7bBn
	NIX6y6pqXL64ByUSeEGkhKoUm39jencufnubHzjrbqMt4Jm2DhviYRQY/dXB++BP
	+sFuXJS6JEQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A10654EF2;
	Fri,  6 May 2011 10:40:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E1D04EF1; Fri,  6 May 2011
 10:39:57 -0400 (EDT)
In-Reply-To: <4DC3B086.90802@broadcom.com> (Arend van Spriel's message of
 "Fri, 6 May 2011 10:25:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD75DBD0-77EE-11E0-B267-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172978>

"Arend van Spriel" <arend@broadcom.com> writes:

> The git documentation on the git am command is not very elaborate. I
> investigated the issue and checked following:
> 1. line 135 in dhd_sdio.c in the patch does match line 135 in my
> checked out branch.

Does it exactly match, or does it merely visually match if you ignore tabs
and spaces munged by somebody between the state of the file submitter
committed and grunder.eml file you stored?
