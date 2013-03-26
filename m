From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Mon, 25 Mar 2013 18:46:55 -0700
Message-ID: <7vli9bue40.fsf@alter.siamese.dyndns.org>
References: <7v8v5b1nlp.fsf@alter.siamese.dyndns.org>
 <5150E1C3.9020609@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 02:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKIz7-0002EU-31
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 02:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab3CZBq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 21:46:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab3CZBq6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 21:46:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF02BBB7C;
	Mon, 25 Mar 2013 21:46:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XUW8sHM7Tq2U
	W0zsMop8tn/+QEA=; b=HhskMA00f4svLUr3+rdTg5i20K38Zrh3MsfDEJ3gGjz6
	VIctt4YdCi8abiqHgDovJPKOPEKaUVgJqfBsIWVjRr7HpQskXdeFCxu59FmFxcUM
	BlSE9wvjyTdRXbrv79QDYclttx7dRQAu1xhT69UqAsV9cXmTaHtBysM0HqiYsao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RMZAs1
	oK/pGMFc8NM4vWcWvN1lorbQiIzezqz6qVOcFVwRGXRBt4pb2xYIsfU08shV5BhO
	84rSE3qSwKKwTU8HxhkyKpnl7MuacqC+NtCUEx0ugPHjlWyREyaDDcndIVseSYel
	v9n9ajKXJbh6VlCLGMFrd619Y2wtNkrV5HilA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B44D1BB7B;
	Mon, 25 Mar 2013 21:46:57 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CAC3BB79; Mon, 25 Mar 2013
 21:46:57 -0400 (EDT)
In-Reply-To: <5150E1C3.9020609@physik.tu-berlin.de> ("Sebastian
 =?utf-8?Q?G=C3=B6tte=22's?= message of "Tue, 26 Mar 2013 00:46:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B1349F8-95B7-11E2-8C60-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219127>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> Rebased it onto the current 'master'. The second patch fixes that the=
 GPG
> status parser ignores the first line of GPG status output (that would=
 be caught
> by the new merge signature verification test case).

Thanks.

Does it still make sure that it won't be fooled by the expected
string appearing in the middle of a line, not at the beginning?
