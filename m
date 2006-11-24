X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ignacio Arenaza <iarenuno@eteo.mondragon.edu>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method 
	HTTP/1.x  proxying
Date: Fri, 24 Nov 2006 09:41:41 +0100
Message-ID: <67vel56xtm.fsf@poseidon.eteo.mondragon.edu>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu><2006
	11240548.00840.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 24 Nov 2006 08:41:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611240548.00840.chriscool@tuxfamily.org> (ChristianCouder's
	 message of "Fri, 24 Nov 2006 05:48:00 +0100")
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.4 (gnu/linux)
X-imss-version: 2.044
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32195>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWd9-0006lD-QL for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934458AbWKXIlt convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006 03:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934467AbWKXIlt
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:41:49 -0500
Received: from mx.eteo.mondragon.edu ([193.146.78.131]:5336 "EHLO
 mx.eteo.mondragon.edu") by vger.kernel.org with ESMTP id S934458AbWKXIls
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:41:48 -0500
Received: by mx.eteo.mondragon.edu (Postfix, from userid 1001) id 1EFB8B6B2;
 Fri, 24 Nov 2006 09:41:46 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (poseidon.eteo.mondragon.edu
 [172.31.3.4]) by mx.eteo.mondragon.edu (Postfix) with ESMTP id 4AB15B6B1;
 Fri, 24 Nov 2006 09:41:42 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (localhost [127.0.0.1]) by
 localhost.eteo.mondragon.edu (Postfix) with ESMTP id 23FE62FD65; Fri, 24 Nov
 2006 09:41:42 +0100 (CET)
Received: by poseidon.eteo.mondragon.edu (Postfix, from userid 1072)id 
 095492FD15; Fri, 24 Nov 2006 09:41:42 +0100 (CET)
To: Christian Couder <chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org

Christian Couder <chriscool@tuxfamily.org> writes:

>> +			my $s =3D IO::Socket::INET->new(PeerHost =3D> $serv, PeerPort =3D=
> $port);
>
> It seems that "my " should not be in the above line.

Yup! Your right. Will send a new patch with the fixes in a few hours.

Saludos. I=F1aki.

--=20
School of Management
Mondragon University
20560 O=F1ati - Spain
+34 943 718009 (ext. 225)

