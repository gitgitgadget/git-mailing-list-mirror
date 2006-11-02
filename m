X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Thu, 2 Nov 2006 12:36:31 +0100
Message-ID: <20061102113631.GA30507@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 11:37:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30737>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfasC-0000V8-0w for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752129AbWKBLgh convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 06:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbWKBLgg
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:36:36 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:9745 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1752129AbWKBLgg
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:36:36 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gfas4-00085V-00; Thu, 02 Nov 2006 11:36:32 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-02 10:32:46 +0000, Catalin Marinas wrote:

> On 01/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > This adds a new flag to 'stg mail', allowing the user to hand-edit
> > each patch e-mail before it is sent, just like it is currently
> > possible to edit the cover message.
>
> Applied it but with some conflicts since you have some other patches
> which I haven't merged yet (like QP encoding). I'll try to have a
> look at this QP encoding this week. The main problem is that Gnus
> shows plenty of "=3D20" instead of new lines and 'stg import' cannot
> cope with them.

That Gnus shows =3D20 suggests that I haven't got the QP encoding 100%
right. I haven't had time to look at that yet, and it looks like you
may beat me to it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
