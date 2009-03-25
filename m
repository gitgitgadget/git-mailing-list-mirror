From: Pascal Obry <pascal@obry.net>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 19:36:10 +0100
Organization: Home - http://www.obry.net
Message-ID: <49CA799A.6020807@obry.net>
References: <49CA7428.70400@obry.net> <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:37:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXyq-0000MF-A4
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758634AbZCYSgD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 14:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbZCYSgC
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:36:02 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55393 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397AbZCYSgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:36:00 -0400
Received: by bwz17 with SMTP id 17so172553bwz.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 11:35:57 -0700 (PDT)
Received: by 10.103.172.7 with SMTP id z7mr4314836muo.129.1238006156737;
        Wed, 25 Mar 2009 11:35:56 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-49-205.w82-124.abo.wanadoo.fr [82.124.151.205])
        by mx.google.com with ESMTPS id 25sm15025436mul.51.2009.03.25.11.35.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 11:35:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.0
In-Reply-To: <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114642>

Junio C Hamano a =E9crit :
> That's not even an revert. =20

Right.

> Can't you simply amend it away?
>=20
> 	$ git rm not-this-file
>         $ git commit --amend

Right, I've done that. But the fact that un-committing the initial
commit was not possible seemed strange to me. At least the error messag=
e
should be clearer, don't you think?

Thanks.
Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
