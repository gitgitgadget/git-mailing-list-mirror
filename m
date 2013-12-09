From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/git-credential-gnome-keyring.c: small stylistic cleanups
Date: Mon, 09 Dec 2013 10:06:15 -0800
Message-ID: <xmqq38m1292g.fsf@gitster.dls.corp.google.com>
References: <1386066764-49711-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Dec 09 19:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq5Dr-0004gB-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 19:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759337Ab3LISGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 13:06:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885Ab3LISGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 13:06:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5895757898;
	Mon,  9 Dec 2013 13:06:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rarVy3IvQDtcAmcy7AnY7N7kxso=; b=VHqTV7
	uu+jRtyCcKs9W/9QTvX7CJFCbrqZ0hHJxZ//96eOq1dNliEC26H/SxzJePmv8eE/
	6IcT+0WscoIvXfunOMOuXjSUWATNUUpOZdeMIJ/2R3lcswzz4Pjcu2Tb3QlqP3Ni
	iB195bwKeRk4E1lD2frdgnY8q1rShZW7aUGmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+Dtec0VKqdfCvIrYMlSCHGQSw2RI/8v
	guN0wv8fJ+S1cGNjZj0MBi4gez+1FU6CbuvMKnWK7vtCC/VMtvaHwNaCje/hE7td
	P97AWFykpBDW1hPzS+kLL/TNTOaLtF8IVo0iV1hl7jbLmAowPsawy0x3ZPDxOh8W
	330OeObTWc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A46B57897;
	Mon,  9 Dec 2013 13:06:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8139857896;
	Mon,  9 Dec 2013 13:06:17 -0500 (EST)
In-Reply-To: <1386066764-49711-1-git-send-email-john@szakmeister.net> (John
	Szakmeister's message of "Tue, 3 Dec 2013 05:32:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 998C4264-60FC-11E3-8460-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239075>

John Szakmeister <john@szakmeister.net> writes:

> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
> The gnome-keyring credential backend had a number of coding style
> violations.  I believe this fixes all of them.
>
>  .../gnome-keyring/git-credential-gnome-keyring.c   | 55 ++++++++++------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
>
> diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> index 635c96b..1613404 100644
> --- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> +++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> @@ -95,9 +95,9 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
>  
>  static void gnome_keyring_done_cb(GnomeKeyringResult result, gpointer user_data)
>  {
> -	gpointer *data = (gpointer*) user_data;
> -	int *done = (int*) data[0];
> -	GnomeKeyringResult *r = (GnomeKeyringResult*) data[1];
> +	gpointer *data = (gpointer *) user_data;
> +	int *done = (int *) data[0];
> +	GnomeKeyringResult *r = (GnomeKeyringResult *) data[1];

I thought we cast without SP after the (typename), i.e.

	gpointer *data = (gpointer *)user_data;

It could be argued that a cast that turns a "void *" to a pointer to
another type can go, as Felipe noted, but I think that is better
done in a separate patch, perhaps as a follow-up to this "small
stylistic clean-ups".

I said "it could be argued" above, because I am on the fence on that
change.  If this were not using a type "gpointer", whose point is to
hide what the actual implementation of that type is, but a plain
vanilla "void *", then I would not have any doubt.  But it feels
wrong to look behind that deliberate "gpointer" abstraction and take
advantage of the knowledge that it happens to be implemented as
"void *" (and if we do not start from that knowledge, losing the
cast is a wrong change).

So...
