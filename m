X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 12:28:56 +0100
Message-ID: <200611151128.57917.andyparkins@gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <200611151033.57415.andyparkins@gmail.com> <20061115104858.GG5453@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 11:29:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jw2CyeJ789RmvWigFtPhSwDdWr/uVlvrN0NlnXFUDFVFctiZ8oJKdQTQS8GcU1PgBElWHSmvmh69DRYk373/FoLfPBcFPULZZ37uHMqotqV6zWfnaBIVW6JyktZEUFeUw75NjbR4+QuQM7sPOLeafPkP1P+yPrLyUL5MOEGPH/4=
User-Agent: KMail/1.9.5
In-Reply-To: <20061115104858.GG5453@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31437>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkIx2-0005KI-HI for gcvg-git@gmane.org; Wed, 15 Nov
 2006 12:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030391AbWKOL3E convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 06:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWKOL3E
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 06:29:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:29304 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030391AbWKOL3D
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006
 06:29:03 -0500
Received: by ug-out-1314.google.com with SMTP id m3so103956ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 03:29:02 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr1536456ugm.1163590141906; Wed, 15
 Nov 2006 03:29:01 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e34sm713415ugd.2006.11.15.03.29.01; Wed, 15 Nov 2006 03:29:01 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 15 10:48, Karl Hasselstr=F6m wrote:

> To me, "origin" just means "where <whatever we're talking about>
> originated". If you think of it that way, it's perfectly obvious that
> each repository can have its own origin.

Of course.  I wasn't saying that I didn't understand why origin was cho=
sen. =20
It's not a completely crazy name - it does have /a/ meaning.  However, =
it's=20
not an unambiguous meaning.  What if the repository I clone was itself =
a=20
clone?  What if the repository it cloned was pulling from three other=20
repositories?  What if those three repositories pull/push from/to each =
other?

  * -- * -- *
   \   |   / \
    \  |  /  /
     \ | /  /=20
       *   /
       |  /=20
       | /
       * <--- "origin"
       |
       * <--- cloned repository

The name "origin" is too close to having an "ultimate source" feel to i=
t IMO. =20
In a distributed system, it's not the right idea to be pushing.  After =
the=20
clone is complete, the "origin" is no more special than any other repos=
itory,=20
and if you felt like it you could change the URL for "origin" and it wo=
uld=20
make very little difference to you.

In short: I don't think "origin" is wrong, I just think it's not right.


Andy
--=20
Dr Andy Parkins, M Eng (hons), MIEE
