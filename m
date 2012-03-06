From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Tue, 6 Mar 2012 12:16:06 +0800
Message-ID: <CANYiYbHGAG5ijeL3yW5SKYAfMNwtme5ELPeGNPhNyKBPGTONMg@mail.gmail.com>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
	<7v7gyz7pei.fsf@alter.siamese.dyndns.org>
	<CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com>
	<7vobsb67dn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 05:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4lot-00026m-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 05:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235Ab2CFEQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 23:16:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63368 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934Ab2CFEQH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 23:16:07 -0500
Received: by gghe5 with SMTP id e5so1281270ggh.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 20:16:06 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.181.193 as permitted sender) client-ip=10.236.181.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.181.193 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.181.193])
        by 10.236.181.193 with SMTP id l41mr30402913yhm.38.1331007366246 (num_hops = 1);
        Mon, 05 Mar 2012 20:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=irIxuQ08flkrbtv5OBxXcWkM1McFCwJSr0CT/CAwJK4=;
        b=c0fOzbphS51CBcR8Z+jKHNhmSCRll4NaNHX//YNB/3nQ/U5R8TG/yWMXl7naeZLRnG
         uhgNvUFogOtsQohMMzNev032h0GPLs78Us0bkBsWDhnw5lzFsUHTGcLn+RtOXGok8ZyB
         l4KD9t1pFOd9bg9ie3jHqsEbv3Y9++ZeSLqwHjDwy8+ve4GrOyvjDNW9RXikHZNw5z44
         zkVSXjPNXkkz+TiejdtGocb/TGIdlCIb8DYLtDugEFyl6vWKziNCWz1DNGl5ls+8NrAf
         3xGddEU46eoVaP/6mbym1ncf+7Mdb0M3l/JNte2wfWTdo6T9qHN4bP7xe6NaJRG+hXsw
         KnzA==
Received: by 10.236.181.193 with SMTP id l41mr24013007yhm.38.1331007366177;
 Mon, 05 Mar 2012 20:16:06 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Mon, 5 Mar 2012 20:16:06 -0800 (PST)
In-Reply-To: <7vobsb67dn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192301>

2012/3/5 Junio C Hamano <gitster@pobox.com>:
> This is a tangent and I am just showing aloud my ignorance, but I won=
der
> if there is a reasonably generic and "best current practice" way to
> structure code to show an enumeration in human languages, for example=
,
>
>        A, B, C and D.
>
> in an easier-to-translate way.
>
> I suspect that it might be sufficiently generic if we can make it pos=
sible
> to allow the first and the last inter-word-separation and the token a=
fter
> all the items to be different from other inter-word-separation tokens=
=2E
>
> E.g. in English, the first one and all the "other" are ", ", the last
> inter-word token is " and ", and the token at the very end is ".". In
> Japanese some translators may want to say "A=A4=E4B=A4=C8C=A4=C8D=A1=A3=
", meaning the
> first one is "=A4=E4", "=A1=A3" is used at the very end, and all the =
others may be
> "=A4=C8".

I write a function for this.

/*
 * Make list of items easy for l10n translation.
 *
 *   1. Input list of items one by one through the 2nd argument,
 *      but leave the 1st argument as NULL.
 *
 *   2. Get the output joint string from the 1st argument.
 *
 * According to the number of items input. The joint string maybe:
 *
 *   a
 *   a and b
 *   a, b and c
 *   a, b, c and d
 *
 */
#define MAX_L10N_LIST_ITEMS_COUNT  128
void append_l10n_list_items(struct strbuf *ret, const char *item)
{
    static const char **itemlist =3D NULL;
    static int  count =3D 0;
    int i =3D 0;

    if (itemlist =3D=3D NULL)
        itemlist =3D xmalloc(MAX_L10N_LIST_ITEMS_COUNT * sizeof(char*))=
;

    if(item !=3D NULL && count < MAX_L10N_LIST_ITEMS_COUNT )
        itemlist[count++] =3D item;

    if (ret !=3D NULL) {
        if (count =3D=3D 1) {
            strbuf_addstr(ret, itemlist[0]);
        }
        else if (count =3D=3D 2) {
            strbuf_addf(ret, _("%s and %s"), itemlist[0], itemlist[1]);
        }
        else if (count > 2) {
            strbuf_addf(ret, _("%s, "), itemlist[0]);
            for (i=3D1; i<count-2; i++) {
                strbuf_addstr(ret, itemlist[i]);
                strbuf_addstr(ret, _(", "));
            }
            strbuf_addf(ret, _("%s and %s"), itemlist[count-2],
itemlist[count-1]);
        }
        free(itemlist);
        itemlist =3D NULL;
        count =3D 0;
    }
}


=2E..
       strbuf_addstr(&extra, " ("))
       if (a)
               append_l10n_list_items(NULL, _("msg a"));
       if (b)
               append_l10n_list_items(NULL, _("msg b"));
       if (c)
               append_l10n_list_items(NULL, _("msg c"));

       append_l10n_list_items(&extra, NULL);
=2E..

--=20
Jiang Xin
