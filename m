From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib/subtree: unwrap tag refs
Date: Wed, 13 Jan 2016 09:49:50 -0800
Message-ID: <xmqq4mehpdxd.fsf@gitster.mtv.corp.google.com>
References: <1447435549-34410-1-git-send-email-mayoff@dqd.com>
	<20151124215258.GC29185@sigill.intra.peff.net>
	<878u3up5cj.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Rob Mayoff <mayoff@dqd.com>,
	git@vger.kernel.org
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Wed Jan 13 18:49:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPYT-00055F-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbcAMRtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:49:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932077AbcAMRtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:49:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 198AF3AF87;
	Wed, 13 Jan 2016 12:49:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LTg6M9tyEzkrhuE1ryzdOKxRs2E=; b=VBt0uQ
	9AyNVgw5IjfcWxx9Jjvt+wXwxw+RoMA4ZkaH3rRjVupAgj7wPis1ZghOrMhwYCVo
	jGtTY44TXR0QN/w+2woESfciUgqqFnQ8BR7WHE7eQGg78Q0DfKb0mF8w85mydBUn
	+N0/jiHJbX6cSalg4Gxd+leiJrXiTGu+iavHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SjjaVvLZfVjUQRGIgxFPZbLPR76jBjab
	R6Imm9gOIpvQhkxzQFzXUeu/agpHpnUkyqXO8Tqpz+/a58JrHDARpbwUX34A3iss
	zW5k0WwNucu6QIgYxwMWeJIobxRBpMpaz/YmniCppw0wCuqm3EVX4qEqNNrbDN25
	IRwsP15YEAk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E6BD3AF85;
	Wed, 13 Jan 2016 12:49:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 777A63AF81;
	Wed, 13 Jan 2016 12:49:51 -0500 (EST)
In-Reply-To: <878u3up5cj.fsf@waller.obbligato.org> (David A. Greene's message
	of "Tue, 12 Jan 2016 20:42:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0BD61B3E-BA1E-11E5-9CF4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283956>

Thanks, all.
