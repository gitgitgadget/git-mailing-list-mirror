From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] rebase.autostash completed
Date: Mon, 13 May 2013 07:02:34 -0700
Message-ID: <7vmwrzou4l.fsf@alter.siamese.dyndns.org>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<7vy5bjqxxa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
	<vpqobcfcmb8.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 13 16:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtKs-0003Nc-8k
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab3EMOCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:02:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab3EMOCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:02:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 030B01C343;
	Mon, 13 May 2013 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9xwIBjOM1wkDADlo5rr7Dh3eDxg=; b=Y8E4/U
	3NzHTLMZT4MjoCk2TWjkhhuAzoOvMPiVSs5XQeqOuS/J00/tYtRXFEJBOlzfN5g7
	76bbgF2xRnBOUSbAxod7q8NHBUShtvXYlG5sMpTOypFhrFwVggWbrNcqBFg2YthR
	XFgL8dHzoJHkDhlmu7uGApz27BF8UETOKDAWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gIG5BVDQMiChb04BtzHzHD60vaDedQcJ
	N0LGqh4pMzw+a0tCcMc3GmLg+pdorifPtldHvkJ6yjLgyhN9T5wvaQBc11r4pdYA
	SHdJF+NQmVyERRGgg2l9twhfkB8zOngj2Hiz4Pt+vMEBVXvXJoCpnqBWwKlek4Ru
	Pw2UCs7wZ8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBD0F1C342;
	Mon, 13 May 2013 14:02:36 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 555EF1C33F;
	Mon, 13 May 2013 14:02:36 +0000 (UTC)
In-Reply-To: <vpqobcfcmb8.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 13 May 2013 10:32:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3E5EE4C-BBD5-11E2-8834-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224147>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> One benefit would be to avoid triggering rebuild (and editor reload) by
> keeping the timestamps intact. But I agree it's probably not worth the
> effort (and definitely isn't in the scope of this series).

It isn't in the scope, of course.  If rebase were done right, the
series will become much less necessary in the first place ;-).
