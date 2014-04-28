From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 14:27:18 -0700
Message-ID: <xmqqk3a9no09.fsf@gitster.dls.corp.google.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com>
	<20140428200550.GO9218@google.com>
	<CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
	<20140428205058.GQ9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Borowitz <dborowitz@google.com>, git <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:27:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wet5D-0006EK-G7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbaD1V1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 17:27:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbaD1V1X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 17:27:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90B4C81798;
	Mon, 28 Apr 2014 17:27:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUTM3utDzIrYojxFv4PQN71IlMY=; b=OAqtO+
	KBAggwggsHmBnXAeFhPyrYpo1E+vbasA1zi7PhZgGzsnR7KXJ+2hfKkB/kY4nxOC
	/TRpaDb8U52ZSKLQeDUA9nXFNTcdJZsCnGYVNeJibBPyekuKK8bXCIbtLSgRsrKD
	qpHKdALxKAFQ1IEv1C14hjEwLgZ4n+LoJSwl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQRBIDtk02Jvk+A5mxk22MjwYqsz4ghp
	Aj32l5eusS5flVfK+/2FocFusdvxcHn8McjsfJt40Sd1cqfO+5H+9TZpYywjCVQ0
	UBPGFeBMem4Z/txSs07Oh23egLeXdbqq7TGcn5uHFIAy+ycyv99ZS7tpnjKjRUP4
	ntuMrkIj++c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7828A81797;
	Mon, 28 Apr 2014 17:27:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8565181796;
	Mon, 28 Apr 2014 17:27:20 -0400 (EDT)
In-Reply-To: <20140428205058.GQ9218@google.com> (Jonathan Nieder's message of
	"Mon, 28 Apr 2014 13:50:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1826822-CF1B-11E3-9948-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247456>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Gah.  Maybe it should be left-justified to avoid accentally breaking
> it again.

;-).  Yes, $(error) is not the usual part of "to build this target,
follow this recipe" part.

But let's take the last round as-is and go with it for 2.0.

Tahnks.
