From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] WAS: [PATCH] mv: allow moving nested submodules
Date: Tue, 19 Apr 2016 11:15:15 -0700
Message-ID: <xmqqlh491n4c.fsf@gitster.mtv.corp.google.com>
References: <1461022884-30819-1-git-send-email-sbeller@google.com>
	<xmqqwpnu31qu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYEjRSpet-5EQibJJ-57EkefQZm+zZr-d1K8Y9-=-fAmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Albin =?utf-8?Q?Otterh=C3=A4ll?= <gmane@otterhall.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asaBH-0002sh-LW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbcDSSPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:15:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753495AbcDSSPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:15:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BAEC1353C;
	Tue, 19 Apr 2016 14:15:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ICJirj+sgmmXNOZ7BM9ZBdWhT8=; b=NyzOM2
	j5gtSjmpH0TSBsGn8XfKKFlYyTFgQ3aB6VZx9yUhBst9Y8cFKl5AfadvABG0efeh
	NCGpyVoNAAOUWB6cTj9rq6dvzdz57ZaLsLbnCOh6y8Hks21OnpnAl1eNRMM5Ccxy
	7h2/T6OXCDD1ZLs3yPpBLd4RQbevWGnO1OW1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c53R/xxagoQNPXqHQTVzowmxiKEpzJ0p
	9zyv80wiXkyua49CFZDcpzD2zqTSprnKlmcG/Rqk06Ij15SPoRA/GaY1mDpIg3Sj
	fgN0IHscELVTdIMMIySKFdPy8WxhLrbk4D6yvCE7gbDhQVUuAO0os+9Al6xDCjo0
	kaEKAHqj2Yk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 332B51353B;
	Tue, 19 Apr 2016 14:15:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 953C813535;
	Tue, 19 Apr 2016 14:15:16 -0400 (EDT)
In-Reply-To: <CAGZ79kYEjRSpet-5EQibJJ-57EkefQZm+zZr-d1K8Y9-=-fAmQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 19 Apr 2016 09:56:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAF314E6-065A-11E6-8568-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291898>

Stefan Beller <sbeller@google.com> writes:

> ..., but I am unsure
> if patch 1 is a good idea.

Then let's postpone it for now.  I too would like to hear opinion
from other submodule folks, especially Jens, for what 1/2 does
before committing us to the course.

Can you do only the 2/2 on top of maint (or maint-2.6) for now then?
