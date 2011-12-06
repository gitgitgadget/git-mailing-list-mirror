From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 06 Dec 2011 11:12:12 -0800
Message-ID: <7v8vmph5v7.fsf@alter.siamese.dyndns.org>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <CACsJy8AmwQxcKz9vhtvFJPPKpXeipufD_0OqoMv41SHQFZgqeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 20:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY0XP-0008TA-4D
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 20:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab1LFTS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 14:18:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab1LFTMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 14:12:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C109B5BEF;
	Tue,  6 Dec 2011 14:12:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4CJD91YrQwi5w6A39GfmcGYmcSs=; b=pi8FEr
	vFbA/mWN6d7Cznl9lJScNa+MGrA/n5YJrrtbn80RrWqP5FDUciRq30VL3lQFqGQm
	nLUlrlzDF5PChonm383l99CZy30ickVEhBNj8gpmjUQ1ryeq3sjKVuqKiO3D5kR/
	GJYF5UsUy3PgmKeG3iQXpuiZ6lr47Ku8cH7hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7q3yjNBJbbEWmy8De0dy/8wiQ3jXail
	OFPWKm+gBhztto02oJYFnd+wfP/Lz2Kmx/h6E3LOG+6iVPhPXxmwqAfmoSW29esQ
	LmKuoiGywWU27xGW9lNRNdhjZXZyHQ3wleesPVbSPlFmQV/tvtqFtRZNWUu8WNEy
	vi+DMvyb1JU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B88865BEE;
	Tue,  6 Dec 2011 14:12:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 505895BED; Tue,  6 Dec 2011
 14:12:14 -0500 (EST)
In-Reply-To: <CACsJy8AmwQxcKz9vhtvFJPPKpXeipufD_0OqoMv41SHQFZgqeQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 6 Dec 2011 21:01:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34C7A3C4-203E-11E1-BF1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186374>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I thought this would be replaced by a new version [1] I posted a while
> ago (and forgot to address comments). Do you want me to rebase that on
> top of this or replace it?

I think what was merged to 'master' is already sane. If you have updates,
treat them just like other new topics.

Thanks.
