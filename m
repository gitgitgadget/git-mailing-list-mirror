From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 13:27:05 -0700
Message-ID: <7vhajeku7a.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1bx-00036X-Sk
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936762Ab3DJU1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:27:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932803Ab3DJU1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:27:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D52B15628;
	Wed, 10 Apr 2013 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gJ1pAPJpnUdaahNu6MFEF5yAeJc=; b=bvkK8p
	n/7ZpxieWfokvUhtG/9Mha+nFjHVIVuFNwfiYVhgCXQpza0+lUeMHg3S4DQOp5qf
	tK1AefxTpQRFAvz45kFZIE4cglbopcVjXHzzLZnLGD6YXpV/u4LweOMSnzsoHQYL
	E7feJtE5jAIfDBtc0x0iOp82o8juZONWphBaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4n/fmyh48PBjCcLWMIKy8w1YnMh5zzB
	vZA1QfDPJ67iLN5xHl/gaiSYFrNfZ/3vCsHz+GSuJV7mjNcvoABqzkWiKwH0rUHb
	y7eJnM0sePreQGMSIjeOz0sO2sTfeCMFFbNLkWDT3VF7KcERat8O2Tv31WraXizJ
	JYmRCWLCgPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 216CB15627;
	Wed, 10 Apr 2013 20:27:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4413615623; Wed, 10 Apr
 2013 20:27:07 +0000 (UTC)
In-Reply-To: <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 11 Apr 2013 01:23:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 039D4F1C-A21D-11E2-BE64-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220755>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> As the author of branch.<name>.pushremote, I apologize for not having
> caught this earlier.  I've been using push.default = current for a
> long time, and don't often think about the other settings.

Possibly, but I do not know it is such a big issue.

On the other hand, a good thing is that the remote.pushdefault makes
perfect sense whether you use the upstream mode or the matching
mode.  I vaguely recall that I kept telling you that the overall
default should be there and per-branch stuff can come later if/as
needed, to which you resisted for a couple of rounds of reviews and
I couldn't quite figure out where the resistance was coming from.
Come to think of it, perhaps that might be rooted in the same
reason of not thinking about users of "matching" mode.  I dunno, and
I do not think it matters.
