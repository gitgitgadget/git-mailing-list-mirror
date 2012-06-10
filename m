From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH_v1] add git credential login to remote mediawiki
Date: Sat, 09 Jun 2012 23:54:09 -0700
Message-ID: <7vvcizac8e.fsf@alter.siamese.dyndns.org>
References: <1339268028-13991-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 08:54:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdc2R-0002Uh-NE
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 08:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab2FJGyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 02:54:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2FJGyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 02:54:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AF9A38D2;
	Sun, 10 Jun 2012 02:54:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PKf9VxXCwXfzE2LTqja1gaHtF8c=; b=rP6Pcx
	4ePveksFx4V1vEjZZ0CYBMgFZf8xSv/ATvex7jHksTuDiBOHB10wA+L/YnOcaxld
	K/ru06alc9MYeRHnGPfMwoip/Q6CDvf0vhN4JMEzrBTqML3Snsu0CwKBSr17lwqz
	KWB/erxhj+yUB8xYsm5xH5/n6/sPGBJ9+5Dho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q5/Tf1I1gEEkV26Kc0OcMG9Wl68HpZ/N
	87ba74CVdp6trMUR0bCgiuaAMP09Du/dUKwpDobjsXdufk/mL6sywlilP1u4p6P4
	LQ1APhSNRQyq3o4PNE/wFZUYfWa23o4RhbSEf5bN1Kv1zEYTMnrCQpqRU6xFuilN
	NMtaJzsw+W8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E7438C7;
	Sun, 10 Jun 2012 02:54:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B210538C6; Sun, 10 Jun 2012
 02:54:10 -0400 (EDT)
In-Reply-To: <1339268028-13991-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 (Javier Roucher-Iglesias's message of "Sat, 9 Jun 2012 20:53:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14F58F8E-B2C9-11E1-BB23-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199570>

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> Subject: [PATCH_v1] add git credential login to remote mediawiki

Please remove "_" between "PATCH" and "v1".
