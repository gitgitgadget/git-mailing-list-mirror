From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
 unknown command
Date: Sun, 08 Jun 2008 10:53:51 -0700
Message-ID: <7vskvnke34.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
 <20080607072721.GA3347@steel.home> <alpine.DEB.1.00.0806071603470.1783@racer>
 <20080607175103.GA5822@steel.home>
 <7vmylxnmnz.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806081607040.1783@racer> <484BF751.1000203@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Jun 08 19:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5P71-0001AG-7H
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 19:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbYFHRyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 13:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYFHRyF
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 13:54:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbYFHRyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 13:54:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F5DF3931;
	Sun,  8 Jun 2008 13:54:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B3E2D392F; Sun,  8 Jun 2008 13:53:55 -0400 (EDT)
In-Reply-To: <484BF751.1000203@dirk.my1.cc> (Dirk =?utf-8?Q?S=C3=BCsserott?=
 =?utf-8?Q?'s?= message of "Sun, 08 Jun 2008 17:14:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DFE6C0AE-3583-11DD-B719-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84300>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> Johannes Schindelin schrieb:
>> This patch is not meant for inclusion, as indicated by the "TOY
>> PATCH" prefix.

Yes, I understand it.

I was not complaining about the "who cares, we will exit after we are d=
one
with this processing anyway" attitude in this code.  I think it is a
reasonable approach to take because it is not likely that this codepath=
 to
change and would start wanting to access the original command table aft=
er
it did its munging.  I was suggesting a positive improvement to the pat=
ch
by making it explicitly documented to help people polish further, that'=
s
all.  You do not have to be so defensive.

> What a pity! :-( I liked it.

Likewise.
