From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Add interactive option in rebase command completion list.
Date: Sun, 06 Apr 2008 20:46:15 +0200
Organization: Home - http://www.obry.net
Message-ID: <47F91A77.5080207@obry.net>
References: <1207503144-3008-1-git-send-email-pascal@obry.net> <7vprt2sv60.fsf@gitster.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 20:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZtU-0005WC-BY
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYDFSqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 14:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbYDFSqZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:46:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:27990 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbYDFSqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:46:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so385446nfb.21
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 11:46:20 -0700 (PDT)
Received: by 10.78.137.7 with SMTP id k7mr10284096hud.45.1207507579836;
        Sun, 06 Apr 2008 11:46:19 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.251.208])
        by mx.google.com with ESMTPS id c22sm11460711ika.3.2008.04.06.11.46.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Apr 2008 11:46:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <7vprt2sv60.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78913>

Junio C Hamano a =E9crit :
> Pascal Obry <pascal.obry@gmail.com> writes:
>=20
>> -		__gitcomp "--onto --merge --strategy"
>> +		__gitcomp "--onto --merge --strategy --interactive"
>=20
> I personally do not think this is worth it where a single "-i" is eno=
ugh.

I like unambiguous name (I do prefer --interactive instead of -i). It i=
s=20
painful to enter so the bash completion come quite handy here. The patc=
h=20
is safe, simple and clean, I see no reason to not include it.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
