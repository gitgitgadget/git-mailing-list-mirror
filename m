From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug in "git log --graph -p -m" (version 1.7.7.6)
Date: Wed, 06 Feb 2013 19:33:08 +0100
Message-ID: <vpqbobxwavv.fsf@grenoble-inp.fr>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
	<7vtxpqslpm.fsf@alter.siamese.dyndns.org>
	<vpqmwvia2n7.fsf@grenoble-inp.fr>
	<201302061503.r16F30UA016375@freeze.ariadne.com>
	<20130206151447.GZ1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Dale R. Worley" <worley@alum.mit.edu>, gitster@pobox.com,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39oj-0000iF-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908Ab3BFSdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:33:31 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55131 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757901Ab3BFSd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:33:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r16IX6oo015105
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 19:33:07 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U39nw-0006CP-Rz; Wed, 06 Feb 2013 19:33:08 +0100
In-Reply-To: <20130206151447.GZ1342@serenity.lan> (John Keeping's message of
	"Wed, 6 Feb 2013 15:14:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Feb 2013 19:33:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16IX6oo015105
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360780390.51811@RBIFVvmraKTH1i3t/JoLPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215619>

John Keeping <john@keeping.me.uk> writes:

> I would argue that the line should start with "| | ", since it really is
> just a continuation of the same commit.
>
> | | 
> | | commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 33e70e70c0173d634826b998bdc304f93c0966b8)
> | | Merge: 2c1e6a3 33e70e7
> | | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> | | Date:   Tue Feb 5 22:05:33 2013 +0100

Yes.

I had a look at the code, I guess the call to graph_show_commit() in
show_log() (in log-tree.c) should have called graph_show_padding() but
didn't in this case. Then I got lost in graph.c :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
