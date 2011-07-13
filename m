From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Nesting a submodule inside of another...
Date: Wed, 13 Jul 2011 14:27:38 -0700
Message-ID: <7vhb6p6fcl.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
 <4E1C9F21.6070300@web.de>
 <CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com>
 <4E1E0C27.60903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>,
	Git mailing list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:27:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6yA-000193-4l
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 23:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab1GMV1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 17:27:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab1GMV1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 17:27:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 805606BF3;
	Wed, 13 Jul 2011 17:27:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/RYzfDmuj+zTruu1AG9TObzFGw0=; b=CPg/QY
	yHKDKWSujDzcGIMlbDK6Cnuq3P8FEH//ywIeIp+VRrbLN+3vBH3I+nrXafdU1F1D
	d4VdSa2iLmLeRNJfl8rFcwEr2VH+DZoeMmDiu6QiMEnwdmnyfWtf1ICSyHX9Jdbd
	XIDALWD8L6mOdpKm4oo3ZP+QwBWn5qqIrRpV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKnsusUWSGTL9klmDYIDtX3RxV26nWR9
	EkU0Oa73yiHo5q/9Xxn36Pua0NppMhPnsGfmOyYhkFTqhIsP1eSpreAJN41runvr
	UMRGonRzL4BiG1KpKLMxJdnfuLnnDggg7tM6Yk9iAvGl/B4F4wgrXQGIhWxo8b8k
	HC6Hhr7auKw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77C216BF2;
	Wed, 13 Jul 2011 17:27:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D54BE6BF1; Wed, 13 Jul 2011
 17:27:39 -0400 (EDT)
In-Reply-To: <4E1E0C27.60903@web.de> (Jens Lehmann's message of "Wed, 13 Jul
 2011 23:20:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFABAD68-AD96-11E0-B814-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177086>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> It can't be communicated, as submodules are unaware of their superproject.

It's more like s/can't/shouldn't/ and s/are/shouldn't be/, no?
