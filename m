From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] git-remote-helpers.txt: document invocation
 before input format
Date: Wed, 12 Dec 2012 15:13:08 -0800
Message-ID: <7vwqwm27az.fsf@alter.siamese.dyndns.org>
References: <1354057407-83151-1-git-send-email-max@quendi.de>
 <1354057407-83151-2-git-send-email-max@quendi.de>
 <CAMP44s3vO9b4-XxqatEc2w3KJLqLGgyjPuKpQkAXHQwTJJEQTg@mail.gmail.com>
 <839EECE2-4459-4358-B7E8-5D64374A0540@quendi.de>
 <CAMP44s1xetknwdOT5EseuASQE_2WFP1e1-Ao2RWYeya+EJ9SfQ@mail.gmail.com>
 <A0E9390A-58CE-4E3E-A1A6-2D5CDB62FE06@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:13:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivUW-0006Zs-GG
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab2LLXNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:13:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab2LLXNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:13:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 986A7A51D;
	Wed, 12 Dec 2012 18:13:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nf2FIEylUH2sWcpUlFiKXztxKGI=; b=FrHj3S
	HoJyGYZtrsDo/nXaolGVbiZZj+4ePPPnfrqP5URKDpfuWy3AYy73m8qOoSbm/Zhj
	QonBJTpofr0cZWo2YdnfGz0UrAJ+7QoNxT7wIFW2CSD8FSKOAZi8EUOEq6inWk/c
	G1ueWBIsxHTFZRkKOlXFNNVFBHAB74jBpUF38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xpu0fLgMj5izl293zKZJ33wAJecmbGxY
	TiSckjbdrIs63u5g9rKb4vxfSfC5zRyfBGuEoSUE8UHLNqxcDw4hJA/JTNzUotj8
	qkL/KxusGFaYrss04dTcoUwRioyzMYdWMHPrwRYt+u97MN7CNHduCloqxoT2O/AM
	Q0scB8TWHkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 853CDA51C;
	Wed, 12 Dec 2012 18:13:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03723A51A; Wed, 12 Dec 2012
 18:13:09 -0500 (EST)
In-Reply-To: <A0E9390A-58CE-4E3E-A1A6-2D5CDB62FE06@quendi.de> (Max Horn's
 message of "Thu, 13 Dec 2012 00:05:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EB4E346-44B1-11E2-819D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211415>

Max Horn <max@quendi.de> writes:

> Of course I can also re-roll, if that is necessary/preferred.

No, you can't.  The topic has been cooking in 'next' for some days
now already.
