From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Wed, 07 Mar 2012 15:42:19 -0800
Message-ID: <7vmx7sj7vo.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 <7vd38okmp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:42:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QV0-0002p2-Pi
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759000Ab2CGXmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 18:42:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab2CGXmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 18:42:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16D0B6868;
	Wed,  7 Mar 2012 18:42:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KiMGKs+dHSIFbdNoO7K9KxRZT5I=; b=f3nqfo
	3UN6ouGYnociAZGV7oSwBQlqGwtQEAYjDL8UsMNclhjHTAsbAtEzjlVDvprWeBKw
	v/b/NAFDkDfNZiiXpg2aF22GfjuvSRQZM5aPlOO0pGVvmH0gALBPKgznPwRre4fz
	zUbbmd52/OeaEAninKHhd/FF00xejtYKZNYIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/rTg0xm3trgFX+cpjWVx0m/m3vo34DV
	qz+OcChiyBKGRZD9ATlhumuxmGEJyYJbuXbwM8gTJKYQ/llf52f1kVIdIbfLWfHD
	bin/gKida9nXlK6YxpE/Rdt5eDbudAyizIktZDbAZunvG6Ib8Q+sArfyxwZ2pzAm
	NeCu7xqENC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 051016867;
	Wed,  7 Mar 2012 18:42:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D68F6864; Wed,  7 Mar 2012
 18:42:20 -0500 (EST)
In-Reply-To: <7vd38okmp0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 07 Mar 2012 15:36:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E767D24-68AF-11E1-8131-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192508>

Junio C Hamano <gitster@pobox.com> writes:

> +		say "We error behaviour your system shows"
> +		false

Typo--"We do not recognize the error behaviour your system shows"
or something.
