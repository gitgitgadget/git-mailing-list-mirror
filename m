From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 7 Apr 2010 12:00:16 +0300
Message-ID: <20100407090016.GA14340@LK-Perkele-V2.elisa-laajakaista.fi>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr>
 <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
 <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
 <4BBC1E15.9040403@gmail.com>
 <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
 <4BBC3EEC.6010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Vitaly <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 11:00:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzR85-0007S2-QL
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 11:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140Ab0DGJAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 05:00:41 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:47559 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab0DGJAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 05:00:35 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 5B90813C0EF;
	Wed,  7 Apr 2010 12:00:34 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A02853570D9; Wed, 07 Apr 2010 12:00:34 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 18CD8158A69;
	Wed,  7 Apr 2010 12:00:29 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4BBC3EEC.6010702@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144207>

On Wed, Apr 07, 2010 at 12:14:36PM +0400, Vitaly wrote:
> Too bad..
> Yes, we really have a very large repo with binary files.

Large binary files are the worst. I think that disabling deltification
('-delta' as attribute[*]) on them might actually help somewhat...

> P.S. Btw, how can I ask for a feature of incorporating hashes into
> transport stream in trusted environments?

On this mailing list. But as a tip: don't bother: It is by far too
large change relative to any possible benefit. 

[*] I think 'info/attributes' on server influences wheither
those objects are attempted to be deltified or not.

-Ilari
