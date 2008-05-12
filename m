From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Problems getting git-send-email to work
Date: Sun, 11 May 2008 19:01:17 -0700
Message-ID: <402c10cd0805111901q2e934e44w45938ca4a85f240b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 04:02:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvNN2-0003jw-0k
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 04:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbYELCBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 22:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbYELCBV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 22:01:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:13218 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbYELCBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 22:01:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1624663fgg.17
        for <git@vger.kernel.org>; Sun, 11 May 2008 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=FYzg13MlJvL53GobUaJhsdmBrQ/cmOMh6wP+bXf4c9Y=;
        b=CyjlIu8JE5NcmNG6idb5D5UfEIymhdAdu5LwW6hCVdycJ1Aq9DnGjmBLsBkRqvrUHrqFFBg2kpPVpYKAwk8H+OxLcWV+LBNpOygcT76XV14ufCtWyct+eodcehBeNNNK+p0Dc5N7iQR5G29pELH+rVQNHFfU4oz/aHKAznYiJi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=laoxh0PYyGR/HC18lZtZ0MF3K6fFJcqgJ5pt4O1gvUrFpm0A43RcZyHd1srLaM/zMpwAmrx8fNQXDvY3Q1SL4CRM83L2VjAYuIwkLVJbe5LkMzg9ahJSgamrfp6/TrLFhuHZNsYxecIs9Z138gZB9h61qVSF1x4wlJXxHARU2OU=
Received: by 10.82.181.8 with SMTP id d8mr762442buf.54.1210557678766;
        Sun, 11 May 2008 19:01:18 -0700 (PDT)
Received: by 10.82.172.1 with HTTP; Sun, 11 May 2008 19:01:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81828>

I am having trouble getting git send-email to work:

[sj@black patches]$ git send-email --smtp-server=smtp.gmail.com
--smtp-user=hvammen@gmail.com --smtp-ssl --to=hvammen@gmail.com
0001-Documentation-for-joining-more-than-two-histories.patch
0001-Documentation-for-joining-more-than-two-histories.patch
Who should the emails appear to be from? [Sverre Hvammen Johansen
<hvammen@gmail.com>]
Emails will be sent from: Sverre Hvammen Johansen <hvammen@gmail.com>
Message-ID to be used as In-Reply-To for the first email?
(mbox) Adding cc: Sverre Hvammen Johansen <hvammen@gmail.com> from
line 'From: Sverre Hvammen Johansen <hvammen@gmail.com>'
(sob) Adding cc: Sverre Hvammen Johansen <hvammen@gmail.com> from line
'Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>'
Can't locate Net/SMTP/SSL.pm in @INC (@INC contains:
/usr/local/lib/perl5/site_perl/5.8.8/i386-linux-thread-multi
/usr/local/lib/perl5/site_perl/5.8.8
/usr/lib/perl5/site_perl/5.8.8/i386-linux-thread-multi
/usr/lib/perl5/site_perl/5.8.7/i386-linux-thread-multi
/usr/lib/perl5/site_perl/5.8.6/i386-linux-thread-multi
/usr/lib/perl5/site_perl/5.8.5/i386-linux-thread-multi
/usr/lib/perl5/site_perl/5.8.8 /usr/lib/perl5/site_perl/5.8.7
/usr/lib/perl5/site_perl/5.8.6 /usr/lib/perl5/site_perl/5.8.5
/usr/lib/perl5/site_perl
/usr/lib/perl5/vendor_perl/5.8.8/i386-linux-thread-multi
/usr/lib/perl5/vendor_perl/5.8.7/i386-linux-thread-multi
/usr/lib/perl5/vendor_perl/5.8.6/i386-linux-thread-multi
/usr/lib/perl5/vendor_perl/5.8.5/i386-linux-thread-multi
/usr/lib/perl5/vendor_perl/5.8.8 /usr/lib/perl5/vendor_perl/5.8.7
/usr/lib/perl5/vendor_perl/5.8.6 /usr/lib/perl5/vendor_perl/5.8.5
/usr/lib/perl5/vendor_perl
/usr/lib/perl5/5.8.8/i386-linux-thread-multi /usr/lib/perl5/5.8.8 .)
at /usr/local/bin/git-send-email line 713.
[sj@black patches]$

I am using Fedora 7, and have installed git from source (git version
1.5.5.54.gc6550, a few private patches that should not be related to
this problem).  Can anyone help me locate the RPM that include
Net/SMTP/SSL.pm?

Without --smtp-ssl I am getting this after I have typed in my password:

Command unknown: 'AUTH' at /usr/local/bin/git-send-email line 744,
<STDIN> line 1.

-- 
Sverre Hvammen Johansen
