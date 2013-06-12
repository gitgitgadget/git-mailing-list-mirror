From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 00/31] Follow perlcritic's recommandations
Date: Wed, 12 Jun 2013 23:12:05 +0200
Message-ID: <vpqr4g7owyi.fsf@anie.imag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 23:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmsKz-0000s9-FS
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 23:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab3FLVMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 17:12:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50723 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198Ab3FLVMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 17:12:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CLC3JR014563
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 23:12:03 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmsKr-0001ZB-KV; Wed, 12 Jun 2013 23:12:05 +0200
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
	(=?iso-8859-1?Q?=22C=E9lestin?= Matte"'s message of "Wed, 12 Jun 2013
 17:43:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 23:12:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227681>

Which commit is this based on?

"git am" fails, whether I try from Junio's master, next or pu. My best
try was from da608b124c76f8f7dba8a9d8f0bc8174b9744176. It seems you're
based on a local commit which doesn't exist on Junio's end.

Most commit in-flight are in next, so I guess rebasing the series on
next would make it easier for Junio (we normally send patches against
master as much as possible, see SubmittingPatches for more details).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
