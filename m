From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git Wiki Move
Date: Thu, 21 Jan 2010 16:21:22 -0800 (PST)
Message-ID: <m3vdevat3m.fsf@localhost.localdomain>
References: <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr>
	<4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net>
	<vpqwrzhszye.fsf@bauges.imag.fr>
	<alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de>
	<4B53AEAC.6060100@eaglescrag.net>
	<alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.1001181258540.3044@intel-tinevez-2-302>
	<4B54ACBD.6000000@eaglescrag.net>
	<20100121213514.GD3299@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog19@eaglescrag.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7HJ-00031A-98
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab0AVAV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577Ab0AVAV0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:21:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:45034 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab0AVAVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:21:25 -0500
Received: by fg-out-1718.google.com with SMTP id 16so145536fgg.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=c3SbbvS11gKSnxoukUKDLnpS1I1HYeGaj0lyCtaOsI8=;
        b=VWz3LnFgTLYs4nWxXE8X+0wljhqp+WZ5MH43AmWbfM8G7S6+ikj7rXPoCOFvni+TQr
         CU8cDvv9e7yLUfg1j2EMq0EwlLn8VLcZinaRmDyct/OLWRJlf5VWTChwfeJbiUDVhslh
         KhWVEFxNhZhvXuBSi2s7X4axjmUmYvEx/tars=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lkW8Xnero7SHhI0rJ+n3wfrdSvkzuK90smpcj3N4VU3YO+fkxNmJ6mEBpJWor/UbSn
         4ic07PdmeUz4MyzVJzjOREDgkZmiI+epBM0DOLtykIxm68xSCYhN0FHcrYSymOrFUE+8
         oSOe9eilxIr7Mv69zVttlTSA90mGbEhOKtCQs=
Received: by 10.102.204.13 with SMTP id b13mr1157187mug.127.1264119684140;
        Thu, 21 Jan 2010 16:21:24 -0800 (PST)
Received: from localhost.localdomain (abuz181.neoplus.adsl.tpnet.pl [83.8.197.181])
        by mx.google.com with ESMTPS id i7sm6507354mue.16.2010.01.21.16.21.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 16:21:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0M0KPwN018757;
	Fri, 22 Jan 2010 01:20:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0M0JwKI018743;
	Fri, 22 Jan 2010 01:19:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100121213514.GD3299@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137701>

Petr Baudis <pasky@suse.cz> writes:
> On Mon, Jan 18, 2010 at 10:47:25AM -0800, J.H. wrote:
> > On 01/18/2010 04:03 AM, Johannes Schindelin wrote:

> > > - add a link from the old Wiki (with rewrite rules)
> > 
> > I think the rewrites should be simple enough (the pages seem to line up
> > 1:1 easily enough) so all I would need to do is discuss this with Petr.
> 
> repo.or.cz migration to new server is now finished and on the new
> system, I chose to not even install moinwiki at all. Instead, I've
> installed a rewrite rule so all http://git.or.cz/gitwiki/ accesses are
> sent to the appropriate place of http://git.wiki.kernel.org/ - thus,
> that's the master copy of git wiki now. :-) 

Are all formatting bugs from MoinMoin + media4moin -> MediaWiki fixed?
If not, then it would be good to have reference read-only copy of old
MoinMoin-based wiki to compare against.

> Thanks a lot for stepping up to do this, J.H.!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
