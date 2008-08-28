From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:15:08 +0300
Message-ID: <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
	 <20080827001705.GG23698@parisc-linux.org>
	 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
	 <1219907659.7107.230.camel@pmac.infradead.org>
	 <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
	 <1219912327.7107.245.camel@pmac.infradead.org>
	 <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com>
	 <20080828115408.GA30834@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Woodhouse" <dwmw2@infradead.org>,
	"Matthew Wilcox" <matthew@wil.cx>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	users@kernel.org, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Al Viro" <viro@hera.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 15:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhMJ-0006bV-Rq
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYH1NPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 09:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYH1NPL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:15:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44016 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYH1NPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:15:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so394913rvb.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vqOxy9B/lYzQG97uWbkclUpXcSa/kMvYhS9i97gBk9c=;
        b=GbThKEae2oGpFKKeShYLBtADhZkXaL5gryGRxhFrBwI36MvWG8fNZqN1Sp0w0/2t5V
         DUvM5JMWyKrGgETqQP6S1vSRzjQWHaocfyjPnKdJ99gjn6JybaIFEiw3S8K/SI8gBSfi
         o/ftErouDWK0/dUwEdA0bV8IBMkZScXVdlNZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Dui2ZbfLhTRHXONYzeuAy3D+tsrbwdLI8YIV3Rba8PfyiQ3Q2VSl7s8xbVK8sAgWcJ
         1VTbvwu+KuEkuWgQpQ0H5u+hysSQZ7Jqbepuw+C8nHA1O2jUVS/hOSAyyJezZjLJt0Gy
         NUhbR8RmniV0rzbGQms89Zh8KA5vRjcQ1HGFE=
Received: by 10.141.27.16 with SMTP id e16mr712888rvj.136.1219929308843;
        Thu, 28 Aug 2008 06:15:08 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Thu, 28 Aug 2008 06:15:08 -0700 (PDT)
In-Reply-To: <20080828115408.GA30834@hera.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94050>

On Thu, Aug 28, 2008 at 2:54 PM, Al Viro <viro@hera.kernel.org> wrote:
> On Thu, Aug 28, 2008 at 11:57:56AM +0300, Felipe Contreras wrote:
>
>> The masses should forget about the git-foo form. If you push people
>> into using git-foo then you are not following git guidelines; you
>> would be pushing your own agenda.
>
> Egads...  For sarcasm it's far too heavy-handed and if that's for real...
> What's next, verbal diarrhea about Diluting the Message(tm)?

Sorry, I guess I should have made it clearer.

I haven't made my mind about git-foo vs "git foo", but a decision has
been made to deprecate git-foo, and allow it as an option for the
people that really want to use it, right?

So there must have been a reason to deprecate git-foo, if people keep
using git-foo, and distributions keep allowing it, what's the point of
deprecation? It's ok if they keep that usage to themselves, like
'alias ll = ls -l', but it's not something to assume everybody uses.

So either we take back the decision and keep discussing if it's a good
idea to deprecate git-foo, or we go forward and discourage git-foo
completely.

Anything in the middle would just confuse people more, and wouldn't
achieve the purpose of deprecation.

If some script is relying on git-foo, and it has been deprecated, it
should be fixed.

Best regards.

-- 
Felipe Contreras
