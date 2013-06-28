From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Fri, 28 Jun 2013 07:20:51 -0700
Message-ID: <1372428798-sup-8609@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net> <1371278908-sup-1930@pimlott.net> <7vk3lvlmat.fsf@alter.siamese.dyndns.org> <87ip1e2tzx.fsf@hexa.v.cablecom.net> <7v7ghtjwbb.fsf@alter.siamese.dyndns.org> <8738shi2ht.fsf@linux-k42r.v.cablecom.net> <7vwqpshkxj.fsf@alter.siamese.dyndns.org> <1372190294-sup-1398@pimlott.net> <7v61x127bw.fsf@alter.siamese.dyndns.org> <1372198415-sup-2114@pimlott.net> <1372283778-sup-5704@pimlott.net> <7vd2r8v3fa.fsf@alter.siamese.dyndns.org> <1372291877-sup-8201@pimlott.net> <1372359783-sup-4507@pimlott.net> <7vr4fnqnse.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZXn-00013e-2j
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab3F1OUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 10:20:54 -0400
Received: from pimlott.net ([72.249.23.100]:50258 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3F1OUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=3D60mkylxAcYq/QFF+oF9LqP0FMaUNCrgsBPvTuUuGo=;
	b=OmRF8g4HSfLRQ3bH2bzZT0xpvJctWGIs6LasPIBKak4uEC7D7u7KHliQ3ZpGPJ/ro4arICv8CQEJ7BOTk3VD/NNM9y4HxtEE60UEc89a3hjYJ5x/BIi0WhcAdwLQtge20cxPKwgp8JE0ff1PQtRFn6g76+Yy4gi8Oki6YxAalXE=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UsZXf-0005IO-H9; Fri, 28 Jun 2013 07:20:51 -0700
In-reply-to: <7vr4fnqnse.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229201>

Excerpts from Junio C Hamano's message of Thu Jun 27 13:52:33 -0700 2013:
> Two issues here, which I'll locally amend (no need to resend):

Great!  Thank you for your help and patience.

>         cat >expected <<-EOF &&
>         pick ...
>         ...
>                 EOF
>         test_cmp expected actual

Is that two issues?

Andrew
