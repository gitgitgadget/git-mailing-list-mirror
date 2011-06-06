From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Mon, 6 Jun 2011 15:05:31 +0200
Message-ID: <BANLkTimFUkTx_UDWwh_1_7dzJr1onHQW5g@mail.gmail.com>
References: <20110603050901.GA883@sigill.intra.peff.net> <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com> <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org> <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Dmitry Ivankov <divanorama@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:06:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTZVa-0004dR-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 15:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab1FFNGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 09:06:14 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50456 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab1FFNGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 09:06:12 -0400
Received: by qyk7 with SMTP id 7so759441qyk.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=E6vX9loQNPtyQoZ9qNvTnKuVfryPgEPzRREzODdDGzk=;
        b=SksqKm1f9zWJ8K4CufhtPKrVo71R8UL4JamvvCzeV+rCsun/f4ojDEsn9xD7uju+mX
         2aHntg5IkZxYjcDXeMzEk2JuJt0Vw9ULCHviv3VhgZsWCXICizGg3HBlw4+9nGTv3gx2
         dRQ8nfz3+HxzWhpI+tgYzQc+R65n+3ZJ58SSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FUrWTGNKCFW/+pgXToLzyBHVllMfwP1UVj0aWMlgC/2CiEnSb2PO1YeZZUvsnt3HpS
         KnEMRgXm/tBrKIqyLkqkH6CBJLIyfFiDSFfBFN/wWG5eBBky7/TJlC04fgTBRqsWZo6Q
         nTfHCqoVZ14Yz48XJBDaqHBJTxv0vs1huYtY0=
Received: by 10.229.135.12 with SMTP id l12mr3569129qct.53.1307365571368; Mon,
 06 Jun 2011 06:06:11 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Mon, 6 Jun 2011 06:05:31 -0700 (PDT)
In-Reply-To: <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175122>

Heya,

On Mon, Jun 6, 2011 at 03:00, Junio C Hamano <gitster@pobox.com> wrote:
> I'll queue it separately as a tentative commit (below) and leave it in
> 'pu' for now. Please give it a better description so that we can move the
> fix forward.

Seems like an accurate description to me, what do you feel is missing?

-- 
Cheers,

Sverre Rabbelier
