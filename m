From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] do_compare_entry: use already-computed path
Date: Mon, 21 Dec 2015 15:27:38 -0800
Message-ID: <xmqqzix3e61h.fsf@gitster.mtv.corp.google.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 00:27:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB9rl-0007Yx-N5
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 00:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbbLUX1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 18:27:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751572AbbLUX1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 18:27:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F09B35A63;
	Mon, 21 Dec 2015 18:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kx7+oh4IA8DS82viKW6gxumwikA=; b=mFXsl0
	NLYc2fdaNNEB+iYtTUcevXBw9jQtyyPE2jTuGnHUKQFpP137Xw21ON6MRGA6ox61
	pvm+JsXAkZZQqG63REfPrAf4RR9EHlxrkEVmeHbYhZ2N+0dp7lPB/Vjec6dBMIpw
	9HPchNEi04sUHPbz0E7IlpgDJIgvr5j4AdGfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E8TpewDzEtRWYI4ktaPsHnozQPpdMZf7
	/pIaD8C4obDQYjkHerZortAndGBrfvSE0TriWnO5XKfR+qAaB2xAxLA6A4iU68v1
	RoXIz4AZPfXQyGOydxWaIu6CBBkdYuzbSsm35oyjkafv/JcTFhNVvlFdekO2ZI17
	b+Hnx83PTHE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27C8535A61;
	Mon, 21 Dec 2015 18:27:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9C1CF35A60;
	Mon, 21 Dec 2015 18:27:39 -0500 (EST)
In-Reply-To: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 21 Dec 2015 17:34:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D17EC9C-A83A-11E5-ADB3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282824>

Thanks.  Does the number still stay at 25% improvement?
