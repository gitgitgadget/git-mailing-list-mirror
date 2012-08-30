From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] checkout: reorder option handling
Date: Thu, 30 Aug 2012 09:10:33 -0700
Message-ID: <7v7gsgtl6u.fsf@alter.siamese.dyndns.org>
References: <1346248524-11616-3-git-send-email-pclouds@gmail.com>
 <1346330750-17937-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T77KN-0005T9-Ga
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 18:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab2H3QKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 12:10:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab2H3QKg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 12:10:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0DD17C29;
	Thu, 30 Aug 2012 12:10:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VIVhb4+kkMpK
	bnq6beCX/LsrsjI=; b=xccnlWvHRNqA6QVxkk6HSMq0duQ/3S8dbmuHjCMkxL9N
	dvHY/C8kkjcjTC7fg/lo1VVFCliFE+icx8rsczvN18UJ6pGXSXg8Gro8UqWSR7eE
	pkk3Lic7HrfmvKRRDSbZrvSpXenx9RAvVuxqK0qKXLxv70fhS6Vk/ycK7g9Ba8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ONWuQJ
	WUvkS7Ems07Ho/BaJH2TphNwbwOk/SXGuz6AosV87Idjhz8v1vy9oG9Lt1aFxfRC
	5llE9v/G1tYovND7En6o31PbGAy9uvLq84cisk6cZMEUbsUVCNqGKktrEBkV59qO
	PPMtva0ggwu8Neck/yRq9+pNlo7wpAafg6K8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E9857C28;
	Thu, 30 Aug 2012 12:10:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E57D7C26; Thu, 30 Aug 2012
 12:10:35 -0400 (EDT)
In-Reply-To: <1346330750-17937-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 30 Aug
 2012 19:45:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B0D9D90-F2BD-11E1-B36A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204545>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  Changes since v2 (the first two patches are not resent):
> ...
>   - merge cmd_checkout_entry() into checkout_paths()

I didn't think of this when I reviewed the previous one; I think it
makes sense.  Thanks.
