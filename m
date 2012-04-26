From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 11:50:23 +0200
Message-ID: <87sjfqn7og.fsf@thomas.inf.ethz.ch>
References: <20120426085156.GB22819@sigill.intra.peff.net>
	<87d36uomlq.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:50:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNLLM-0004Yh-1R
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 11:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab2DZJu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 05:50:27 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:24708 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754623Ab2DZJu0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 05:50:26 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 26 Apr
 2012 11:50:24 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 26 Apr
 2012 11:50:24 +0200
In-Reply-To: <87d36uomlq.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Thu, 26 Apr 2012 11:42:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196363>

Thomas Rast <trast@inf.ethz.ch> writes:

> -``Com M Itter'') and `<email>` is the person's email address
> -(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c=
)
> -and greater-than (\x3e) symbols.  These are required to delimit
> +`Com M Itter`) and `<email>` is the person's email address
> +(`cm@example.com`).  `LT` and `GT` are the literal less-than (`\x3c`=
)
> +and greater-than (`\x3e`) symbols.  These are required to delimit
[...]
>
> On my box (asciidoc 8.4.5) the preimage renders as
>
>   `Com M Itter''
>
> in fixed-width font.

Note that ``foo'' is the correct way to have it render =E2=80=9Cfoo=E2=80=
=9D (with the
smart quotes).  So it's not even a formatting error on our end, just
massive quoting rules brain damage that ruins the use of quotes here.

(I had this in the original email, but then edited it out.  Sorry for
any undue confusion caused.)

> In the process of debugging this, I noticed that
> the quoting rules are hilariously screwy.  It seems that within a
> paragraph, saying
>
>   ``foo'' means `bar`
>    ^^^^^^^^^^^^^
>
> treats the underlined part as a `-quoted chunk of text, and renders i=
t
> appropriately using a fixed-width font.  The trailing ` has no effect
> unless it is followed by another ` within the same paragraph.  But th=
e `
> right at the start of the "quoted" text has no effect either!  Moreov=
er,
> this behaviour is the same regardless of the 'asciidoc7compatible'
> setting.  I wonder if it has since been fixed, but the above might be=
 a
> good idea anyway.  (The quoting around \xAB is just for good measure.=
)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
