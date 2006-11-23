X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 16:45:09 +0100
Message-ID: <4565C205.8050300@lsrfire.ath.cx>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <4565A46C.6090805@lsrfire.ath.cx> <4565A866.8020201@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 15:45:48 +0000 (UTC)
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <4565A866.8020201@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32142>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnGlK-0002oW-Hc for gcvg-git@gmane.org; Thu, 23 Nov
 2006 16:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756288AbWKWPpO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 10:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757376AbWKWPpO
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 10:45:14 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:5606 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1756288AbWKWPpM (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23
 Nov 2006 10:45:12 -0500
Received: from [10.0.1.4] (p508E51A7.dip.t-dialin.net [80.142.81.167]) by
 neapel230.server4you.de (Postfix) with ESMTP id CD0F63C010; Thu, 23 Nov 2006
 16:45:11 +0100 (CET)
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft schrieb:
> This structure represents an on-disk/on-the-wire thing, should we not=
 be
> specifying it in some architecture neutral way?  You are going to get
> the length right in the case of tail padding but not in the face of a=
ny
> other padding internally.
>=20
> You see packing attributes applied to similar things in the kernel.
> Perhaps they are relevant here?
> Is there not some kind of attribute thing we can apply to this struct=
ure
> to prevent the padding?  You see that in the kernel from time to time=
=2E
>=20
> struct foo {
> } __attribute__((packed));

Yes, that would be nice, but unfortunately __attribute__ is no standard
C.  Is there really a compiler that inserts padding between arrays of
unsigned chars?

Thanks,
