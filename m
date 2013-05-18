From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diffcore-pickaxe: make error messages more consistent
Date: Fri, 17 May 2013 18:25:13 -0700
Message-ID: <7v8v3dw03q.fsf@alter.siamese.dyndns.org>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
	<1368793403-4642-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 03:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdVtn-0004GL-FD
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 03:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab3ERBZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 21:25:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457Ab3ERBZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 21:25:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C940114BE1;
	Sat, 18 May 2013 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=YkQW9NDtUr7wIKm4NQcAwbF/VSg=; b=TyIeOjzm0ulP5hl90uxP
	CFWnVrIMuxg2+AT0yUf4rGT8DLNe3+5VfoUx8xu1MZJPuarq0fi3wQ48xi7SPOgx
	/KQgmkCRPERSlLVS25dUz2tgYZLyoEkQqRu4cDBe2DN6fYs/kHsdQfoK0yeCdSGN
	9xWxxnzjyJGWoEx97Db/GCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nMFJEacFglPTRGealugvr+waxfZXa+Z9B0PksSZeLip1bF
	8feUhxkn+FrAegTr7Qs5ODJD+yZFHlVHsotsbYfvxDdTe1JYbgHiqK/oNpcuzRc9
	Pj6UI8VgKirIGhTj78FZ4g4iHU5GQuyh1fZ/ep2n6Ekv4tkU8O8MpLjeeyZPQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEC6B14BE0;
	Sat, 18 May 2013 01:25:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C39A14BDE;
	Sat, 18 May 2013 01:25:15 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAF48E8C-BF59-11E2-9D56-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224749>

As I already said, I think calling this as pickaxe-regex is wrong
("invalid regex" is fine, though).  More on this in the review for
[2/2].
