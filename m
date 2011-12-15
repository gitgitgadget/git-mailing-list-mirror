From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] merge: abort if fails to commit
Date: Thu, 15 Dec 2011 10:23:01 -0800
Message-ID: <7viplhofsq.fsf@alter.siamese.dyndns.org>
References: <1323871699-8839-2-git-send-email-pclouds@gmail.com>
 <1323956843-5326-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Miles Bader <miles@gnu.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 19:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFxV-0003B9-Ql
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 19:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab1LOSXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 13:23:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1LOSXD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 13:23:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E20107FB7;
	Thu, 15 Dec 2011 13:23:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ftHu0U
	uOdgCZa50NW+CnOG1bS7dmBfxEt5s3JvgMEJEwMIghPHEem0kDEI521MHseuT4lQ
	5THYx382zyTMdXVm76Pft9NDFBLoCGY9grJZ6hUm/Oju9FmyiRQ31hssInRg31OF
	S9J95sbI1RUn2GdDxD6MSAL46+pluCmODGeFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V6wkBnz/GC8WtcbBhQFpSVerFmsd6yi1
	IPqvfJnEbH2DFxhjwbR0VP0kDBQiLQsq4ROmGwreajVK/FiuWoR2bS2sDoOZN9fO
	uDpL3FQIDBefjTSCjh/JKZA25nJ9VKGnH16ADRB5ETBC14nb+K76PFDmbfJVZK2Y
	XeayHpQoYQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9DED7FB6;
	Thu, 15 Dec 2011 13:23:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C65C7FB4; Thu, 15 Dec 2011
 13:23:02 -0500 (EST)
In-Reply-To: <1323956843-5326-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 15 Dec
 2011 20:47:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2F62EA0-2749-11E1-A605-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187220>

Thanks.
