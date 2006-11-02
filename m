X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 2 Nov 2006 13:44:05 +0100
Message-ID: <8aa486160611020444v130c41f4y3639868cb28e7c38@mail.gmail.com>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>
	 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>
	 <4549CE2A.3010808@xs4all.nl>
	 <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
	 <4549D519.4080104@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 12:44:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iRD5N4uf2973guvHA/dBB0jevixbjEN9FbuC5g49LjtqR9yx+BeoAvIs2Ax1OzwAzOx8UANSiCAE+71bWkvKaoZic5k70QU2pTn/zJvPibIYQm1TmvUYhiIoktirpIi8sG6Zebu+VyP6SQ+nxEpZoq0zMo05UOu+O9JpC+tpRns=
In-Reply-To: <4549D519.4080104@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30744>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfbvY-0002oJ-Vd for gcvg-git@gmane.org; Thu, 02 Nov
 2006 13:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752742AbWKBMoJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 07:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbWKBMoJ
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 07:44:09 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:24691 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1752742AbWKBMoG
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 07:44:06 -0500
Received: by wx-out-0506.google.com with SMTP id s14so110213wxc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 04:44:05 -0800 (PST)
Received: by 10.70.44.5 with SMTP id r5mr760778wxr.1162471445629; Thu, 02 Nov
 2006 04:44:05 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Thu, 2 Nov 2006 04:44:05 -0800 (PST)
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

On 11/2/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> Santi B=E9jar escreveu:
> > One problem I see with this scheme (either 'g', 'git' of '+') is th=
at
> > it does not provide an increasing version number, even for
> > fast-forwarding commits. Then it is not useful as a package version
> > number (deb or rpm). I've already seen deb packages with
> > version+git20061010. One possibility could be to add the number of
> > commits between the tag and the commit as:
> >
> > v1.4.3.3-git12g1e1f76e
> >
> > to provide a weak ordering for fast-forwarding commits. What do you=
 thing?
>
> Is that number well defined if you merge branches in between?

Yes.

$ git-rev-list 1e1f76e ^v1.4.3.3 | wc -l

>
> I'd prefer
>
>    v1.4.3.3+git-12-1e1f76e
>
> or similar. Pasting together words without separator is bad for reada=
bility.
>
> --
>   Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
