X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT repository not clonable?
Date: Sat, 11 Nov 2006 21:59:32 +0000
Message-ID: <b0943d9e0611111359t994d688w9bc6aae8e9183fd3@mail.gmail.com>
References: <200611110359.kAB3ul02013227@laptop13.inf.utfsm.cl>
	 <20061111123634.GD11224@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 21:59:49 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N38DMAPGmCBhGtmPrqbBM475tHR7KVxnkU0FhgWxaLOG5nTTsBjQM6c6+/ehuk9z/sEo5QyZUsTJL29PprgPXhyGe4t3gJGLWxgd1npawQQ0QMR+a3ROq8354/HXebJSv3mq5a7aveGk6+c96s+NcidcnDzEgHMAO4Ff8HU2yw0=
In-Reply-To: <20061111123634.GD11224@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31242>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj0t4-00043G-ON for gcvg-git@gmane.org; Sat, 11 Nov
 2006 22:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947314AbWKKV7e convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947319AbWKKV7e
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 16:59:34 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:25142 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1947314AbWKKV7d
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006
 16:59:33 -0500
Received: by py-out-1112.google.com with SMTP id a29so480978pyi for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 13:59:33 -0800 (PST)
Received: by 10.35.9.2 with SMTP id m2mr6859249pyi.1163282372775; Sat, 11 Nov
 2006 13:59:32 -0800 (PST)
Received: by 10.35.109.8 with HTTP; Sat, 11 Nov 2006 13:59:32 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-11-11 00:56:47 -0300, Horst H. von Brand wrote:
> > I'm trying to update my StGIT repo here, and get a crash from
> > git-http-fetch (git 1.4.3.4). Trying to clone it anew gives:
>
> It works for me, with
>
>   $ git --version
>   git version 1.4.3.3.g8387
>
> But it's horribly slow. Catalin, have you ever packed that repository=
?

I've never packed it. IIRC, there was some advise in some GIT document
or e-mail saying that you shouldn't pack if the export is over a dumb
protocol. That's good for people pulling regularly but bad for
cloning.

Anyway, thanks to Pasky, you can now pull/clone it over the git
protocol directly - git://repo.or.cz/stgit.git. This repository is up
to date. I have a plan to move the main StGIT repository to Pasky's
server but I'm a bit busy with other things at the moment.

--=20
