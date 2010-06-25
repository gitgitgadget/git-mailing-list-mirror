From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: Maintaing database schemas using GIT
Date: Fri, 25 Jun 2010 15:24:02 +0200
Organization: Ensimag
Message-ID: <97212a23f3836a60534c712ffefd8fc0@ensimag.fr>
References: <AANLkTind3ZYRb3NqrO8a9Lg06_Vt2crWP7yKX2bKYorx@mail.gmail.com>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Bartosz Wiklak <bwiklak@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 15:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS8tB-0007d2-I6
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 15:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab0FYNYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 09:24:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34225 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863Ab0FYNYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 09:24:07 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5PDNv4m022539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jun 2010 15:23:57 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5PDO2wW009784;
	Fri, 25 Jun 2010 15:24:02 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o5PDO2Bb003123;
	Fri, 25 Jun 2010 15:24:02 +0200
In-Reply-To: <AANLkTind3ZYRb3NqrO8a9Lg06_Vt2crWP7yKX2bKYorx@mail.gmail.com>
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Jun 2010 15:23:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5PDNv4m022539
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
MailScanner-NULL-Check: 1278077038.09447@rgfPV9loSNAM/q44UEcqHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149681>

Git allows you to specify an external diff driver for some kind of files:

http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#_defining_an_external_diff_driver

This should help you
