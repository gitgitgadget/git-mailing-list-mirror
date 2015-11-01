From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: fix passing wrong address to git_mailinfo_config
Date: Sun, 01 Nov 2015 10:29:43 -0800
Message-ID: <xmqqpozth8tk.fsf@gitster.mtv.corp.google.com>
References: <1446388230-27966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:30:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsxOK-0005vm-4R
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbKAS3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 13:29:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752408AbbKAS3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:29:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B359A27375;
	Sun,  1 Nov 2015 13:29:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Uu7MkW
	1eavb+GZAmiy4kGepOsIoF5dw3W0bO7Wxmp/nZ6lHCxJZm017F8McZLUDdBZZd80
	MKdAL6Kk7LupYd9UzjUOozZpkMSh88vKhPy4cA6srNwKvunj7SukNIIXUfuOd2hA
	4zhk9kbjAs/DRedAzEqLPfS4BBQJbUsLSb94M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aDmD3EgjTsuHcI0SI+MlwKThEAJ4YYry
	o0YIWYFGi1mASIIUTAf8OBhptdX40zXfhfT9/PMhwC2oolNgTp7QiCUpz7AxZENd
	fBBeO0tNxem8iETcHt5fGGs8y94lFM8v9UAOzK43lcKxS7/vwl4T9soYqFEeiTDQ
	1Qq7kfs1yjw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9A6A27374;
	Sun,  1 Nov 2015 13:29:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F34627373;
	Sun,  1 Nov 2015 13:29:44 -0500 (EST)
In-Reply-To: <1446388230-27966-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 1 Nov
 2015 15:30:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 85D7EEC6-80C6-11E5-8E4B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280648>

Thanks.
