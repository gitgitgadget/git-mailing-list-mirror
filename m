From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Keep together options controlling the behaviour of
 diffcore-rename.
Date: Tue, 16 Nov 2010 09:31:14 -0800
Message-ID: <7vtyjhi3a5.fsf@alter.siamese.dyndns.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
 <1289420833-20602-3-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 18:31:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIPNj-00038a-DQ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 18:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab0KPRbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 12:31:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab0KPRbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 12:31:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AE703BCB;
	Tue, 16 Nov 2010 12:31:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PYtGtoSnxteDKOPi5afRU8hysmQ=; b=fNdz58
	yd/tGxm4gyJ765dEEuOBkyjSSOMmN2MXyKXQKwqnEPO9HyefVfwzmi2MeeRSC/02
	VNPMTg7zdd5myOHRik52VZcYyV6EJE3Zx9GjZfmBjfWYGczefHPmIxTfiDu/Ac55
	e/ppoFMgHP6vBD6qHtLe5XeVFqlwP2P9SuOLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SOexjQxsuxj6cbidyXkcSpv1X7/CiLC8
	i4LmtMlb/6AUBQpbWBBdflo59664UxzhxqJsNkliyP66X6TVPW7DLsvtUqOXUDl3
	MESxXS+QMn1auDaKAP7zP6M3WGENZ0GzOrfboMHh/GjJkPwcUyEARa9TY3/C45h1
	NdFl9AQQicI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69E413BC9;
	Tue, 16 Nov 2010 12:31:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C7753BC8; Tue, 16 Nov 2010
 12:31:25 -0500 (EST)
In-Reply-To: <1289420833-20602-3-git-send-email-ydirson@altern.org> (Yann
 Dirson's message of "Wed\, 10 Nov 2010 21\:27\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5812EF58-F1A7-11DF-9CC7-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161567>

Yann Dirson <ydirson@altern.org> writes:

> It makes little sense to have --diff-filter in the middle of them, and
> even spares an ifndef::git-format-patch.

Makes sense; thanks.
