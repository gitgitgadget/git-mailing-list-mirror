From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] Makefile: detect when PYTHON_PATH changes
Date: Tue, 18 Dec 2012 16:14:51 -0800
Message-ID: <7v38z2ew3o.fsf@alter.siamese.dyndns.org>
References: <20121218190009.29910.39426.chriscool@tuxfamily.org>
 <20121218234202.GA13151@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 01:15:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl7JY-0008NN-97
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 01:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab2LSAOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 19:14:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945Ab2LSAOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 19:14:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28557AF35;
	Tue, 18 Dec 2012 19:14:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=DWKkNx
	NdZ4yf/FynnNnewteKJ32iI9Wjv5TkrMzy4iJtdyVVhwUAeW2m3eX6E8jyeA7h6d
	1kl9Dvn/V9r05FF5Vc1cHgMV8n/ru4Yn0mOoQpzQnBQkKJhAwqbvX2cQfbUsL6WC
	7FcxKKhDw8g9n77oMrecXStrFyEw51ttvMaa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iaCgjf4TQAehmq0xiT8TLHCwp1pAn+du
	qAecOglGS/5ortppcn2bmknCYNIgBva68xIamXc8LftX2il13I7Gv5NkyeR17Eds
	xjWjQ/gkRaqxNcbrqHifUZDxYCeLQs4bU3tA+SYgAUPFXG/ln0C4k3pmpGtw3tEN
	GwSBHKkGykE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F2A2AF33;
	Tue, 18 Dec 2012 19:14:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E008AF31; Tue, 18 Dec 2012
 19:14:52 -0500 (EST)
In-Reply-To: <20121218234202.GA13151@padd.com> (Pete Wyckoff's message of
 "Tue, 18 Dec 2012 18:42:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C0C4788-4971-11E2-9C63-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211796>

Thanks.
