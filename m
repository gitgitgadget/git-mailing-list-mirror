From: Andreas Ericsson <ae@op5.se>
Subject: Re: New repo quickly corrupted
Date: Fri, 16 Nov 2007 08:35:03 +0100
Message-ID: <473D4827.1060109@op5.se>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com> <alpine.LFD.0.9999.0711151708470.21255@xanadu.home> <alpine.LFD.0.9999.0711151434290.4260@woody.linux-foundation.org> <200711160645.04352.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 08:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isvja-0003qG-Rd
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 08:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXKPHfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 02:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbXKPHfJ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 02:35:09 -0500
Received: from mail.op5.se ([193.201.96.20]:39793 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbXKPHfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 02:35:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 438091F08720;
	Fri, 16 Nov 2007 08:35:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFFRrdEBdHsl; Fri, 16 Nov 2007 08:35:05 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id C6DCC1F0871B;
	Fri, 16 Nov 2007 08:35:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <200711160645.04352.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65199>

Christian Couder wrote:
> Le jeudi 15 novembre 2007, Linus Torvalds a =E9crit :
>> On Thu, 15 Nov 2007, Nicolas Pitre wrote:
>>> Does "dos2unix" override file access bits?  Because the object stor=
e is
>>> always made read-only.
>> Almost all programs like that will entirely ignor the fact that some=
thing
>> is read-only.
>=20
> What if the .git/objects/ sudirectories were also read-only ?
>=20

Then git wouldn't be able to write to it without chmod()'ing it each ti=
me.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
