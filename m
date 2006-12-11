X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: Does pushing to git demon works ?
Date: Mon, 11 Dec 2006 16:56:20 +0600
Message-ID: <200612111656.20664.litvinov2004@gmail.com>
References: <200612111513.05752.litvinov2004@gmail.com> <elj8q6$32n$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 11 Dec 2006 10:56:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JPGyi+cJt8KipywH1F6SO4ktXsfbvSWWVYuj7GTpbfsB8J5Pq226hjfo5S/ej4WSE85IrI4w+8EmSS6IqaDn7YhAnWIxvfUZTPiSaWN9TGmlMsattwoPIpLcR6qkM99HH+tq70OrSm95ijtxg9J3QgHOlypXqM+JxDpLqSC7Xr4=
User-Agent: KMail/1.8
In-Reply-To: <elj8q6$32n$2@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33993>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtipj-0000lL-KI for gcvg-git@gmane.org; Mon, 11 Dec
 2006 11:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762669AbWLKK43 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006 05:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762706AbWLKK42
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 05:56:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:54302 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762669AbWLKK42 convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 05:56:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1291540uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 02:56:27 -0800 (PST)
Received: by 10.78.170.17 with SMTP id s17mr1200011hue.1165834587259; Mon, 11
 Dec 2006 02:56:27 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2]) by mx.google.com with ESMTP id
 33sm2571535hue.2006.12.11.02.56.25; Mon, 11 Dec 2006 02:56:26 -0800 (PST)
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Monday 11 December 2006 15:38 Jakub Narebski =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(a):
> Alexander Litvinov wrote:
> > I tried pushing [to git daemon] without success:
> >
> >$ git push
> > fatal: unexpected EOF
> >
> > What should I do to make it work ?
>
> You cannot make it work. Git by design allow pushing only through
> authenticated protocols. You can push via ssh+git:// and local,
> you can push via http(s):// but you have to configure WebDAV, perhaps=
 in
> the future you would be able to push via ftp(s)://. The git:// and rs=
ync://
> protocols are read-only: you can fetch (pull) but you can't push.
>
> P.S. Please send reply also to git mailing list

