From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare 
	repos
Date: Thu, 5 Nov 2009 06:58:08 +0530
Message-ID: <2e24e5b90911041728t72fe2c2fhbea5b8e707236fa@mail.gmail.com>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
	 <alpine.DEB.1.00.0911041422170.2788@felix-maschine>
	 <vpqzl729j72.fsf@bauges.imag.fr>
	 <7v3a4ugjea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 02:28:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5r97-0005is-GF
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 02:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbZKEB2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 20:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbZKEB2F
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 20:28:05 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:50296 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZKEB2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 20:28:03 -0500
Received: by iwn10 with SMTP id 10so5441898iwn.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Potrd1sX7h3Dqqi1GcSflK5EbkXgIa0ElyeooWAwqRk=;
        b=KhXbCxtEiYzeSReYOgIuTeyaQa8J3ayakmLQUDmtacalD17YcJdE2dQhtfOBgcdVkT
         TCoPBonQlAiEt6Zu1MzZuTLu5Zw/czy9TtYzYwNOkGV2EAPeq3fJQbVCtBv343GS/k1T
         HIl65VoV4DFQrE9YBPw0W8JWQ0Yex43g/X+Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G1+eh7vavtTB0Ph2epjO2DlVOEzf0qXI9AVYZ+4t1ToI80MjCQMYcLbsGoP8C2PBfr
         MJrrZ+bEjWTRtmHRPSlepW6sW46RFuXoxtLjsqK3ElR+H6NwABx+6PVToyUN29tM6NAH
         ynWHdu+S0xNor/8aprOJb06ndEuDtSvy19m5c=
Received: by 10.231.125.13 with SMTP id w13mr3547174ibr.32.1257384488947; Wed, 
	04 Nov 2009 17:28:08 -0800 (PST)
In-Reply-To: <7v3a4ugjea.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132186>

On Thu, Nov 5, 2009 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> The single most common reason why a bare repository is bare is becaus=
e
> nobody regularly logs in to the machine that hosts it and goes there =
to
> access its contents. =C2=A0As reflog is a local thing, and not expose=
d to
> outside world, enabling it alone would not help a lot to people who d=
o not
> have such a direct access to the bare repository, which by definition=
 is
> the majority because the reason why the repository is bare to begin w=
ith.
>
> Once we add ways to expose information kept in reflog of a bare repos=
itory
> more effectively and conveniently, the argument could become "should =
be
> enabled now it would be very useful to have one".

It doesn't have to be exposed nor we have to wait till such features
(like you mentioned gitweb, remote log, etc) are implemented.

We're talking "disaster recovery", not "daily use" -- after all,
*someone* has access to the machine, and can become "local" to it.

Regards,

Sitaram
