X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 09:39:57 +0000
Message-ID: <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
References: <20061101090046.1107.81105.stgit@localhost>
	 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
	 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 09:40:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=phg49kZl4yHay9bPDVyue5M1D8OZimW5gwjp1YWxqtva6n8kP5nYTbWJVmX4st1U3IjRCWGMsnwYt8fzANhsm+TQOaU8WcVap/KjR5GQOogNvhLH2fdINctzPu3xh8CSIaG8PO5SIcnCsRP/ntEyyrSVECpvigEb4vAvuQTEJn4=
In-Reply-To: <20061102113631.GA30507@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30807>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfvWr-0007EK-FY for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752724AbWKCJj6 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 04:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbWKCJj6
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:39:58 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:700 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1752724AbWKCJj6
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 04:39:58 -0500
Received: by py-out-1112.google.com with SMTP id a73so281189pye for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 01:39:57 -0800 (PST)
Received: by 10.35.51.13 with SMTP id d13mr2930343pyk.1162546797457; Fri, 03
 Nov 2006 01:39:57 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Fri, 3 Nov 2006 01:39:57 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 02/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> That Gnus shows =3D20 suggests that I haven't got the QP encoding 100=
%
> right. I haven't had time to look at that yet, and it looks like you
> may beat me to it.

Well, it might be just the way I read the list (via the gmane news
gateway) but I have to run some tests. However, I'd like the message
body to still be 8bit and the QP encoding optional (either command
line option or [stgit] config variable).

--=20
