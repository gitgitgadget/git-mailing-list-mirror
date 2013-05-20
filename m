From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/3] Begin replacing OpenSSL with CommonCrypto
Date: Mon, 20 May 2013 15:52:56 -0700
Message-ID: <7vfvxhs1pz.fsf@alter.siamese.dyndns.org>
References: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 21 00:53:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYwz-0004eb-0x
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216Ab3ETWxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:53:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab3ETWw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F02F620625;
	Mon, 20 May 2013 22:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BPhMGJ+93GYRyYNsHgmhM+zMn3Q=; b=JRTZeZ
	H6V5hqJXuZihPLNyjt/3g7aozdPSc9W5caOxfqMranWqFk1R4H1NPhkakK0t38yc
	Wr1eFxT8F1ixpe8SkiNyyA1WhpKF/GjXTLnKL86qMUPQ2S8DU4KdCkjd+vgUC4Bh
	5QxgKQF2rkzcHWwsmHDPOb7aEauEjvQH91LGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HPbnXp3pW5ywfaZRjQJSf8+rEzItofXx
	wM7Sa/q4QQd/OKyQPa922OgS4KH+vqriylWP+Mp4jFgEhDlf6N4NCa3rCinrzlwg
	ifQ/UKhDfqYLIfw42FXyaG/ujXO14Fm3btGvh/t2T0Eb/VN/zSsU6WsDkMKCIt+k
	dSqvIykt/cY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E519820624;
	Mon, 20 May 2013 22:52:58 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6992120623;
	Mon, 20 May 2013 22:52:58 +0000 (UTC)
In-Reply-To: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 19 May 2013 06:23:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 043AD172-C1A0-11E2-85AC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224997>

Thanks, will replace da/darwin with this round.
