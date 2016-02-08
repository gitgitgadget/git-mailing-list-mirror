From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Mon, 08 Feb 2016 11:07:24 -0800
Message-ID: <xmqqvb5z81hv.fsf@gitster.mtv.corp.google.com>
References: <1454739816-24007-1-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSr9p-000579-1q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbcBHTH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:07:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753563AbcBHTH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:07:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B72F840EC4;
	Mon,  8 Feb 2016 14:07:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=OE0zrw
	KL/p1kQPF8c4JD96n7Rs5juPhlgvup3w2PZ/6c5GrD8+OCJgyg1jiWhocBDUlXcF
	x1IO6MRA04dGnwuOMplBGBiFnTwj/EEXBqhATe5ENLnMOP5+M/4kKMAOHaKMi6U7
	z4Cyu+fLTGQlLoyUomQocBSyYS+YicfozCE7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKXTUz2GKw2/LQAFOG8ZMtPbZ2TMcXq1
	VFd+H8mHzBz4B3QgApqa+rN78IvuNmqLeEcZONnv7iagnVt4ioxdNSuGTbKsSPuS
	QW2GlA9uxdIG0Uq9quwnqi7O+tcfaM82qNgglCxcLc5EYf5KKC51KnM8Q8M33nYt
	iCt9M2R6xlw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF2D540EC3;
	Mon,  8 Feb 2016 14:07:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 309AC40EC2;
	Mon,  8 Feb 2016 14:07:26 -0500 (EST)
In-Reply-To: <1454739816-24007-1-git-send-email-alonid@gmail.com> (Dan Aloni's
	message of "Sat, 6 Feb 2016 08:23:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30FF8B56-CE97-11E5-BAA0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285790>

Thanks.
