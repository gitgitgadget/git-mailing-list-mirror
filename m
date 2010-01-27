From: Michael Spang <spang@google.com>
Subject: Re: [PATCH] Fix git rev-list --reverse --max-count=N
Date: Wed, 27 Jan 2010 17:51:02 -0500
Message-ID: <abef960f1001271451n5ed454aaye1591ea35729b53f@mail.gmail.com>
References: <1264622600-20981-1-git-send-email-spang@google.com>
	 <201001272309.26054.j6t@kdbg.org>
	 <7vsk9rnpxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:51:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaGjN-0002LI-KS
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 23:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418Ab0A0WvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 17:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756387Ab0A0WvS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 17:51:18 -0500
Received: from smtp-out.google.com ([216.239.44.51]:36754 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116Ab0A0WvR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 17:51:17 -0500
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id o0RMpEr0003598
	for <git@vger.kernel.org>; Wed, 27 Jan 2010 14:51:14 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1264632675; bh=GRvQL9/4n6OILEFDRfK3MoFVpEc=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=mLcITD+bMobIKkrz1E/+aLRnTtogTpMAVtoTHcrS+Ips9aKvO59DX32gk64DMSHeY
	 9d+uzzH+4jBPyskZZQHoQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=mKzsatSOli0HM5gd4T2eUB96AnW/ebfZ1BqWsWIYhtQMjqhk4Zx97rb6QGqcOIx65
	pGq0Gawng9XGC2JyJUVhQ==
Received: from fxm4 (fxm4.prod.google.com [10.184.13.4])
	by spaceape12.eur.corp.google.com with ESMTP id o0RMpDPU008303
	for <git@vger.kernel.org>; Wed, 27 Jan 2010 14:51:13 -0800
Received: by fxm4 with SMTP id 4so100325fxm.12
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 14:51:13 -0800 (PST)
Received: by 10.102.207.4 with SMTP id e4mr5098963mug.126.1264632662338; Wed, 
	27 Jan 2010 14:51:02 -0800 (PST)
In-Reply-To: <7vsk9rnpxo.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138205>

On Wed, Jan 27, 2010 at 5:28 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Johannes Sixt <j6t@kdbg.org> writes:
>
> The interaction between --max-count and --reverse was designed a long=
 time
> ago to support "I want to review the recent N commits in order to mak=
e
> sure that they are natural and logical progression". =A0So an uncondi=
tional
> change of semantics to break that expectation this late in the game w=
ill
> never be acceptable, and giving title to such a patch with a word "Fi=
x"
> won't fly well (it simply _breaks_ behaviour users have long learned =
to
> expect).

You have my apology for calling it a fix. I just don't have the same
visibility into what undocumented behavior users depend on that you
do, and so I thought it actually was one.

The patch can die here. I understand the current behavior now, and I
don't have a strong need for the behavior I expected (piping to head
works fine).

Michael
