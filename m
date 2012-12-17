From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 09:43:53 +0100
Message-ID: <877goht6eu.fsf@pctrast.inf.ethz.ch>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
	<7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
	<20121212094432.6e1e48c8@chalon.bertin.fr>
	<7v38zb3ux0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkWJB-0000Si-4H
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 09:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab2LQIn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 03:43:59 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:46669 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992Ab2LQIn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 03:43:58 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Dec
 2012 09:43:53 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 17 Dec 2012 09:43:55 +0100
In-Reply-To: <7v38zb3ux0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 12 Dec 2012 11:57:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211660>

Junio C Hamano <gitster@pobox.com> writes:

> Yann Dirson <dirson@bertin.fr> writes:
>
>> ....  In this respect, they seem to be
>> lacking a few features, when compared to "replace" refs, but they have different
>> uses, ...
>
> Not reallyl; grafts were old hack whose use is still supported with
> its original limitations; replace is meant to replace all uses of
> grafts while removing grafts' largest warts.

I suppose there's the additional issue that grafts are much easier to
use than replacements if you really only want to replace some parent
lists.  With replace you need to handcraft the replacement commits, and
git-replace(1) unhelpfully does not say this, much less gives an example
how to do it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
