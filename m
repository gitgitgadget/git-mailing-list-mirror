From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: push --mirror on post-receive hook?
Date: Fri, 13 May 2011 11:25:17 +0300
Message-ID: <20110513082516.GA17821@LK-Perkele-VI.localdomain>
References: <BANLkTim9S2qGRB=bWxWkMj3s=kmD=YaZqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jordi Bunster <jordi@bunster.org>
X-From: git-owner@vger.kernel.org Fri May 13 10:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKnme-0001mm-3k
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 10:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086Ab1EMIbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 04:31:34 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:39227 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029Ab1EMIbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 04:31:33 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 May 2011 04:31:33 EDT
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 81717C8015;
	Fri, 13 May 2011 11:25:09 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A059957A5FA; Fri, 13 May 2011 11:25:09 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 45DB8158A66;
	Fri, 13 May 2011 11:25:07 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <BANLkTim9S2qGRB=bWxWkMj3s=kmD=YaZqA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173510>

On Thu, May 12, 2011 at 02:35:15PM -0700, Jordi Bunster wrote:
> Is it safe to call push --mirror $SOME_REMOTE on a post-receive hook?
> Is push always safe for the source repo?

Yes, it is safe, apart from potential hang if $SOME_REMOTE can't be
contacted (it can take minutes for the TCP connect() to time out).

-Ilari
