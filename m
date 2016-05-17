From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 0/4] pathspec attrs [WAS pathspec labels [WAS submodule groups]]
Date: Mon, 16 May 2016 21:14:01 -0700
Message-ID: <xmqqeg91z5h2.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 06:14:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2WOg-0004eM-2O
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 06:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbcEQEOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 00:14:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751886AbcEQEOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 00:14:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D13A11C510;
	Tue, 17 May 2016 00:14:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=762pwIJVVkn9nDjW5tV0ttHzRXg=; b=GsiwLC
	w36qJrmF7SL6X4balePqB6orHPoXSYMRimAS0zb2h9oKurS4P3f3OavLwKWXhOwE
	H3TpxTCePopkmREwotFY5X+Kk1UwLLAVjoLdBArcLaME4YP7Y/T7KEE894/TdqvF
	7uhCSDMRZfZQbuOyQ5A1NbUJXtX0tqWO9bA38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgBFWpvTjIQe1Id3wkhJo/qhju6zt9qL
	iO0eA4xmEFlufe5VafJ8P4cTKHKALegQVnCQk4YzvQ+iJjsrcUhrbxnrmfHzFOv/
	F4/UdjOM9DgMB0lInAiOCsmYhAwZboubkk/7JUnGhmNxfvBEiNdd0w7tewnKVMrW
	PvDIClyonAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C7F011C50F;
	Tue, 17 May 2016 00:14:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49E3E1C50D;
	Tue, 17 May 2016 00:14:03 -0400 (EDT)
In-Reply-To: <20160517031353.23707-1-sbeller@google.com> (Stefan Beller's
	message of "Mon, 16 May 2016 20:13:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA14386E-1BE5-11E6-9817-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294851>

Stefan Beller <sbeller@google.com> writes:

>   I wanted to understand Junios series, so I built on top.

Thanks.
