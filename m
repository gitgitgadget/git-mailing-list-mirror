From: Tait <git.git@t41t.com>
Subject: Re: [PATCH v2 2/2] grep: long context options
Date: Mon, 1 Aug 2011 18:01:43 -0700
Message-ID: <20110802010143.GL13795@ece.pdx.edu>
References: <4E357BE2.8030409@lsrfire.ath.cx>
 <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com>
 <4E36C840.9000808@lsrfire.ath.cx>
 <CAGdFq_go0xYy9BZWRDxAFGV95G7V-P9-=7VhsodLd+z-ho09Qw@mail.gmail.com>
 <4E36E0EC.1000508@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 02 03:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo3XV-0004Ct-9w
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 03:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1HBBMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 21:12:53 -0400
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:58510 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1HBBMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 21:12:51 -0400
X-Greylist: delayed 659 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Aug 2011 21:12:51 EDT
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p7211i5X031302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Aug 2011 18:01:44 -0700
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id p7211ihc013739;
	Mon, 1 Aug 2011 18:01:44 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id p7211hjL013738;
	Mon, 1 Aug 2011 18:01:43 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <4E36E0EC.1000508@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.4 (rcpt.cat.pdx.edu [131.252.208.107]); Mon, 01 Aug 2011 18:01:44 -0700 (PDT)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=unavailable
	version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.96.5 at rcpt
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178429>

Ren=E9 Scharfe <rene.scharfe_lsrfire.ath.cx> said (on 2011/08/01):
> Take long option names for -A (--after-context), -B (--before-context=
)
> and -C (--context) from GNU grep and add a similar long option name
> for -W (--function-context).

Why not just add --context=3Dfunction? Then when I want --context=3Dind=
ent
to give context based on the indent-level, it is an intuitive extension
of the existing options. (Of course, --context=3D<number> would still d=
o
exactly what it does now.)
