From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Merging submodules
Date: Fri, 1 Aug 2008 13:34:42 +0200
Message-ID: <8aa486160808010434g7f3c187arc107b994e737cd74@mail.gmail.com>
References: <20080730230336.GA6481@Hermes>
	 <20080731143955.034f0577@pc09.procura.nl>
	 <20080731130626.GQ32184@machine.or.cz>
	 <20080731170123.79e0d3e9@pc09.procura.nl>
	 <8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
	 <20080731201530.067be667@pc09.procura.nl>
	 <8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com>
	 <20080801090422.55c6a45f@pc09.procura.nl>
	 <8aa486160808010252j540a28cdw6e48027396da5248@mail.gmail.com>
	 <20080801123523.33c37e08@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Aug 01 13:35:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOsvB-0000R1-Cj
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 13:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbYHALeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 07:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbYHALeo
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 07:34:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:58286 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbYHALen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 07:34:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so583518ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=U22mavW/u/nCiSMXG6XA31leH3EE0gae5wLOx1VAXb4=;
        b=wie9GV+hOjmC/jHINLHKPzc1EgGWWfnswmwl6Rj+9IOx9bWhzcoWZ+5VaHbt2/zKUO
         H6FjQQegogTf053gG7rT064dUfZK/tpQiUvWmazUillqQtm5nrl3IVbeGys6aywbc8z3
         b/CjVuAyjtfv8yOAYs/hxpNLfPrsCvB0yzYj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pzbrenwxyruaC5y+7EeiyarwFK0LPw5aWMmMw2l4Lu4tP2DNkJA9uMPNkQDDO7CdTL
         KpME56cVbku99bVwEKLVF2TdFYPd2M7ir2HXiFzlELLeSBqbaNnkaRMYNvoz4NLGQfXg
         Pi/p+O3efUowhPP9cY1H91Uo8Ef+jEda9WCVs=
Received: by 10.151.155.10 with SMTP id h10mr3082416ybo.96.1217590482739;
        Fri, 01 Aug 2008 04:34:42 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Fri, 1 Aug 2008 04:34:42 -0700 (PDT)
In-Reply-To: <20080801123523.33c37e08@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91060>

On Fri, Aug 1, 2008 at 12:35, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:

>
> After we join/merge these into the super-project, we're going to remove
> the sup-repos, so all new commits will be made in the super-repo.

If you'll remove the subrepos, the best thing would be to rewrite the
history on those subrepos just moving all the path to the
corresponding subfolder (with git-filter-branch, and you have exactly
what you need at the end of the example section in the manpage). And
then just do a normal merge. Or, even, you could try to create a
project with everything there in the correct order and location, I
don't know if git-filter-branch or git-fast-import/export (you have
some examples in git.git in contrib/fast-import) can do it, but if you
get it, please, post it here because it can be useful for others).

Santi
