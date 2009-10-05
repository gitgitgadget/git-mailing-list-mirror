From: Petter Urkedal <urkedal@nbi.dk>
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Date: Mon, 5 Oct 2009 08:36:49 +0200
Message-ID: <20091005063649.GA25040@eideticdew.org>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
 <20091004133333.GA13894@sigill.intra.peff.net>
 <20091004141355.GA15783@eideticdew.org>
 <20091004182746.GA22995@coredump.intra.peff.net>
 <7v4oqen6my.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuhHc-0002Xh-Ni
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 08:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbZJEGhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 02:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754321AbZJEGhe
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 02:37:34 -0400
Received: from up.nbi.dk ([130.225.212.6]:42681 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbZJEGhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 02:37:34 -0400
Received: from bottom.nbi.dk (bottom.nbi.dk [130.225.212.9])
	by mail2.nbi.dk (Postfix) with ESMTP id A899E3C951;
	Mon,  5 Oct 2009 08:36:56 +0200 (CEST)
Received: by bottom.nbi.dk (Postfix, from userid 32342)
	id AFAE63C005; Mon,  5 Oct 2009 08:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4oqen6my.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129535>

On 2009-10-04, Junio C Hamano wrote:
> It is a command specific aliasing mechanism; not even I use the feature
> these days, since "alias.*" is much easier to use.  But there is no strong
> need to remove it either; it is not too much hassle to keep it for people
> who do use it.  Perhaps deprecate it and remove it in the long run?

I didn't know about alias.*.  Excellent.  I'll be using that.
 
> > Correct. Junio sent a patch to fix this problem in June[1]. I guess he
> > must have dropped his own patch, or he wasn't satisfied with how parse
> > options clobbers things.
> >
> > [1] http://article.gmane.org/gmane.comp.version-control.git/121142
> 
> I had it kept still in my Inbox; thanks for noticing.  Petter's patch does
> essentially the same thing, but the old patch had a better log message
> that described where in the history the fix should apply, so I'd probably
> use that with your test squashed in.

The code is slightly nicer to, I think, but you can probably drop "+ 20"
in the grow-case now.
