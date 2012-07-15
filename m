From: Kalle Launiala <kalle.launiala@gmail.com>
Subject: Complete audit trail for embedded (Linux) system lifecycle with Git
Date: Sun, 15 Jul 2012 11:47:36 +0300
Message-ID: <CAHLTmjmrXSGQdS-wZ-K23grQTkxHFJzA-u05GJEqrtdLusBb8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 10:48:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqKV6-0005Ik-DN
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 10:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab2GOIrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 04:47:39 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:65448 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2GOIrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 04:47:37 -0400
Received: by qaas11 with SMTP id s11so1078643qaa.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=S6psHoi31V4oqEbwaIp2/LHHG+IPf0tl93fitAr7y2k=;
        b=gH2B/gYNQVI1s+a49nv5B/GVgjS8pDBekuxo5MtUJ6Be5+ud9rKW5sdYDvWdKylOWw
         WQgryXvMTo6gRr6MjtK9w5hyrRCirfcBUaFPNkOIzfv9NdNLvcy5D/bS/AghM8UPW+Lg
         hXdWE7ttRku2QKJnVzwj5htbTxIcHceMdakeXfjTRGv+GNA/utp1p+5s9RZQRJGaFPpl
         o4JGioL6UFbEmFF0VMihhinpEu/8pWeRVh/vZFtJS2f2vEWK1ZkJoBpewIVd2rZO0hNa
         QVVbZZBNCgnW23VHXETy/SyuFuAhsHpTQhCkOW2J54QHjFW8ypVqlrZ9LJjmPbfl9rJX
         Twkg==
Received: by 10.229.136.132 with SMTP id r4mr3948137qct.95.1342342056145; Sun,
 15 Jul 2012 01:47:36 -0700 (PDT)
Received: by 10.229.47.77 with HTTP; Sun, 15 Jul 2012 01:47:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201473>

Hello,

We are to solve a complete audit trail solution for full subcontractor
value-chain fullfilling European Union machinery directive:
http://ec.europa.eu/enterprise/sectors/mechanical/machinery/

To summarize, the directive is created to ensure safe operating
environment for all kind of machinery devices (from industrial
machinery to consumer shopping-centre lifts/elevators). This also
includes the embedded software that controls the machinery (which is
as we know, the make-or-break the true safety of the device).

The solution is based on the very core Git functionality, in very
brief overview explained here:
http://abstractiondev.wordpress.com/git-based-distribution/

As Git is completely file-system based, in our solution it is used as
the core technology to audit ANY digital document or information. It
is serving as a distributed set of "master data" repositories,
including the digital signature repositories and 3rd party validation
stacks. In the validation chains it is critical to be able to support
responsible decision makers to approve design choises beyond the
software, thus the digital signature infrastructure for any
legal-binding document is as important as the actual embedded software
stack, that is by its nature version controlled within Git as well.

While I would hope this post to serve a purpose for demonstrating that
Git works as a perfect solution in the core, I'd also like to hear if
there is already established community/ongoing process of achieving
anything described above?

We have no intention of "reinventing the wheel" here, although being
very core solution for ANY audit trail and being so close based on Git
- bare functionality, I'm expecting any existing solution to share
much of similar design. Any existing tooling to support the solution
(especially dynamic cross-connected metadata repository searches - the
bottom image of the overview, that indexes the repositories together)
would be very welcome. The current technical solution is using GnuPG
for the digital signatures and open-source cross platform XML-database
for metadata indexing - grid databases being considered for the larger
implementations.

Any comments and/or feedback would be greatly appreciated.

Cheers,

Kalle Launiala
