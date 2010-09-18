From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git "smart http" server vs. http redirects
Date: Sat, 18 Sep 2010 10:03:15 +0300
Message-ID: <20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi>
References: <877hijvff7.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 18 08:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwrOt-0001JA-CM
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 08:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab0IRG7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 02:59:37 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:52940 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0IRG7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 02:59:36 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id C76E08C578;
	Sat, 18 Sep 2010 09:59:34 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02E7BC40A5; Sat, 18 Sep 2010 09:59:34 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 79FD7158A62;
	Sat, 18 Sep 2010 09:59:32 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <877hijvff7.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156432>

On Sat, Sep 18, 2010 at 01:33:48PM +0900, Miles Bader wrote:

> The savannah.gnu.org admins are trying out the git "smart http" server,
> but it doesn't seem to handle http redirects properly... should it?
> Is this a bug with the git server?
> 
> The follow is from Sylvain Beucler;
> > Hmmm, actually it works, but it doesn't support a HTTP redirect
> > (namely git.sv.gnu.org -> git.savannah.gnu.org).
> >
> > $ git clone http://git.sv.gnu.org/r/freedink.git
> > Initialized empty Git repository in /tmp/freedink/.git/
> > error: RPC failed; result=22, HTTP code = 405

405 (Method not allowed)? Can you see what request it is trying to send
and to where (the request that fails with 405 that is)?

-Ilari
