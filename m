From: Edward Ned Harvey <git@nedharvey.com>
Subject: RE: git and SSL certificates
Date: Fri, 24 Feb 2012 15:01:42 -0500
Message-ID: <000801ccf32f$2448e030$6cdaa090$@nedharvey.com>
References: <000501ccf328$1efe1070$5cfa3150$@nedharvey.com> <CAJo=hJuyHv_L_zajW-MWEj6fDGggrVDkRWT32mD5TBzD_GzReQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Shawn Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:01:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11Ky-00080L-Bk
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856Ab2BXUBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:01:48 -0500
Received: from relay.ihostexchange.net ([66.46.182.57]:21350 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757829Ab2BXUBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:01:47 -0500
Received: from bigsur (98.110.160.237) by smtp.ihostexchange.net
 (66.46.182.50) with Microsoft SMTP Server (TLS) id 8.3.213.0; Fri, 24 Feb
 2012 15:01:46 -0500
In-Reply-To: <CAJo=hJuyHv_L_zajW-MWEj6fDGggrVDkRWT32mD5TBzD_GzReQ@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AczzKmD0NRDA3OUSQnebTuagLjuLrwABFfnQ
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191455>

> From: Shawn Pearce [mailto:spearce@spearce.org]
> Sent: Friday, February 24, 2012 2:27 PM
>
> Nope. Git uses the system's libcurl, which is probably using the
> system's libssl or libgnutls, which is using the system's
> certificates.

Thanks, this gives me more fuel to go on, because now I know I can reproduce
the problem using any other tool I want - curl for example.  Where I'm able
to specify -v for verbose, and get its cert search path.

It's still really bizarre, because the Startcom root CA is indeed present in
the search path, and it is indeed the same root CA that was used to sign my
server cert.  So now I'll go ask startcom what they think about it...

If anyone is interested, please say so, and I'll report back here.
Otherwise, I'll probably just let the thread die.
