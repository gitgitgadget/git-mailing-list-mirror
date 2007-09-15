From: David Kastrup <dak@gnu.org>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 15:59:55 +0200
Message-ID: <85myvoav1g.fsf@lola.goethe.zz>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	<2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	<7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
	<2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
	<20070915025129.GY3099@spearce.org>
	<20070915073845.GB3782@efreet.light.src>
	<20070915075144.GB3099@spearce.org>
	<6bcc356f0709150611i97d31f0yb91016e53c4f5e9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, "Jan Hudec" <bulb@ucw.cz>,
	"Brian Scott Dobrovodsky" <brian@pontech.com>, git@vger.kernel.org
To: "Nikodemus Siivola" <nikodemus@random-state.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYC6-00050M-Qe
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbXIOOAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbXIOOAK
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:00:10 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:42238 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702AbXIOOAI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 10:00:08 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id DC0974C5F0;
	Sat, 15 Sep 2007 16:00:06 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id C8DC6212FAE;
	Sat, 15 Sep 2007 16:00:06 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-048-000.pools.arcor-ip.net [84.61.48.0])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9483636E867;
	Sat, 15 Sep 2007 15:59:58 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 20F9E1C0024C; Sat, 15 Sep 2007 15:59:55 +0200 (CEST)
In-Reply-To: <6bcc356f0709150611i97d31f0yb91016e53c4f5e9f@mail.gmail.com> (Nikodemus Siivola's message of "Sat\, 15 Sep 2007 16\:11\:55 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58242>

"Nikodemus Siivola" <nikodemus@random-state.net> writes:

> One thing that I've been bitten a couple of times is that
> I think I'm on branch X, which should be clean, whereas
> I'm really on branch Y with uncommitted changes. Then I
> checkout another branch, and see the uncommitted work -- and
> given that I have a couple of dozen related feature branches
> in my tree it may take a while to figure which branch the
> uncommitted work came from.

"Take a while"?  What's wrong with git-reflog?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
