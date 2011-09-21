From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] abspath: increase array size of cwd variable to PATH_MAX
Date: Wed, 21 Sep 2011 13:17:58 -0700
Message-ID: <7vty851wg9.fsf@alter.siamese.dyndns.org>
References: <1316425872-30457-1-git-send-email-Hui.Wang@windriver.com>
 <7v8vpkbhyv.fsf@alter.siamese.dyndns.org>
 <4E791A40.6040102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wang Hui <Hui.Wang@windriver.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 21 22:18:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6TFB-0004oe-AZ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 22:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab1IUUSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 16:18:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab1IUUSB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 16:18:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12CE864FB;
	Wed, 21 Sep 2011 16:18:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5FCk8ei0rtByWeFpoXV7XNGqw2o=; b=WhsD3F
	5OSDtDIFePLIfvW1rkf1xB5TGfxo5ocPDKguu898aMuBN8Npjfsvf4lKo4siJ0dI
	VZTrX9zsBqQ3WbLdDngpgx03mlaKz2RmAdS2gsnbE2IgNLfZu7jJe+cS05qH8Lht
	9xD3JZhLEDXy4EP73t1pZi/AxAajkeNa6VkgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nl9GQ/Va4Zpe2rpUsEOU/opUn2GfvDhG
	vCsQIpd8OUL+Eb2Ma3KAWALZRpaTfUl27h/WAv1qGIisJ400PLSC9ZduMf1+WgEW
	x+Ti+UUwLOyqBcG+WmEOPsXUHn0h5HpN8bfaSPsxLNpIKq8vmsDN3d/NSxZ8xX8u
	tpDtmZacVWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB6DB64FA;
	Wed, 21 Sep 2011 16:18:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B2A364F9; Wed, 21 Sep 2011
 16:18:00 -0400 (EDT)
In-Reply-To: <4E791A40.6040102@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 20 Sep 2011 23:57:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD6976CA-E48E-11E0-8518-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181861>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Hmm, the subject line says "... increase array size ...", but that is not
> necessarily what this patch is doing! :-D

True; will revert it out of 'next'.

Thanks for noticing.
