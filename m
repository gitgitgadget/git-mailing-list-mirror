From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH v6] autoconf: Test FREAD_READS_DIRECTORIES
Date: Mon, 10 Mar 2008 09:54:27 +0100
Organization: NextSoft
Message-ID: <200803100954.27898.michal.rokos@nextsoft.cz>
References: <200803092144.04440.michal.rokos@nextsoft.cz> <7vy78rksk8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYdmy-000094-8T
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 09:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbYCJIyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 04:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYCJIyl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 04:54:41 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:37560 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbYCJIyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 04:54:41 -0400
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id D2FFC57B; Mon, 10 Mar 2008 09:54:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 1133D5C8;
	Mon, 10 Mar 2008 09:54:38 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06947-09; Mon, 10 Mar 2008 09:54:37 +0100 (CET)
Received: from [10.20.0.22] (unknown [10.20.0.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 953C255D;
	Mon, 10 Mar 2008 09:54:37 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy78rksk8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76707>

On Monday 10 March 2008 07:21:27 Junio C Hamano wrote:
> Looks fine to me.  I was not keeping on an close eye on the discussio=
n,
> however.  Can we have a list of platforms we saw success stories on, =
so
> that I can mention them when I queue this?

Linux 2.6.25-rc4 - FREAD_READS_DIRECTORIES=3D
Tested-by: Michal Rokos <michal.rokos@nextsoft.cz>

HP-UX B.11.11 - FREAD_READS_DIRECTORIES=3DUnfortunatelyYes
Tested-by: Michal Rokos <michal.rokos@nextsoft.cz>

HP-UX B.11.23 - FREAD_READS_DIRECTORIES=3DUnfortunatelyYes
Tested-by: Michal Rokos <michal.rokos@nextsoft.cz>

AIX 5.3 - FREAD_READS_DIRECTORIES=3DUnfortunatelyYes
Tested-by: Mike Ralphson <mike@abacus.co.uk>

Tru64 V5.1 - FREAD_READS_DIRECTORIES=3DUnfortunatelyYes
Tested-by: Michal Rokos <michal.rokos@nextsoft.cz>

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
