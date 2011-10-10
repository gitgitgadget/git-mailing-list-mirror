From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Sun, 09 Oct 2011 21:58:26 -0700
Message-ID: <7vwrcdo32l.fsf@alter.siamese.dyndns.org>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xsnAv4S8zAqi08bcqrghZ8nKdzFP=UNCqZOqrEeLFnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 06:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD7wi-0001xr-RO
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 06:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab1JJE6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 00:58:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab1JJE63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 00:58:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDBD86EE3;
	Mon, 10 Oct 2011 00:58:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YiN/vvJ9l2mC
	3DM8wIIFt7bmVgw=; b=vNNunJ9pdck4ECX3aVqNd6NX8Aac8pvRNDP3vcEuFfba
	9bHT4+Cq3HKf1nKsWLGfyKuvEHUYe4Mmmc3WWl9IibXurOz2rBonT8BDo83kxfcz
	4nwsuVksTqltpyRgpI+o10/Sd9C/mjjQM365vgzUeajoPaNRDv5yQS3RiJvjWrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eKxqSF
	x4dCrBsXPCoo0wkaHKeVxV/FNCh4BZYa2Z8XGX5MlmEJI8/pJrv3iJUqg82xDbXi
	eVkqeGJDqb5su8mDIpvwz/9NL+CzVw4XqjBIXaahB8AROaWdvw7/NL0fmvOX9Q++
	Rp3rD/6J/4ROz6J168lD3MjiR+q/G58HrNh1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C50AE6EE2;
	Mon, 10 Oct 2011 00:58:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 399116EE1; Mon, 10 Oct 2011
 00:58:28 -0400 (EDT)
In-Reply-To: <CACBZZX6xsnAv4S8zAqi08bcqrghZ8nKdzFP=UNCqZOqrEeLFnA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 9 Oct
 2011 23:29:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E1A83B2-F2FC-11E0-AAA1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183221>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> A nit: no other commit header is an abbreviation, it would be more
> consistent to use "signature" instead of "sig".

You are probably right.
