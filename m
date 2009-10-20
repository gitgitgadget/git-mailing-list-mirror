From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 22:49:03 +0200
Message-ID: <81b0412b0910201349o185e9e92l8cb737aa7b75513d@mail.gmail.com>
References: <loom.20091019T094924-194@post.gmane.org>
	 <4ADC2D45.3020803@viscovery.net>
	 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
	 <7v7hur1a0h.fsf@alter.siamese.dyndns.org>
	 <vpqy6n6shri.fsf@bauges.imag.fr>
	 <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.0910201437240.21460@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Ldn-0007Px-FN
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbZJTUtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbZJTUtA
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:49:00 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50457 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbZJTUs7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 16:48:59 -0400
Received: by fxm18 with SMTP id 18so6907354fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hnolHFxO6n3aGHSDasuIMs5SmCZMn3I8ueZy9K8U2fs=;
        b=c8XI8WMZaUm28q7x7kKCn0cyYIbkPI1Wmak0Ajor3BJSDemxmiRcDMX1wBvkaBDrFN
         +ieKY1psDvvfvM8WQowTjt0uHvX67s+rOw5R5pXE+LY9Cx8nT9vuB4j70s0GSeTi1JvX
         XY9fmvTegF/iMu9fMKVe3weJnMmtcFAGK4VD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V3tXhRUFDK8wtGkV1xNePWn0lcsCKxTjsqp9ssXdJSipZT9lBhOHpgIH4MqkY0vDd5
         ToP9dMBetLhxyoKo9jy3i9RjAwzhVI+bfivHw114cpYJ+yPjnajBvTaPb4ECqr5w1USv
         jbRD1WLtedLTskc7FXpLAZECLdJlESLqCbQhE=
Received: by 10.204.3.219 with SMTP id 27mr6847712bko.127.1256071743314; Tue, 
	20 Oct 2009 13:49:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0910201437240.21460@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130846>

On Tue, Oct 20, 2009 at 20:39, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 19 Oct 2009, Junio C Hamano wrote:
>
>> Actually, I changed my mind. =C2=A0I do not think this so big that w=
e need to
>> wait for a major version bump. =C2=A0Why not shoot for 1.6.6?
>
> Agreed. =C2=A0With a prominent note in the release notes to point peo=
ple at
> it when they don't read release notes and complain that fsck suddenly
> became very slow after they upgraded.

I have a feeling that it either wont be noticed at all (i.e., I have ru=
n fsck
with something other than --full only one time in my whole bash history=
,
and never shown it otherwise to anyone else), or people will immediatel=
y
like it ("Oh, finallly! Now that feels like it is doing something!" :)
