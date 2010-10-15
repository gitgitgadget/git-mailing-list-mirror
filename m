From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test code to check the list of
 declared prerequisites
Date: Fri, 15 Oct 2010 05:18:50 +0000
Message-ID: <AANLkTikkWw4Ju4jJFtvKX+s2LMkveQX-uBQyS41A=Vh2@mail.gmail.com>
References: <20101014030220.GB20685@sigill.intra.peff.net>
	<20101014030505.GC5626@sigill.intra.peff.net>
	<20101014031642.GB14664@burratino>
	<20101014033448.GB28197@sigill.intra.peff.net>
	<20101014203721.GA28958@burratino>
	<20101014204001.GB28958@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <jrk@wrek.org>, Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6ch0-0003nt-2M
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab0JOFSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 01:18:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42860 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0JOFSv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 01:18:51 -0400
Received: by fxm4 with SMTP id 4so217509fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dIpevophXrzE0pKTzoAoyKiaFtHjn6YLoKttP2pDPZ8=;
        b=InQqG/br56rwjaBR8mWpTsrVs7YRDVz71JG4o/emniqHIhIBSWixyYPVDJhiUFPpXI
         MlBZhrNtbptFNmnHoGn72SFG4j/Li/EqJh7a9XfRjar5v2IQ+vQNXPvf7/kj0nPo4i6p
         /8xLc9u38xYaqWTS4ZSI7uFj7No9vVrEiaVFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BN5O9uWgoZihfNNTP/XmPkPqxTBO2O2ZLgXhmd3JpPt3VrUkn7nqtTVy19iphba2Vp
         lNEPQriJvDXp+0ydqdcqfRjd9ZaCBr2mYiZozDtfcT8klNKeESrir2nPnhErAowv/uZq
         qdmpcIQpXwWITZpacHT+7eqCmZpgOnCpJUKHw=
Received: by 10.103.40.10 with SMTP id s10mr82656muj.11.1287119930299; Thu, 14
 Oct 2010 22:18:50 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 22:18:50 -0700 (PDT)
In-Reply-To: <20101014204001.GB28958@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159092>

On Thu, Oct 14, 2010 at 20:40, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> + =C2=A0 =C2=A0 =C2=A0 case ",$test_prereq," in
> + =C2=A0 =C2=A0 =C2=A0 *,$1,*)

Won't this only work with:

    test_expect_success FOO,THINGYOUWANT,BAR '...'

And not:

    test_expect_success THINGYOUWANT,FOO,BAR '...'

?
