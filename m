From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 2/2] Rename suffixcmp() to ends_with() and invert its result
Date: Tue, 19 Nov 2013 22:32:56 +0100
Message-ID: <CALWbr2yG7XOhuZa9bf6sXRV=m49dTPNyPZ9JUU2-_2G8ZJsCTg@mail.gmail.com>
References: <20131117083930.4177.79411.chriscool@tuxfamily.org>
	<20131119191322.GA4212@google.com>
	<20131119.220438.1634671089949485179.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, apenwarr@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>, ae@op5.se
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Visut-0007Gx-94
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3KSVc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:32:58 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:62170 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab3KSVc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:32:57 -0500
Received: by mail-lb0-f176.google.com with SMTP id x18so1090792lbi.35
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 13:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NM7Cw1kZbTtAfWFavnN//wnEuRRGWP8SPJBMXHvr8QQ=;
        b=Z41Bu6Ejmb8a/WGGJQbnG6z7804xV1cIRe9koWyHSzfhMt29uA1LdlK7cTFhl61Uu9
         GednnOD+oXKd/HN+9ayyR3AHaiiu9NCK3UbT29mxgMoyU/JLAp6zOhYrDgueZsV+Ns2A
         6TFieLuWPgUPzKmtLfeUClHM66MOZp7dmMudLdW2s8RLR9E6S1YkfTMxp+XQ9drqZf6h
         ZpOLI1g4l1PKq2V81klwDURvAOzI2V1qVXDKG271FNHNfef7jfCAscMouJmhcasSyGO3
         2YUfJbDNhPmuLPJ7soBAx4tqFtg5ppoEH81jwwjACye8p34dVuJysri8YzRC8r0nRodN
         6LvQ==
X-Received: by 10.152.228.130 with SMTP id si2mr2929305lac.32.1384896776650;
 Tue, 19 Nov 2013 13:32:56 -0800 (PST)
Received: by 10.112.202.102 with HTTP; Tue, 19 Nov 2013 13:32:56 -0800 (PST)
In-Reply-To: <20131119.220438.1634671089949485179.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238050>

On Tue, Nov 19, 2013 at 10:04 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> To avoid spamming the list again, I am going to send the following
> patches from the 86 patch long series to replace prefixcmp() with
> starts_with():
>
> [PATCH v2 00/86] replace prefixcmp() with starts_with()
> [PATCH v2 01/86] strbuf: add starts_with() to be used instead of prefixcmp()
> [PATCH v2 02/86] diff: replace prefixcmp() with starts_with()
> [PATCH v2 08/86] transport*: replace prefixcmp() with starts_with()
> [PATCH v2 40/86] environment: replace prefixcmp() with starts_with()
> [PATCH v2 86/86] strbuf: remove prefixcmp() as it has been replaced with starts_with()
>
> If there are no problems with them, then I will suppose that most of
> the patches are ok and probably send them all unless I am asked not
> to.

I'm not exactly sure I understand the point of not squashing all those
patches together ?
It's not like one is going without the others, or that the commit
message provides some new information (except for the name of the
file, but that is not very relevant either). The downside is that it's
_many_ messages to bypass when reading mails from small-screen devices
:-)
