From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 04 Mar 2010 10:26:42 -0800
Message-ID: <7v635c6izh.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <6672d0161003040026u6d1f7a69h20566924b9ade43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 19:26:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnFl9-0007gO-Qm
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 19:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab0CDS0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 13:26:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0CDS0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 13:26:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 871909F8F6;
	Thu,  4 Mar 2010 13:26:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=E/0DmvdrVcNY8h3bRdQaBIUvJ
	zg=; b=QbEiVFdL0sI5G0FnQKHA/AEI3Bfeig8njSOl5he32T+uXyNS30j1fNaPB
	Qy2ZtIocXHfbQDGtfWNeIPMXMotbUKx08yLbdOgIEjheYutCJYplLctMLKPGbJI7
	HuB37WihAzt5Q6zfHNQXKFzefFGH26rCUct/6MTMlyjIFInxaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EDiDcO4XJ4iJHw7weAy
	VrZNzs9z9Tc7fmJUve/LaohIkvGp1+nE3/pHvLWJVO5+3ejMNwarjlUlqqTLf6Uu
	xMQ9hrXLgPwT5957krm3cRDmaD+nR2w36Pd3fqY/qxPibuaMbKu3P7bnCh6a2SXl
	yZB1t3t36mS+6gioIENrbZvI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6230E9F8F1;
	Thu,  4 Mar 2010 13:26:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD7A89F8EE; Thu,  4 Mar
 2010 13:26:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D94E92C-27BB-11DF-A336-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141539>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> If both --whitespace=3Dfix and --ignore-space-change are given,
> new blank lines ending in LF may be added to the end of the file.
> That is the expected behavior if the rest of the file has
> LF line endings, but not if the rest of the file has CR-LF
> line endings.
>
> I think I have figured out how to fix it and I will send
> a patch as soon as I have actually implemented it.

Thanks.
