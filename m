From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] commit: reword --author error message
Date: Mon, 26 Jan 2015 14:07:12 -0500
Message-ID: <20150126190711.GA13582@peff.net>
References: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com>
 <7e2e1d1e7f4a25d84a6f7a1c0cb035221529f189.1422286879.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:07:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFp0J-00006U-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 20:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbbAZTHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 14:07:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:38733 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753422AbbAZTHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 14:07:14 -0500
Received: (qmail 19740 invoked by uid 102); 26 Jan 2015 19:07:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Jan 2015 13:07:13 -0600
Received: (qmail 6090 invoked by uid 107); 26 Jan 2015 19:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Jan 2015 14:07:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2015 14:07:12 -0500
Content-Disposition: inline
In-Reply-To: <7e2e1d1e7f4a25d84a6f7a1c0cb035221529f189.1422286879.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263041>

On Mon, Jan 26, 2015 at 04:48:33PM +0100, Michael J Gruber wrote:

> -	die(_("No existing author found with '%s'"), name);
> +	die(_("--author '%s': neither 'Name <email>' nor a match for an existing author"), name);

I had to add to the bikeshed, but I had to read this several times to
make sense of it. It is grammatically:

  X [is] neither Y nor Z

except that by eliding the verb ("is"), I somehow had trouble making
sense of Z ("a match...") as a noun.

I came up with:

  --author '%s': neither 'Name <email>' nor matches an existing author

only to see that it was suggested earlier in the thread as a predecessor
to this. ;)

I wonder if adding back in the missing verb, rather than a colon, would
also make more sense:

  --author '%s' is neither 'Name <email>' nor a match for an existing author

> BTW: How do you pull cc/msgid from the list into format-patch/send-email most effectively?
> (granted that I move away from gmane/nntp, which is likely)

Here's what I do:

  http://article.gmane.org/gmane.comp.version-control.git/262367

-Peff
