From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] packed_object_info_detail(): do not return a
 string
Date: Mon, 16 May 2011 19:36:36 -0700
Message-ID: <7vfwoehx3f.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305505831-31587-2-git-send-email-gitster@pobox.com>
 <BANLkTinxfNH85v6AfWaVNRzhP-fJ0tjNNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 04:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMA9T-00010y-KB
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 04:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab1EQCgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 22:36:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab1EQCgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 22:36:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9EDC4583E;
	Mon, 16 May 2011 22:38:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qBbcTCWILTnvEIlorJXmmIpwuLw=; b=EGDVEL
	No9glEXd4k/jeV9md6vRiH1Zxh9aqHLYXSfjh82n69btCQL2W6XDXDXfcgI4kahi
	hovEIGONP6gWPp5weV7RB3ZiUchU4ZxMqqQswO0eIIrlu+btA6aTOjaj70nWlONs
	Uv8j8iSOGwDBWQdOYKgQkZLj6IynKbbDYggg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fQKq+OJ7w/X7FIdMZo1eYi8m6qrNcp0t
	dcXc0IfKLvSVSnFXyYrQ12uEGCiN7asa+havTWj460kPHtrBV63i3VagDD/IqpYk
	RbhFyu265bz4uyMyqf53owYI5eIaTfHwOvf6xNc2v+VejtvEJnwOCKY+BhPcsmT4
	bfYFys7E4ko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72C6B5839;
	Mon, 16 May 2011 22:38:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 209145833; Mon, 16 May 2011
 22:38:44 -0400 (EDT)
In-Reply-To: <BANLkTinxfNH85v6AfWaVNRzhP-fJ0tjNNg@mail.gmail.com> (Thiago
 Farina's message of "Mon, 16 May 2011 21:45:09 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAFFE906-802E-11E0-AB19-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173782>

Thiago Farina <tfransosi@gmail.com> writes:

> In the commit message you say to return "enum object_name". Maybe
> change from int to enum object_name here and below?

As other functions that return -1 on error return int as a convention, I
do not think it is a good change.

As you may have noticed, "enum object_name" is not correct. It should be
"enum object_type" I think.
