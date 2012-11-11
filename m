From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 01/15] fast-export: avoid importing blob marks
Date: Sun, 11 Nov 2012 18:53:05 +0100
Message-ID: <CAMP44s1BKD8NO5QSg2G_H6OM2vV7=h9T7r14zPVfZ7+3ddXFBA@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-2-git-send-email-felipe.contreras@gmail.com>
	<509FD425.5030702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:53:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbik-0002Ld-A5
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab2KKRxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 12:53:08 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44424 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab2KKRxG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 12:53:06 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5572250oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6kvDd2HB5ypAIaBlLhU14ReBzpJiLcXY7tlsJbAk8x8=;
        b=OrcAMAozkqZcnHJnS6h2QZAS+FKJ7PI8DC93bexPYkVJlLj1mIT6AdYKK0e9QbmHT6
         ZKwdgtuqGDzF7Uh5Xb33X8fLfEucQUbt/vMSgXXF2LGhxWZctU9eNPjB4JNqVqEG8iAA
         WJLbyGB66JxbC+gBO81yxF6jCs9OrlKdHYGouxwdxKfJxDTCPkWVZMc+Iri6M7ImMHPX
         MUmCeXdvN4QnkqHU78OF2X1yUfLoy3MHp1nf5w1FnQeip1eiVsnwi/rkPu5GV9yu0TfQ
         9BhGSo6esbOOXNcyEcRkClamhJ4qm00jQnoWgUlzORsptCKZBg1kUjpB/cHQkAPA1z2+
         T4nQ==
Received: by 10.182.52.105 with SMTP id s9mr13478771obo.25.1352656385603; Sun,
 11 Nov 2012 09:53:05 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 09:53:05 -0800 (PST)
In-Reply-To: <509FD425.5030702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209429>

On Sun, Nov 11, 2012 at 5:36 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 11.11.12 14:59, Felipe Contreras wrote:
>> test_expect_success 'test biridectionality' '
>> +     echo -n > marks-cur &&
>> +     echo -n > marks-new &&
> Unless I messed up the patch:
>
> Minor issue: still a typo "biridectionality"
> Major issue:  "echo -n" is still not portable.

Yeah.

> Could we simply use
>
> touch  marks-cur  &&
> touch marks-new

Unless somebody else already modified those marks. Better be safe than =
sorry.

--=20
=46elipe Contreras
