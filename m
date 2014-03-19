From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Wed, 19 Mar 2014 11:46:25 -0700
Message-ID: <xmqq61na3u2m.fsf@gitster.dls.corp.google.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>
	<xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>
	<531D51EC.6050503@gmail.com>
	<xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com>
	<xmqq7g80r1pm.fsf@gitster.dls.corp.google.com>
	<53200C1A.7070002@gmail.com>
	<xmqq38innyjq.fsf@gitster.dls.corp.google.com>
	<53295D30.8090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 19:46:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLVZ-0004Fs-AG
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 19:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbaCSSq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 14:46:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbaCSSq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 14:46:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FCA774973;
	Wed, 19 Mar 2014 14:46:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O9VKHEAC7pJyMIMbUNtsE3BnQf8=; b=XiBJ1R
	ilfL0On5rmx4ddU0Az48fp7ArpnLFkIIOOhLI3N6oTtQrST9MOue/yj8ewhSOW0p
	Us4YpMJnExQIeDD/AEol7UWQtf/9Firh0QmtLSYLA5YxEb8hxgzVvx2M5gaIX4qm
	vo9WgO2+29kkXc7V/Gp3NkJhDNBSp2CHgI+Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jU7wUNFQGjcVijr2HMSJVv+WRmqxWOFV
	Z6pQhd5KyFXFgJcSSoQsTq7FlZtPcsn45e3R7c26vycgxviT2FE4CUhHa0O+LqdA
	uUAAsTM8NG4pyxxdRzTUoyjGV8jLFjWwsLxzO3yn4riaKP39DuZcWdfWhXo8MzDE
	LgTyEtelMyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B9AB74972;
	Wed, 19 Mar 2014 14:46:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52CF074971;
	Wed, 19 Mar 2014 14:46:27 -0400 (EDT)
In-Reply-To: <53295D30.8090307@gmail.com> (Ilya Bobyr's message of "Wed, 19
	Mar 2014 02:02:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C737F7BA-AF96-11E3-9514-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244475>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> I can not find this particular patch in the latest "What's cooking" email.
> Is there something I can do?

IIRC, I think I was waiting for the version with a new "Usage text"
section to the documentation you alluded to in this exchange
($gmane/243924):

    Ilya Bobyr <ilya.bobyr@gmail.com> writes:

    > On 3/11/2014 12:10 PM, Junio C Hamano wrote:
    >>
    >>>> Documentation on the whole argument parsing is quite short, so,...
    > ...
    > I though that an example just to describe `argh' while useful would
    > look a bit disproportional, compared to the amount of text on
    > --parseopt.
    >
    > But now that I've added a "Usage text" section to looks quite in place.
    >
    > I just realized that the second patch I sent did not contain the
    > changes.  Sorry about - I will resend it.

> It does not seems like there is a lot of interest, so I am not sure
> there will be a lot of discussion.
> It is a minor fix and considering the number of the emails on the
> list, I do not unexpected this kind of stuff to be very popular.
> But it seems like a valid improvement to me.
> Maybe I am missing something?

You did the right thing by sending a reminder message with a pointer
to help others locate the original (like the one I am responding
to), as nobody can keep up with a busy list traffic.

> Same questions about this one:
>
>     [PATCH] gitk: replace SHA1 entry field on keyboard paste
>     http://www.mail-archive.com/git@vger.kernel.org/msg45040.html
>
> I think they are more or less similar, except that the second one is
> just trivial.

I do not remember if I forwarded the patch to the area maintainer
Paul Mackerras <paulus@samba.org>, but if I didn't please do so
yourself.  The changes to gitk and git-gui come to me via their own
project repositories.
