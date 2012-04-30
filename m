From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug (or inconsistency) in git add
Date: Mon, 30 Apr 2012 00:02:28 -0700
Message-ID: <7vwr4xhfcr.fsf@alter.siamese.dyndns.org>
References: <CADJEhEWC=mMManxi9Q6W9EvVKmTV=i1ZxbdW4QS_ou_DrBEb+Q@mail.gmail.com>
 <CADJEhEVNPj_FrRatjD7Jmbd7i_FYg9BzNNP48_4VAr6fgqBT8Q@mail.gmail.com>
 <CAA5Ydx9h6o=uppRk5zc9V4z1S831KGVRBzTw9oMqDjY34-noOw@mail.gmail.com>
 <CADJEhEXtDZGav1Y5epZQ69NWptyVyPC1hmN6=YaNYrg3vYmBqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Engmark <victor.engmark@gmail.com>,
	git <git@vger.kernel.org>
To: Steve Bennett <stevage@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 09:02:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOkd2-0002ch-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 09:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab2D3HCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 03:02:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab2D3HCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 03:02:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4231D3BDD;
	Mon, 30 Apr 2012 03:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y8mpUdQ8W+3hC/iY8qlApEDjOwM=; b=Pe6SE/
	9jP9wgMKqxoZj+XBN5ev2nRFItROHfycsVhwhM+x3qKfRcT/4hw04qzEXbK/+S9U
	mAqM165d8/rggTUsaH2zRZPDIuAgropi+vJeDUp8q8UPIeCxOLg+W5lzy8ByYPLy
	2YrGnSDci8YXJgvnCxoqQpX0IDJ4uVE7h5/84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tGKRakDtrXal4CnmS0oRyZDDJVVk+vTu
	w3LBYKIMc1n+Z5epsAyjR3crdjzRrhlfDrLk/LzCVNFx5hEjMFXn0oVIVeRstcdv
	QDkCTdg/9N7o6SVfFfTUkoV/JuJTcysD3mSHl2N+BH62lbJW8X72eEkRERyIDfct
	zZfk6LyDr6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39FEA3BDC;
	Mon, 30 Apr 2012 03:02:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE1FC3BDB; Mon, 30 Apr 2012
 03:02:29 -0400 (EDT)
In-Reply-To: <CADJEhEXtDZGav1Y5epZQ69NWptyVyPC1hmN6=YaNYrg3vYmBqg@mail.gmail.com> (Steve
 Bennett's message of "Mon, 30 Apr 2012 16:46:20 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73771A02-9292-11E1-8E76-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196544>

Steve Bennett <stevage@gmail.com> writes:

> In any case, it looks like Git does support some ** globbing natively.

No, we don't.
