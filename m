From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:32:24 -0700
Message-ID: <7vd44kgtx3.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Vietor Liu <vietor@vxwo.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfF3-0005zO-2Q
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbZJRXcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634AbZJRXcb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:32:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbZJRXca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 19:32:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E84A5EC62;
	Sun, 18 Oct 2009 19:32:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=lZWrNh8r5giSZkD4zsJB0qqPv
	lE=; b=H91JzGZNVwskWpiAAY29bI4IAofDWT4AgTqpsumdSoQABqbTdq04b9mV4
	6AcICQlrgSmHhHVrzwoCIA+O2w/I4YzpTfkQEvFXMbftexg4aMEB+09Luajfwrk6
	zuh7WE+LQ7A4D06IqylnXQPWnlDJnOoGBzEQnpY0raGYsyI17k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=J+NDzV+j6pS8vAvnu9Y
	CqYJZvKIyReBxaDxOe2knxpPHDJNK2XXdc1mUybxDm6jl5KM4nFsQU6JIZDZlaIL
	5IxlXrZ9VDHw1jxUIwoCHnrZXt6DpmKxlW5IdETJgRntXcyhYkMgAvLDRn06yD78
	U9mA6ADuydPOO5f+1eLwFtwk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D958A5EC61;
	Sun, 18 Oct 2009 19:32:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A5DF5EC5D; Sun, 18 Oct
 2009 19:32:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8128FA26-BC3E-11DE-9016-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130628>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, I saw these patches and thought what they try to do were=20
> sensible, but I don't them in your tree. I didn't see much discussion=
=20
> on most of them, either.
>
> Because I don't read C very well, I may have listed some patches=20
> here that you may have discarded because the code was no good, and=20
> if so I apologize for wasting your time, but I thought at least=20
> some of them should be salvaged.
> ...
> From: Vietor Liu <vietor@vxwo.org>
> Subject: [PATCH v4] git-gui: adjust the minimum height of diff pane f=
or
> Date: Fri, 16 Oct 2009 17:41:26 +0800
> Message-Id: <1255686086-3949-1-git-send-email-vietor@vxwo.org>
>
>     When the main window is maximized, if the screen height is shorte=
r (e.g.
>     Netbook screen 1024x600), both the partial commit pane and the st=
atus bar
>     are hidden.

I never apply patches to git-gui and gitk myself, but expect to be fed
them via respective area experts.

> From:	Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
> Subject: [PATCH] bash: complete more options for 'git rebase'
> Date:	Sat, 17 Oct 2009 11:33:38 +0200
> Message-ID: <4AD98F72.1060901@gmail.com>
>
>     Complete all long options for 'git rebase' except --no-verify
>     (probably used very seldom) and the long options corresponding
>     to -v, -q, and -f.

Likewise; I was expecting Shawn to Ack/Nak this one.
