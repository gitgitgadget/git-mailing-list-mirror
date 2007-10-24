From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/7] Bisect: factorise "bisect_write_*" functions.
Date: Wed, 24 Oct 2007 06:09:54 +0200
Message-ID: <200710240609.54597.chriscool@tuxfamily.org>
References: <20071014142938.d722299c.chriscool@tuxfamily.org> <7v640x7a4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 06:03:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkXST-0007CC-Ma
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 06:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbXJXECy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2007 00:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbXJXECy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 00:02:54 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37990 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbXJXECx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2007 00:02:53 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7A7B51AB2C2;
	Wed, 24 Oct 2007 06:02:51 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 62E871AB2BF;
	Wed, 24 Oct 2007 06:02:51 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7v640x7a4n.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62185>

Le mercredi 24 octobre 2007, Junio C Hamano a =E9crit :
> Sort of offtopic, but is "factorise" a correct verb here?  I
> thought "factorise" is to express a non prime number as the
> product of prime numbers.

English is not my mother tongue so I very often make mistakes.
Sorry about that.

Anyway my prefered online dictionary finds it:

http://www.wordreference.com/definition/factorise

> "refactor" is the act of splitting and merging pieces of
> functions for better reuse, isn't it?

Yes, it would be better.

I used "factorise" because as a french native speaker, I am always temp=
ted=20
to use word that sound the same as their french translation.

By the way I realised that the "bisect_write" function is still=20
missing 'nolog=3D"$3"', so I will send an updated patch.

Thanks,
Christian.
