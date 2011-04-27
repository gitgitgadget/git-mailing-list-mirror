From: Dun Peal <dunpealer@gmail.com>
Subject: Difference between --date-order and reverse chronological order?
Date: Wed, 27 Apr 2011 08:15:06 -0700 (PDT)
Message-ID: <12e0244a-313e-4d67-9b91-c0d443276cff@k7g2000yqj.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 17:23:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF6al-0004Ak-HE
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 17:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909Ab1D0PXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 11:23:43 -0400
Received: from mail-gw0-f56.google.com ([74.125.83.56]:51911 "EHLO
	mail-gw0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab1D0PXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 11:23:41 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Apr 2011 11:23:41 EDT
Received: by gwaa11 with SMTP id a11so3182122gwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 08:23:40 -0700 (PDT)
Received: by 10.91.66.5 with SMTP id t5mr215694agk.42.1303917306541; Wed, 27
 Apr 2011 08:15:06 -0700 (PDT)
Received: by k7g2000yqj.googlegroups.com with HTTP; Wed, 27 Apr 2011 08:15:06
 -0700 (PDT)
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US;
 rv:1.9.2.16) Gecko/20110319 Firefox/3.6.16,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172239>

Hi.

The git-log manpage defines --date-order:

"This option is similar to --topo-order in the sense that no parent
comes before all of its children, but otherwise things are still
ordered in the commit timestamp order."

But by Git's definition, for a child commit to be created, its parent
must already exist. So even in reverse chronological order, all
parents should come after all their children, no?

Thanks, D.
