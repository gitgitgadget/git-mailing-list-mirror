X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2/2] Don't require config file for "stg mail"
Date: Wed, 29 Nov 2006 18:27:21 -0500
Message-ID: <1164842841.23643.28.camel@dv>
References: <20061129035925.6118.78329.stgit@dv.roinet.com>
	 <20061129035930.6118.88435.stgit@dv.roinet.com>
	 <b0943d9e0611290829h291942d7x13247511d16afeee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 29 Nov 2006 23:27:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <b0943d9e0611290829h291942d7x13247511d16afeee@mail.gmail.com>
X-Mailer: Evolution 2.8.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32678>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpYpu-0005Mu-4d for gcvg-git@gmane.org; Thu, 30 Nov
 2006 00:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934293AbWK2X1Z convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006 18:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934356AbWK2X1Z
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 18:27:25 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:30955 "EHLO
 fencepost.gnu.org") by vger.kernel.org with ESMTP id S1758993AbWK2X1Y convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006
 18:27:24 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.52) id
 1GpYpn-0004UL-BW for git@vger.kernel.org; Wed, 29 Nov 2006 18:27:23 -0500
Received: from proski by gnu.org with local (Exim 4.63) (envelope-from
 <proski@gnu.org>) id 1GpYpl-0007JM-9r; Wed, 29 Nov 2006 18:27:21 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Hello, Catalin!

On Wed, 2006-11-29 at 16:29 +0000, Catalin Marinas wrote:
> On 29/11/06, Pavel Roskin <proski@gnu.org> wrote:
> > When calculating the string to be used in the From: field, don't re=
quire
> > it to come from the configuration file.  Instead, reuse already kno=
wn
> > authname and authemail values as the default.  They can be taken fr=
om
> > the GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL environment variables.
>=20
> Your patch uses the author of the patch which can be different from
> the person sending the e-mail. It could indeed use the author from GI=
T
> variables or configuration (not the patch author) and I already have =
a
> patch from Karl Hasselstr=F6m for this (which I haven't found the tim=
e
> to check properly).

The funny thing it, GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL are only used
in the code to determine the author of the patch.

Apparently, things are more twisted than I expected, so they need some
untangling first.

> Once I merge Karl's patch, I'll modify StGIT to use the GIT defaults
> if there is no sender configured.

Sounds good.

--=20
Regards,
Pavel Roskin

