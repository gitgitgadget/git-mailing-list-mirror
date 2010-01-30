From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 01:18:33 +0100
Message-ID: <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com> 
	<alpine.LFD.2.00.1001291628510.1681@xanadu.home> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> 
	<alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 01:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb13F-0006fC-1j
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab0A3ASy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 19:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959Ab0A3ASy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:18:54 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:36573 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab0A3ASx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 19:18:53 -0500
Received: by pzk28 with SMTP id 28so2016183pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 16:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=4xanKX4IHISyQFWfHbk+97NEzqy7OnD1yrRiXFr0fKw=;
        b=Ug0oi2kxV8HAIzPlTUj8JokNNVUgbFm2piG98RlibswRhzy58yLTPfufJt83kQSopK
         1muDDfLOvMub2o1sTicWw3B4yYAgTM3ZGXWbYTf5SBox0TbAAy9076x8bYUS0oQs6ygJ
         JwUVwpnlhGxIO4mw7xpzyELt5cIemInP6sQbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TUypXYXokO7Bm4l1/HQvpUH/ity1gLd8lbqMWqdyi4an48Cnm7oMR9ndiWqUVSKxFh
         gNgS1PveOAiHjs6zqVUtv1KGiqDW0/YVIWGLgb7k1djnNcJdK6nP/ONQzZoKCUBoNHAV
         gb1qE49DbDU3A8nPALTriQ4HVIT2c2FntSvFE=
Received: by 10.142.196.3 with SMTP id t3mr1033077wff.10.1264810733084; Fri, 
	29 Jan 2010 16:18:53 -0800 (PST)
In-Reply-To: <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138406>

Heya,

On Sat, Jan 30, 2010 at 01:14, Junio C Hamano <gitster@pobox.com> wrote:
> +"If you want to create a new branch from this state, you may do so\n"
> +"(now or later) by using -b with the checkout command again.

I think the "this state" needs to be changed, it currently suggests
what you mention earlier in you reply, that it's about the current
state, even if you make commits on top of that. Maybe something in the
spirit of "If you want to create a new branch from ?? where you are at
the moment you follow these instructions ??".

-- 
Cheers,

Sverre Rabbelier
