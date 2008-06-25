From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program" over
 SSH connection
Date: Tue, 24 Jun 2008 22:09:52 -0700
Message-ID: <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
References: <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
 <20080624221049.GE29404@genesis.frugalware.org>
 <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
 <20080624233236.GI29404@genesis.frugalware.org>
 <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
 <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
 <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
 <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNHZ-0000jc-En
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbYFYFKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbYFYFKF
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:10:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYFYFKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:10:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A17F17368;
	Wed, 25 Jun 2008 01:10:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 03B9217365; Wed, 25 Jun 2008 01:09:54 -0400 (EDT)
In-Reply-To: <20080625044409.GE11793@spearce.org> (Shawn O. Pearce's message
 of "Wed, 25 Jun 2008 00:44:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7B25B5A-4274-11DD-9994-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86226>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> Any other suggestions that is workable?
>
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 5c5acb4..98d0f0f 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -37,7 +37,7 @@ static int option_quiet, option_no_checkout, option_bare;

<< a patch to conditionally change "git-program" default to "git program"
snipped >>

How would that help client that talk with git-daemon, unlike what I sent
earlier?
