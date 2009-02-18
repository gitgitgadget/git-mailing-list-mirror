From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 11:06:34 +0100
Message-ID: <0E74A2BF-1E59-4D82-A750-380697667F10@wincent.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org> <1234911457-37188-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:08:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZjM7-0000Tw-VB
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 11:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbZBRKGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Feb 2009 05:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbZBRKGw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 05:06:52 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:58993 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZBRKGv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2009 05:06:51 -0500
Received: from cuzco.lan (54.pool85-53-5.dynamic.orange.es [85.53.5.54])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1IA6ZxA023056
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 18 Feb 2009 05:06:36 -0500
In-Reply-To: <1234911457-37188-1-git-send-email-jaysoffian@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110519>

El 17/2/2009, a las 23:57, Jay Soffian escribi=F3:

> test_expect_success 'refusing to edit in refs/heads/' '
> 	(MSG=3D1 GIT_NOTES_REF=3Drefs/heads/bogus &&
> -	 export MSG=3D GIT_NOTES_REF=3Drefs/heads/bogus &&
> +	export MSG GIT_NOTES_REF &&
> 	 test_must_fail git notes edit)
> '
>
> test_expect_success 'refusing to edit in refs/remotes/' '
> 	(MSG=3D1 GIT_NOTES_REF=3Drefs/remotes/bogus &&
> -	 export MSG=3D GIT_NOTES_REF=3Drefs/heads/bogus &&
> +	 export MSG GIT_NOTES_REF &&
> 	 test_must_fail git notes edit)
> '

Perhaps my eyes are playing tricks on me but I see the original =20
version setting MSG to an empty string and exporting it, and your =20
version setting MSG to "1" and exporting it. So which one is wrong? =20
The original or yours?

Cheers,
Wincent
