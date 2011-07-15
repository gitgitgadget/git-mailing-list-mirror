From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2011, #01; Wed, 6)
Date: Sat, 16 Jul 2011 00:15:47 +0200
Message-ID: <CAGdFq_jjm+nMFy3O0mtqzgAj=0TNrFf475-kbEfg1u2-+51n4A@mail.gmail.com>
References: <7vpqlmhoi0.fsf@alter.siamese.dyndns.org> <7vd3hd6d9o.fsf@alter.siamese.dyndns.org>
 <20110713233919.GA18273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 16 00:16:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhqgT-0006fe-6E
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 00:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab1GOWQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 18:16:28 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50647 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab1GOWQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 18:16:27 -0400
Received: by pvg12 with SMTP id 12so1408610pvg.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hS3FfBLaF49wVmVayaXKOJBGAogNOSzcbkRJZfIGdvw=;
        b=ZarjL9Bzifs1ECy2dEanIpqNde9t4fk15Rrv2Q/YoA3uomcWw/1jWBho9whMk1GL8u
         /iQ8GSPaSgE0XIoOu9xzO5/0oT2T5sSkf4a7Ps91MrDwPZvJ5yJFHYKewfxeAUrhfo2p
         WJQo98mbmboSqxeWyM5ktV77vAAk7uw/BnOn4=
Received: by 10.68.24.67 with SMTP id s3mr5116576pbf.250.1310768187161; Fri,
 15 Jul 2011 15:16:27 -0700 (PDT)
Received: by 10.68.49.39 with HTTP; Fri, 15 Jul 2011 15:15:47 -0700 (PDT)
In-Reply-To: <20110713233919.GA18273@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177239>

Heya,

On Thu, Jul 14, 2011 at 01:39, Jeff King <peff@peff.net> wrote:
> But then the latter series got picked up and merged into Sverre's
> sr/transport-helper-fix branch. =C2=A0I'm not sure what the current s=
tatus of
> that series is.

I've discovered a new bug while working on it (you can't push a new
ref if the remote side already has the commit it points to). I've been
unable to figure out what causes it, but I suppose I'll post a reroll
for review, so that others can have a look.

--=20
Cheers,

Sverre Rabbelier
