From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 13:39:47 +0300
Message-ID: <20110621103947.GA30147@LK-Perkele-VI.localdomain>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
 <4E005404.5010901@drmicha.warpmail.net>
 <BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
 <4E006682.80101@drmicha.warpmail.net>
 <BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Kasra Khosoussi <kasra.mail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 12:44:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYyRh-00056x-DN
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 12:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab1FUKoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 06:44:30 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:32805 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab1FUKo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 06:44:29 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jun 2011 06:44:29 EDT
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 2E7A58C859;
	Tue, 21 Jun 2011 13:38:42 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07EEA22C78; Tue, 21 Jun 2011 13:38:42 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id ECF442BD44;
	Tue, 21 Jun 2011 13:38:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176137>

On Tue, Jun 21, 2011 at 02:40:47PM +0430, Kasra Khosoussi wrote:
> Thanks for your help.
> 
> I used update-ref and changed refs/heads/master to the sha1 of
> previous commit. Then I commit the changes. Everything seems fine now
> except (as you previously mentioned), git fsck -full complains about
> dangling trees. Is it critical?
 
Dangling trees are normal. They are not errors.

-Ilari
