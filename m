From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Tue, 5 Nov 2013 11:16:59 +0100 (CET)
Message-ID: <1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com> <CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com> <xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 11:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vddq2-00073d-8M
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 11:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab3KEK0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 05:26:17 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46024 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab3KEK0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 05:26:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rA5APSQl032336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Nov 2013 11:25:28 +0100
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id rA5APT37025061;
	Tue, 5 Nov 2013 11:25:29 +0100
In-Reply-To: <xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.3_GA_5664 (ZimbraWebClient - FF25 (Linux)/8.0.3_GA_5664)
Thread-Topic: push: Enhance unspecified push default warning
Thread-Index: f8XbmOt5a5Jm/c0OyvqWq+8P2TZNlg==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Nov 2013 11:25:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rA5APSQl032336
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1384251930.66332@Fa1jZbtpsJaa6EZQ1tFW+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237327>

----- Original Message -----
> Greg Jacobson <coder5000@gmail.com> writes:
> 
> > Is there anything I could do to improve this patch?  Thank you.
> 
> My vague recollection is that we started from an excerpt from the
> documentation page, not unlike this patch attempts to, but because
> such an excerpt has to be less complete than the documentation for
> brevity's sake, it is bound to be an incorrect and/or misleading
> one, and decided that we are better off referring the users, who do
> want to choose something other than the default we chose, to the
> documentation.
> 
> Somebody cares to dig up the old discussion threads and post a few
> pointers?

The previous versions of this patch received only minor comments,
which were taken into account:

http://thread.gmane.org/gmane.comp.version-control.git/235675
http://thread.gmane.org/gmane.comp.version-control.git/235694

I don't remember all the discussions on the patch which introduced
the warning, but I don't think it's relevant to digg them before applying the patch:

* The assumption was that users would read the docs, but as I already mentioned:
  "Judging by the question asked on stackoverflow
  ( http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0 )
  and its popularity, telling the users to read the docs did not work very
  well."

* The warning has been there for a while now. Advanced users have already set push.default.
  We shouldn't be worried about eating a bit of screen real estate for users who didn't yet.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
