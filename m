X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/2] New stg command: assimilate
Date: Wed, 25 Oct 2006 17:41:50 +0100
Message-ID: <b0943d9e0610250941jfd5d11fk467ab586773ba205@mail.gmail.com>
References: <20061022130559.17015.51385.stgit@localhost>
	 <20061022130802.17015.50188.stgit@localhost>
	 <20061025163231.GA30478@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 16:42:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QIyCfvtflskE3AK+0FhGiVib0i3XbIjjPrYbttLSWWzgrbNzxlMWzLy+4GlOMEzLInqawEwpJEAXO8Hwp/AtrQCQugOPXiP9RByeCfUwHtTX8E2WSrnBKZSIu9qiJxh/6fYaQXF9VZ5KK5Z2x9loNxcChR2CsCGCPiio4RUN6bc=
In-Reply-To: <20061025163231.GA30478@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30076>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GclpF-0002as-Vu for gcvg-git@gmane.org; Wed, 25 Oct
 2006 18:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423241AbWJYQlw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWJYQlv
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 12:41:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:5139 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1423241AbWJYQlv
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006
 12:41:51 -0400
Received: by nz-out-0102.google.com with SMTP id z3so136890nzf for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 09:41:50 -0700 (PDT)
Received: by 10.35.12.13 with SMTP id p13mr1345132pyi; Wed, 25 Oct 2006
 09:41:50 -0700 (PDT)
Received: by 10.35.103.18 with HTTP; Wed, 25 Oct 2006 09:41:50 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 25/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-10-22 15:08:02 +0200, Karl Hasselstr=F6m wrote:
>
> > +    def name_taken(name):
> > +        return patchname in name2patch or crt_series.patch_exists(=
patchname)
>
> I just realized, by means of an infinite loop, that "patchname" shoul=
d
> be replaced with just "name" in the body of this function. Would you
> like me to resend the patch?

I can do it, no need to resend. I'll push the patch tonight and you
can check it (I also fixed the "reversed" call as it is not available
in my Python implementation).

--=20
