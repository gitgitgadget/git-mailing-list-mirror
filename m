From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Thu, 07 Nov 2013 19:51:14 +0100
Message-ID: <vpqtxfo2ggt.fsf@anie.imag.fr>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
	<vpq1u2tb3px.fsf@anie.imag.fr> <20131106234544.GF10302@google.com>
	<vpqtxfo8ow4.fsf@anie.imag.fr>
	<xmqqr4as5bbh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 19:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeUgC-0005j2-Sq
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 19:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab3KGSvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 13:51:42 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33742 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab3KGSvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 13:51:40 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rA7IpC26031634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Nov 2013 19:51:12 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rA7IpEpO011755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 7 Nov 2013 19:51:15 +0100
In-Reply-To: <xmqqr4as5bbh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Nov 2013 10:14:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Nov 2013 19:51:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rA7IpC26031634
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1384455076.89741@OQj1Cf918sCj0zMBCbRLcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237423>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, to me, I found the "two sentences" the worst part in the
> original.  It made it sound as if the default will be switching to
> 'upstream', and all readers need to read the second sentence that
> clarifies that it is not the case, in a somewhat round-about
> way---"will only succeed if" invites "and otherwise...?"

To me, this is not an issue given the audience (people too lazy to read
the docs): for them, current == simple == upstream modulo details
they're not interested about. The safety measure of "simple" is actually
here to make sure nothing wrong happens if they make the confusion.

But that's just a preference, I'm OK with your other proposal too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
