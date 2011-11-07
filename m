From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] fsck: print progress
Date: Sun, 06 Nov 2011 20:33:03 -0800
Message-ID: <7vsjm04kn4.fsf@alter.siamese.dyndns.org>
References: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
 <1320634766-24511-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Stephen Boyd <bebarino@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 05:33:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNGtZ-0005ct-3D
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 05:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab1KGEdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 23:33:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab1KGEdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 23:33:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E6796853;
	Sun,  6 Nov 2011 23:33:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dXEiOJYLOZjPMdwiVyzYU5TRX/Y=; b=P/1mBv
	N9AVAyQU6zzLzdletfiAK5DCsKUvuwza9izq7bcywYXaVwIAasirgDUNZcoSMTVt
	8DQbP3PwPX8+97y2jozgvTUdkpTDYnbr+ywPvAhjLifBE/8Fh3oxee9VcSY9biOi
	iJpmVas4RWUwZW44puzOvGWIKXCnPDscKUdBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfUFeMk4vgODLqYPcTBrg01SOQW8d9VU
	8kgKxGKmkWh37nfao8Fnj2956gYcuPXWQIn9HtODgS+mzO3gbGwygw/wAGIMi22i
	D5AL0uK+soAK90tsbNT3J/ATj0Y3hXh2BKGOMtmd5us1XathN16BHj7nwgGYX201
	+mmZtKMW/2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9051B6851;
	Sun,  6 Nov 2011 23:33:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20A0A6850; Sun,  6 Nov 2011
 23:33:05 -0500 (EST)
In-Reply-To: <1320634766-24511-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 7 Nov
 2011 09:59:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95D4B5E6-08F9-11E1-ADF8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184945>

Thanks. Will queue.
