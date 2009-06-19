From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH] t8005: Nobody writes Russian in shift_jis
Date: Fri, 19 Jun 2009 14:25:52 +0400
Message-ID: <bb6f213e0906190325s8fd18d7u8cc29d710cf2e286@mail.gmail.com>
References: <7vmy85m0ea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHbII-000198-0W
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 12:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbZFSKZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 06:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753809AbZFSKZv
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 06:25:51 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:35403 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbZFSKZu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 06:25:50 -0400
Received: by ewy6 with SMTP id 6so2399417ewy.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f997KmfR5jP9p9Ccw6RS5cKRBBv1bnJIT1sAkN+vhDs=;
        b=C32Ninc960XFLCHSxzbcD4+B49W9Z29m9DLtCR7NKSxQRZifPfv4IeVCBQJIE44JhE
         gO42Ge6KGAhqafij3HuDWgIqmz5N0hfyQFypf9uHZ7mHgmk3l8a8Nn338FYS7+TKDSAU
         5Y/7tMO8jrw8Hjql9hhYsD19bkk7JmbhQTjIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tsta62b4qxUlzeT9OPi42ZHcdpBYVXAPxwmGOmR13hl4cLaUnOfR3yc0YVsPDnMCK1
         jPHYojJ3LRXX+869CWhFqen/qo+sH+nQFtCliZLnK+NPIdvT+nI34cXZlxciBZ5F2Twl
         UA1PkPxs+5U/9tdWqIrueySEIp7WCL+k84Y5w=
Received: by 10.210.65.2 with SMTP id n2mr487895eba.1.1245407152364; Fri, 19 
	Jun 2009 03:25:52 -0700 (PDT)
In-Reply-To: <7vmy85m0ea.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121894>

On Fri, Jun 19, 2009 at 6:18 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> =A0* I am Cc'ing Alexander because he originally wrote this test usin=
g
> =A0 cp1251 and shift_jis, and I could be wrong in saying that nobody =
sane
> =A0 writes Russian in shift_jis.

Well, certainly not intentionally, but I've managed to send a few
work-related emails in sjis accidentally (resulting in much confusion
for the people on the other side), and thought it is a bit funny :)

I'd guess that almost nobody uses iso8859-5 as well, though. Nobody
that I know, anyway.

Alexander
