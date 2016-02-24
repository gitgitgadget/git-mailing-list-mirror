From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Wed, 24 Feb 2016 15:39:53 -0800
Message-ID: <xmqqwpptr83a.fsf@gitster.mtv.corp.google.com>
References: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bill Okara <billokara@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:40:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYj2I-0007DG-At
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270AbcBXXj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:39:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752706AbcBXXj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 18:39:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71A7447ECD;
	Wed, 24 Feb 2016 18:39:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k6nyW9Z5uh+WlwZTSQPuybDy0g0=; b=Mpv/y7
	ACPq/IGbb1aEDVPF+iBLgdO26ArDka6T+tr/a0gwnsuV/mEOHI+5riV+BND439/o
	tZlh4Qbl1y3zD1IDp3tL0Thgy8eO1i4/DrUYjJqwcxNjVTzTmSmrXYqtgX/9fv2k
	SZDMAI1umeKHgbECvO/U+w7D4OqENxKSU7Zxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X06yc2z9QunQHhEPsLhUu/F1ZlgA+TWY
	cjdMouU8fEoHg/ej4SluCDRfZuic/IixhG2D0kBxxVBxoPLZWo7DcIGJmGAbYZDS
	dtbY4bGYvBoltkIQqwKA9ByFVogubObcXnwyzd8bBv4bdvy/Pm6g9+Ef9tgHSHg0
	L+tIjqOaqvU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67EAE47ECC;
	Wed, 24 Feb 2016 18:39:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D9A2547ECA;
	Wed, 24 Feb 2016 18:39:54 -0500 (EST)
In-Reply-To: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
	(Bill Okara's message of "Wed, 24 Feb 2016 16:38:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E83001BA-DB4F-11E5-A0B2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287282>

Bill Okara <billokara@gmail.com> writes:

> just want to see if this is a bug, user error (on my end), or??

Not a bug, not a user error, just "it does not matter", I think.
