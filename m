From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: Fix Accept header for smart HTTP
 connections
Date: Tue, 12 Jan 2010 22:55:56 -0800
Message-ID: <7v7hrmtrwj.fsf@alter.siamese.dyndns.org>
References: <20100112175404.GE1173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx9D-0000sE-Kv
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab0AMG4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937Ab0AMG4E
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:56:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab0AMG4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:56:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1318F90019;
	Wed, 13 Jan 2010 01:56:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=aTHHbTxyHG3el9t9VlbJ+kB
	hJlIYKWyDp20oSQIT7WWvutJfOEdJY+hesqxAPVP84hBnJ2vV7amkr/Lb2qDNpjC
	7oIakTyt/tkvRmMpYWJ3Kmgti78iRdTSnbmfhE8qfAf6000RJMxbWh5866X2zhB4
	qVjMK4838kYBKBsQ/kjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=puHbfa4X7VM0as91BUx26dBiD1qV1BczeAf9uqyBs9yYQiot8
	68a16OjmcYUsVDuHm9VNJIQzclO+mLiqhndkXXgvgzex17GFxGJQR8G78n21IC6l
	j6vBL+CHK2qRatOC3WaOG/S6SgTiBAjK3EqZwaC6zVm3ALm/Or1opclwoo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2B7390016;
	Wed, 13 Jan 2010 01:55:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F57990013; Wed, 13 Jan
 2010 01:55:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4E828EE-0010-11DF-8AAF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136777>

Thanks.
