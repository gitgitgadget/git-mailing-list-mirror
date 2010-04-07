From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 7 Apr 2010 11:00:50 +0300
Message-ID: <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr>
 <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
 <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
 <4BBC1E15.9040403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 10:01:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzQCL-00009b-NC
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 10:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab0DGIBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 04:01:12 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:53055 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0DGIBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 04:01:09 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 93E3A8C5FE;
	Wed,  7 Apr 2010 11:01:07 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06601906E3; Wed, 07 Apr 2010 11:01:07 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 1D595E51AE;
	Wed,  7 Apr 2010 11:01:01 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4BBC1E15.9040403@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144203>

On Wed, Apr 07, 2010 at 09:54:29AM +0400, Vitaly Berov wrote:
> I suspected the security reasons.
> 
> Ok, we work in trusted environment. How can we turn this behavior off?
 
It can't be turned off. Protocol requires client to recompute hashes
as they are not explicitly available in transport stream (must be inferred
instead).

> >This being said, you should never have to wait 6 hours for that phase to
> >complete.  It is typically a matter of minutes if not seconds.

The reasons why it might take 6 hours (offhand from memory):

- Extremely large repo
- Very large files in repo pushing client into swap.

-Ilari
