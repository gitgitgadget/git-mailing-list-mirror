X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/2] Don't require config file for "stg mail"
Date: Thu, 30 Nov 2006 08:32:08 +0000
Message-ID: <b0943d9e0611300032r38f2b03ai463494930cf63a8a@mail.gmail.com>
References: <20061129035925.6118.78329.stgit@dv.roinet.com>
	 <20061129035930.6118.88435.stgit@dv.roinet.com>
	 <b0943d9e0611290829h291942d7x13247511d16afeee@mail.gmail.com>
	 <1164842841.23643.28.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 30 Nov 2006 08:33:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tCnFVQe6fcX9ncZrWmp3j6FArL0ySoUKQ+nTQKnnrvpiuKmn5ftfJCw3Ngn7CTsbSk3ws5al3ObQkC/132BJXtzGKIYkszNqA0RrdSO0W8jl50mUsG1knm/ybHxEmHYt50672AB37fEIZ1ghPdCX8dm5Nw/nJ0rleYSb9/LJBls=
In-Reply-To: <1164842841.23643.28.camel@dv>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32709>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GphLv-0001de-8L for gcvg-git@gmane.org; Thu, 30 Nov
 2006 09:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759128AbWK3IcK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006 03:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759134AbWK3IcK
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 03:32:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:5197 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1759128AbWK3IcI
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006
 03:32:08 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1281893nze for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 00:32:08 -0800 (PST)
Received: by 10.64.193.8 with SMTP id q8mr4240476qbf.1164875528079; Thu, 30
 Nov 2006 00:32:08 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Thu, 30 Nov 2006 00:32:07 -0800 (PST)
To: "Pavel Roskin" <proski@gnu.org>
Sender: git-owner@vger.kernel.org

On 29/11/06, Pavel Roskin <proski@gnu.org> wrote:
> On Wed, 2006-11-29 at 16:29 +0000, Catalin Marinas wrote:
> > Your patch uses the author of the patch which can be different from
> > the person sending the e-mail. It could indeed use the author from =
GIT
> > variables or configuration (not the patch author) and I already hav=
e a
> > patch from Karl Hasselstr=F6m for this (which I haven't found the t=
ime
> > to check properly).
>
> The funny thing it, GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL are only use=
d
> in the code to determine the author of the patch.

Yes, but only for a newly created patch. If you import a patch from an
mbox or e-mail or simply pass the --author option to "new", the author
will be different.

--=20
