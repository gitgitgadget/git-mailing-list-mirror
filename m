From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [ANN] git cola: a highly caffeinated git gui
Date: Fri, 1 Aug 2008 08:34:13 +0200
Message-ID: <20080801083413.2ac1782b@pc09.procura.nl>
References: <402731c90807312308l4870382dsb707fafd37f9b1d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, msysgit@googlegroups.com
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 08:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOoER-0003kz-9o
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 08:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbYHAGeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 02:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbYHAGeS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 02:34:18 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:4623 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYHAGeR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 02:34:17 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id m716YEQb094096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 08:34:14 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <402731c90807312308l4870382dsb707fafd37f9b1d4@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91030>

On Thu, 31 Jul 2008 23:08:01 -0700, "David Aguilar" <davvid@gmail.com>
wrote:

> Greetings!
> 
> The latest version of git cola is available for download from the
> usual interwebs:
> 
>     http://cola.tuxfamily.org/
>     http://gitorious.org/projects/git-cola/

Your dependencies don't match.

# cola-1.1.1-2.noarch.rpm

$ cola
Traceback (most recent call last):
  File "/usr/bin/cola", line 112, in <module>
    main()
  File "/usr/bin/cola", line 53, in main
    from cola.models import Model
  File "../../cola/models.py", line 9, in <module>
  File "../../cola/utils.py", line 9, in <module>
  File "../../cola/defaults.py", line 4, in <module>
ImportError: No module named PyQt4.QtCore

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
