From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Mon, 01 Oct 2007 16:11:54 -0700
Message-ID: <7vabr2qvk5.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	<11912513203420-git-send-email-tom@u2i.com>
	<7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
	<550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
	<87ejgescnb.wl%cworth@cworth.org>
	<550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
	<20071001223050.GE2137@spearce.org> <87d4vysayq.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Tom Clarke <tom@u2i.com>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcUQu-00056f-9V
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 01:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbXJAXMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 19:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbXJAXMF
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 19:12:05 -0400
Received: from rune.pobox.com ([208.210.124.79]:60739 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbXJAXME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 19:12:04 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8610713FB10;
	Mon,  1 Oct 2007 19:12:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B1B6313F94D;
	Mon,  1 Oct 2007 19:12:17 -0400 (EDT)
In-Reply-To: <87d4vysayq.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	01 Oct 2007 15:53:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59646>

Carl Worth <cworth@cworth.org> writes:

> Though actually I'd like it even more if there was some way to mark a
> commit as having been "published" and the rebase strategy would refuse
> to rebase published commits.

That is not "though actually", but an independent topic.

The need is indeed so real that there is a hook git-rebase pays
attention to in order to help you with that.  I use it to
prevent myself from accidentally rebasing the topic branches
that I already merged to 'next'.

Unsurprisingly, it is called pre-rebase hook.
