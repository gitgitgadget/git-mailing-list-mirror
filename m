From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] diff --no-index: support more than one file pair
Date: Thu, 12 Jan 2012 10:14:21 +0100
Message-ID: <vpq39bll1ua.fsf@bauges.imag.fr>
References: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 10:14:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlGjz-0003Dw-2H
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 10:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab2ALJOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 04:14:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55681 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084Ab2ALJO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 04:14:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0C9Cqe4011942
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Jan 2012 10:12:52 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RlGjl-0003DR-AE; Thu, 12 Jan 2012 10:14:21 +0100
In-Reply-To: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 12
 Jan 2012 16:09:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Jan 2012 10:12:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0C9Cqe4011942
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1326964376.18351@T04juWe3Tgok2qx70QxSnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188437>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This allows you to do
>
> git diff --no-index file1.old file1.new file2.old file2.new...
>
> It could be seen as an abuse of "git --no-index", but it's very
> tempting considering many bells and whistles git's diff machinery
> provides.

I find this very, very unintuitive. I tried with GNU diff:

diff 1 2 3 4

and it complained with "diff: extra operand `3'". I find

git diff --no-index file1.old file1.new
git diff --no-index file2.old file2.new

far more intuitive, less error prone (when you start having a
non-trivial list of arguments, it's hard to tell which is the new and
which is the old visually), ... So I'm curious why you prefer your
syntax.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
