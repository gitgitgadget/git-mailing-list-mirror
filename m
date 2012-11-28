From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Wed, 28 Nov 2012 12:08:33 -0800
Message-ID: <7vy5hltrr2.fsf@alter.siamese.dyndns.org>
References: <7vboehv9d6.fsf@alter.siamese.dyndns.org>
 <20121128194216.GA22202@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdnwC-0000B1-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab2K1UIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:08:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab2K1UIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E069EA70C;
	Wed, 28 Nov 2012 15:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FYcLEv3CLg4Fl3KgZ0Owb1PksSc=; b=VcQyCc
	HdMojt21roZt0M9N+N3QV0M0AAHp3insStkYdccaiPuUWeMhtDUZQNjPltazDPVr
	amkjbtZmY0DsMUWTYhr1nCbw8vLlI3eK4lDXOrp9FhGx9uuXbjOEkehkN7KBcNWx
	Rv2e1F4+u8KCm7sCAQ79WTnVOIvqs1ryuV+UY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KiCGV/r+ay3LaZIPXuCh5X/+c8fevgTY
	kgtEl2zw0Lf1QbF8pBuOl2uNM/GRninifez9fPvrbEyMpsTlM2+5zQPBHu9L6jrT
	QsAhLY19G02fGCkhPAT3d99Ki90+cDXhZG/gqp9MZByLniLjy0PEcPC6XzIOx0Xj
	KliD3tnEk08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAA99A70B;
	Wed, 28 Nov 2012 15:08:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D0F3A70A; Wed, 28 Nov 2012
 15:08:35 -0500 (EST)
In-Reply-To: <20121128194216.GA22202@odin.tremily.us> (W. Trevor King's
 message of "Wed, 28 Nov 2012 14:42:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63DCB9EC-3997-11E2-8EB8-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210770>

"W. Trevor King" <wking@tremily.us> writes:

>> As the command takes other options whose names begin with 'r', I
>> thought the longer term plan was to stop letting "--rebase" squat on
>> short and sweet "-r" and leaving it undocumented (even though the
>> short one was added by mistake) was meant to be the first step in
>> that process.
>> 
>> But maybe I am confusing an undocumented single-letter option from
>> some other subcommand.  Anybody remembers?
>
> Perhaps you are remembering:
>
> On Sun, Nov 11, 2012 at 02:33:45AM -0800, Junio C Hamano wrote:
>> Ah, this reminds me of another thing I noticed when I saw that
>> ...

No.  The discussion might or might not be the "-r" option to
"submodule update", but even if it were so, I wasn't refering to
that exchange but something more in the further past.
