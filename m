X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Wed, 8 Nov 2006 10:12:43 +0000
Message-ID: <b0943d9e0611080212q35dae8d0w2642ed1d0189f8fe@mail.gmail.com>
References: <eile19$p7r$1@sea.gmane.org>
	 <20061106074532.10376.60478.stgit@localhost>
	 <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com>
	 <b0943d9e0611071109w584f4f7fv3ba1b7dbd9413717@mail.gmail.com>
	 <20061108084038.GA3164@diana.vm.bytemark.co.uk>
	 <b0943d9e0611080141y3751039v37b0289147237e4f@mail.gmail.com>
	 <20061108100103.GA18117@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 8 Nov 2006 10:13:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dyaSP/YzO5PCoUyaP0KyCJRxLrhrAyCprR5s9Eu/Y911tBFII2TpbVrgP3vsXRrmUBNC/FyKGpmWGoD02LWYv6F+vuoFX+0coprK9nZgz2bdVpNYcGIo+0FOH6oDvqVJNbcH0Pdu53pScLfJASkW9TUjdhBjgWemlBIVsChae0A=
In-Reply-To: <20061108100103.GA18117@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31133>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhkQK-0003bu-Hz for gcvg-git@gmane.org; Wed, 08 Nov
 2006 11:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964973AbWKHKMp convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 05:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWKHKMp
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 05:12:45 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:11085 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S932367AbWKHKMo
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 05:12:44 -0500
Received: by py-out-1112.google.com with SMTP id a73so1469915pye for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 02:12:43 -0800 (PST)
Received: by 10.35.39.13 with SMTP id r13mr15088402pyj.1162980763790; Wed, 08
 Nov 2006 02:12:43 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Wed, 8 Nov 2006 02:12:43 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 08/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-11-08 09:41:33 +0000, Catalin Marinas wrote:
> > It would be great if you can run a test script. I've been thinking
> > more of an "import" test that also checks both the "export" and "ma=
il"
> > commands.
>
> I didn't originally plan to thest the actual e-mail sending, but now
> that I think of it, a simple script listening on a random port,
> pretending to be an SMTP daemon, should be quite simple to set up.

I'm not sure it's worth the hassle. You could just generate an mbox
file with "mail" and import it with "import --mbox" (it will hopefully
be ready this week). Problems with SMTP would be noticed quickly
anyway.

--=20
