From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 10:57:36 -0700
Message-ID: <7v4nttu2gf.fsf@alter.siamese.dyndns.org>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
 <7vfwddu60f.fsf@alter.siamese.dyndns.org> <20120312164812.GC12405@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Willy Tarreau <w@1wt.eu>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 18:57:57 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S79VG-0008HG-Ge
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 18:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab2CLR5l (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 13:57:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab2CLR5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 13:57:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5BD764BC;
	Mon, 12 Mar 2012 13:57:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/rMzaE36ihs35vqvl2MSluALIBQ=; b=QsPspu
	TLUALV57VPmz/mepikW+qz47hMdzl8j4byWNhVYbJudknXynSjWVjX7bYfZlm+eH
	nA4IaJsLfX+ScSZ7BgZBpgqP386Aanwr/gETip256woJYPwqYJIakdV/m+j0RmL7
	kksjNae+VGoyX9DiapurO9qwimBQoA4GwZzZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AiEV5/S8vbAV4UwpDc9Rkidt3XmBFn1e
	wRn+oItcrtt5HnWUciFpd92/xaUmN/MWxMFBe6c68/IpUwHTJLHtfWqb6EGpFNlI
	CBgAoXPz7zeqTXOzGIpagxoKpDDBxgB0nHRiOCfjYuV5alJzRVd0lCPi67q1AeTZ
	QJPT6mutKmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9C464BB;
	Mon, 12 Mar 2012 13:57:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45CEE64BA; Mon, 12 Mar 2012
 13:57:38 -0400 (EDT)
In-Reply-To: <20120312164812.GC12405@1wt.eu> (Willy Tarreau's message of
 "Mon, 12 Mar 2012 17:48:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAEF9890-6C6C-11E1-A723-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192912>

Willy Tarreau <w@1wt.eu> writes:

> Hi Junio,
>
> On Mon, Mar 12, 2012 at 09:40:48AM -0700, Junio C Hamano wrote:
>> Greg KH <greg@kroah.com> writes:
>> 
>> > I don't see a -b option to 'git am' in the manpage, am I missing
>> > something here?
>> 
>> As this is a recent enhancement, it is very much appreciated if you
>> try out 1.7.10-rc0 (or 'master').
>
> I've just backported it to 1.7.9.3 (I'm not keen on living on the bleeding
> edge with my everyday tools), and it works nicely as expected.

This topic will be backported in later versions of 1.7.9.x track,
but living on the maintenance track does not have much smaller
chance of breakage than living on the tip of 'master' these days,
unless you are using distro packaged version. The usual rule of
thumb if you are compiling from the source is that the tip of
'master' is more stable than any tagged version, including the
maintenance track.  See

http://thread.gmane.org/gmane.comp.version-control.git/189657/focus=190814

for details.
