From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: remove unused "create_full_pack" code in
 do_rev_list
Date: Wed, 28 Jul 2010 10:23:12 -0700
Message-ID: <7vbp9r5xmn.fsf@alter.siamese.dyndns.org>
References: <1280309950-5597-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:23:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeALn-0002jS-Oa
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab0G1RXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 13:23:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab0G1RXT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 13:23:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5207C8C30;
	Wed, 28 Jul 2010 13:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YBgA3iMmFisjNcy8tHObpNYGi
	hQ=; b=hHCp6hFrI7U4tzGvZb1s5MR84pQW0VPGkzee+4Y4xwVEC6md9t8bZaqlx
	v7QmBGOY/J/i5WzF/QKKykomuW6XbWdjt36fH//AU6kblq/rAxhAYtH97PlpLNwO
	LqM+GF8IleriQC0bHm21yxDYX7ZkutYXbGkvQe200UfUK8eFh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=gcL0pFxH26qmK8KLy9s
	op8RPM4QoWB5olda6WYFF9nYY1cA1YmZDfVUpRJvj1E3l/xkv6OLmALfcUcWV1z6
	UGmI6tRoKuglMq5N3dz4/JvqKxvSkMSYlWkFoTh35vsuc+QXs+nhUXHu4R5gPdGO
	jmA2uPdVTh0fwSjSB6zL7Y4k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F099C8C29;
	Wed, 28 Jul 2010 13:23:16 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1945C8C28; Wed, 28 Jul
 2010 13:23:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF06F11E-9A6C-11DF-84AD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152103>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> A bit of history in chronological order, the newest at bottom:

Thanks.
