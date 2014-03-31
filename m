From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments. (v3)
Date: Mon, 31 Mar 2014 15:00:54 -0700
Message-ID: <xmqqtxae2fl5.fsf@gitster.dls.corp.google.com>
References: <1396133950-5285-1-git-send-email-jlebar@google.com>
	<CAEjxke9pe23YAc_D-JmAd+HkgocNuTrwQxSkGS7DaJhgw9GMRg@mail.gmail.com>
	<CAMuNMfpnojdQi4x_M_k29GBsq_i282Zph3AgLgsZv4arxB3CfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jason St. John" <jstjohn@purdue.edu>, git <git@vger.kernel.org>,
	Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkGO-0000DY-Qg
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbaCaWA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:00:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaCaWA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:00:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E21798AB;
	Mon, 31 Mar 2014 18:00:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kmx0cV9NhEjFxi22/ahVi5ZI3NI=; b=Krsm7E
	NIkt6pkT+P3uCO+wpMKthFXFbvIrCpVHateMlMg4ihp2I8i5y2kzCGPn6hbZFB0F
	ID9HoANmWcE9veOl9/dN2KpLfoAASw6K2S7KTa6ZhTTJAcWiEOSZAugoSltCO0tg
	kSrfICVYQ4JHwAiG8flFcP20eU6SnFL6FYucM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N3SPcKlI3frHXwXsnaOR9fQ8Um5ERGQS
	tiFlhNeG15sZDU+ZAV/23m9xRz03lMXeCHnSXfnvDTKT+HwyKDlH8H+jp1UWVmJV
	HxoybH+pe7FNvA1bPFuM440M3gVxiRuPVc4V5uAcALU/tjk7WliT+XkXrVcQHiVX
	OlTOSD6yBUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A572798A9;
	Mon, 31 Mar 2014 18:00:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CE8E798A3;
	Mon, 31 Mar 2014 18:00:56 -0400 (EDT)
In-Reply-To: <CAMuNMfpnojdQi4x_M_k29GBsq_i282Zph3AgLgsZv4arxB3CfA@mail.gmail.com>
	(Justin Lebar's message of "Mon, 31 Mar 2014 14:04:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EF80CEDA-B91F-11E3-A6A1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245548>

Justin Lebar <jlebar@google.com> writes:

> Thanks; fixed in v4 (just sent out).

I only saw [3/4] that was marked with (v3) at the end, without
[{1,2,4}/4].  As you seem to be renumbering from the very original
(which had "l10n" at number 3), only sending out what you changed,
expecting that everybody else knows what you are doing, is not very
friendly to anybody who is trying not to lose patches in all the
other activities on the list.  Also people who haven't seen the
older iterations do not have to fish them from the archive if you
repost the whole thing.

Please use "format-patch -v5" (or whatever numbering) so that the
series iteration number is inside, e.g. [PATCH v5 1/6].

Thanks.
