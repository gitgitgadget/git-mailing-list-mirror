From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 00:47:15 +0700
Message-ID: <fcaeb9bf0808261047h3a37c90ds5b41bccd6e0512d7@mail.gmail.com>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <1219764860.4471.13.camel@gaara.bos.redhat.com>
	 <1219766398.7107.87.camel@pmac.infradead.org>
	 <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com>
	 <20080826162513.GR10544@machine.or.cz>
	 <20080826164526.GM26610@one.firstfloor.org>
	 <20080826171012.GO10360@machine.or.cz>
	 <20080826171255.GI26523@spearce.org>
	 <20080826171623.GE5318@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Petr Baudis" <pasky@suse.cz>, "Andi Kleen" <andi@firstfloor.org>,
	"Matthias Kestenholz" <mk@spinlock.ch>,
	"Kristian H??gsberg" <krh@redhat.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	users@kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"David Woodhouse" <dwmw2@infradead.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2eV-0001Cc-Bi
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbYHZRrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757562AbYHZRrS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:47:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:5016 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757228AbYHZRrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:47:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1322956fgg.17
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EVWHPKCPfl3LhCNLL1nFXkRm1Nb1jSW/eA838YexHhk=;
        b=P9HPijYq+BkiqOF3/BfK1AdhfmwYFujJvfW5My5NwPXNeMoHfqn1VMV/W1IV/J/dKn
         EWXG9RD/W73S0YovNiLqsMisXlXwkyFiZrF2NKyyAZOFNig30kXs58pm7bBAcaJXx63+
         zLRJDni2EkzExgrHnQE+A4kPqQ+hrzIwCkpDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LdvLzgW2AfdAjdiBidUiTY1jmdgr6cgiakvZkY8FEl6+iRJI0mIS3/H6d+l3fK9gtE
         8wQIYoMWBZxUTMQlwZrrW6TL1fslyJXGLaGK182sQ3GKa8qOSNDfNrfspKvFmbyCwVc3
         L+q5fhoNs1tbg1zDXj9EJwbQ95QogEGKwnAhA=
Received: by 10.86.27.19 with SMTP id a19mr4510350fga.56.1219772835863;
        Tue, 26 Aug 2008 10:47:15 -0700 (PDT)
Received: by 10.86.30.20 with HTTP; Tue, 26 Aug 2008 10:47:15 -0700 (PDT)
In-Reply-To: <20080826171623.GE5318@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93786>

On 8/27/08, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 26, 2008 at 10:12:55AM -0700, Shawn O. Pearce wrote:
>
>  > I'm the reason why count-objects, ls-tree and checkout-index are
>  > still offered by the bash completion.  And sitting here reading your
>  > email I realized its been _months_ since I last called checkout-index
>  > by hand.  I still run count-objects and ls-tree very so often, but the
>  > average user probably doesn't use ls-tree.
>  >
>  > So yea, these probably should be removed from the completion list.
>  > But I can make a weak argument for keeping count-objects.
>
>
> I think this message shows the conflict in setting up such a list. We
>  want the command set to be as tiny as possible to help new users find
>  their way. But we want the command set to be useful to git power users.
>
>  I wonder if there should be multiple sets of commands for completion,
>  with a minimal set enabled by default, and a "power user" set that
>  exposes extra commands. I dunno. Maybe that is overengineering. I don't
>  even use the bash completion at all.

How about providing a standard set of aliases? All other SCMs I know
do it. You can type it short/quick without depending on bash.
-- 
Duy
