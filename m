From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Wed, 20 Jan 2010 11:06:47 +0100
Message-ID: <81b0412b1001200206h31b61c00p218a5278996993b2@mail.gmail.com>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
	 <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
	 <20091120192800.6117@nanako3.lavabit.com>
	 <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
	 <81b0412b1001190754m37ed01b0nd93b318d77d88a75@mail.gmail.com>
	 <7vk4ve9dad.fsf@alter.siamese.dyndns.org>
	 <7vska15u92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXSh-00076X-Fz
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab0ATKGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 05:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550Ab0ATKGv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:06:51 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49660 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0ATKGu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 05:06:50 -0500
Received: by bwz19 with SMTP id 19so3663383bwz.28
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mVb86cjw+4dYOOcYiENPGi8r4IVpE3Cuun9oZ68uK9s=;
        b=qL8fTEDhTTg7L3zml3K5pQ2OPiXA1Lh3UNfu/EkLDD2DZd1XfQUocTaBpEtfWTAcCq
         gBkY9nB0BV5JDxmxoqNf1fBSx6EWVeJFaAomocFKbBe0oCan6R4WaDIL2exrkYe144ww
         4vPC9guATzCNlO8I7nYXnu+Zc1C1v9fLWsOC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rl/jMTxALmZCVsUcdRGpNcWlDy/FXUeXjSt9TD28Zq9wvQCqq8m1S+5PtjXnifR62W
         DrE3P+IuhXy2WkG1SzUo8jV6w4WA8hSNVR0vpgorsV6orZEKDaTy28yEkLIHsOKrsMZF
         u1HVRum4JB6OHkFd+jZo2U9TxVegxPj8vDY2g=
Received: by 10.204.48.144 with SMTP id r16mr4608141bkf.170.1263982008053; 
	Wed, 20 Jan 2010 02:06:48 -0800 (PST)
In-Reply-To: <7vska15u92.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137535>

On Wed, Jan 20, 2010 at 04:29, Junio C Hamano <gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>>> This breaks "checkout to merge base" on Windows and t2012 in partic=
ular.
>
> I think the attached patch would help. =C2=A0If this fix is Ok with W=
indows

=46WIW, I confirm that it does. The test passes.
