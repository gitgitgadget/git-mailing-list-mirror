From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 18:13:48 +0100
Message-ID: <20130415171348.GI2278@serenity.lan>
References: <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org>
 <516BA732.4080405@viscovery.net>
 <7vzjx01cqn.fsf@alter.siamese.dyndns.org>
 <20130415083558.GB2278@serenity.lan>
 <7vk3o416rq.fsf@alter.siamese.dyndns.org>
 <20130415095920.GE2278@serenity.lan>
 <CAMP44s0u3=FEuifS8KaGy3Y_mjtjeuL1PfChSUco_0TdOXp-jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:14:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmyn-0005Hv-5j
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab3DOROE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:14:04 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57538 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3DOROD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:14:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id EA04223132;
	Mon, 15 Apr 2013 18:14:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z44sHeMK2bW6; Mon, 15 Apr 2013 18:14:01 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id C5503230D3;
	Mon, 15 Apr 2013 18:13:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0u3=FEuifS8KaGy3Y_mjtjeuL1PfChSUco_0TdOXp-jg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221257>

On Mon, Apr 15, 2013 at 11:39:40AM -0500, Felipe Contreras wrote:
> On Mon, Apr 15, 2013 at 4:59 AM, John Keeping <john@keeping.me.uk> wrote:
> 
> > So the question is "what is the natural extension of the current
> > behaviour?", and the answer for me is "it's completely new", but others
> > have different (and conflicting) internal models that give different
> > answers.
> 
> I don't think this does anybody any service. If the current behavior
> is wrong, and if users all over the Internet is any indication, it is;
> we do not want to continue such bad behavior. If the new
> functionality has a different behavior, it only makes sense to change
> the old behavior to make it consistent.

The current "push.default = matching" behaviour may be wrong, but I
haven't seen anyone say that the fundamental "'git push' does something
depending on push.default" and "'git push there ref...' specifies
exactly what to do" is broken.
