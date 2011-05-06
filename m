From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplicated "is a"
Date: Thu, 05 May 2011 22:14:26 -0700
Message-ID: <7vtyd82yx9.fsf@alter.siamese.dyndns.org>
References: <1304614634-46181-1-git-send-email-jabcalves@gmail.com>
 <1304655377-57638-1-git-send-email-jabcalves@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jo=C3=A3o?= Britto <jabcalves@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 07:14:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIDN9-0003gx-Us
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 07:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1EFFOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 01:14:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab1EFFOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 01:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 939852083;
	Fri,  6 May 2011 01:16:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eWgJyyk3PEXsDGMvgMtgcUUCAk=; b=UnIJsA
	/rvj+G1J9x/oLACnvRagz4NqUcjIpFgMJupqJ86Yr1ZbzDtq3AEq/WcgRJT1AaeF
	aFASGgRDCaI82C541VljAZitBfVHW9wvNQwE9WcIRbBwtYzY6/uIVh05JwzBAdsn
	rP+GtP/uxGZWF4nf+BT40dQentNyMSu0Er8Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yERQvhAi64e9sTWBHkHgyzFeYGyqKDHi
	F7XS6b/LtvGQgARNnZhO+EkhDQGq7Y45EJkuPPmGwaInjjTaWgc37Sr3DwbJgDCD
	nKGqngaxZ1dwelAE0N+90SD6xKTDEDfJIYbC4L+k+F347MQAIW8DUCoY4wKqtdch
	oi4BPF8+5Zw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70736207F;
	Fri,  6 May 2011 01:16:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 90ABD207E; Fri,  6 May 2011
 01:16:31 -0400 (EDT)
In-Reply-To: <1304655377-57638-1-git-send-email-jabcalves@gmail.com>
 (=?utf-8?Q?=22Jo=C3=A3o?= Britto"'s message of "Fri, 6 May 2011 01:16:17
 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02A142DE-77A0-11E0-9931-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172941>

Thanks!
