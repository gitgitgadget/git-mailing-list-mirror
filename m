From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for
Date: Tue, 30 Nov 2010 08:28:08 +0100
Organization: Bertin Technologies
Message-ID: <20101130082808.415dc3c1@chalon.bertin.fr>
References: <7vfwujy7co.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gister@pobox.com, kevin@sb.org
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 30 08:38:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNKna-00046f-LL
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 08:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab0K3Hip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 02:38:45 -0500
Received: from blois.bertin.fr ([195.68.26.9]:38160 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011Ab0K3Hip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 02:38:45 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 123FB542BE
	for <git@vger.kernel.org>; Tue, 30 Nov 2010 08:38:43 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id CCA6A542C5
	for <git@vger.kernel.org>; Tue, 30 Nov 2010 08:38:42 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LCO00MJIT8IGVB0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 30 Nov 2010 08:38:42 +0100 (CET)
In-reply-to: <7vfwujy7co.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17798.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162472>

Junio:
> Kevin wrote:
> > Given my druthers, I'd prefer to go with --detect-copies-harder, but
> > at this point I don't have as much of a strong preference anymore.
>
> The patch is smaller, and we often say "rename detection", not "rename
> finding", so it may probably make more sense.

OTOH:

* when cumulated to the still-recent patch adding the long forms, not
  using a synonym is shorter

* if it is just "adding a synonym" without deprecation, it only
  adds a new option for little gain; OTOH deprecating such an old
  option may not be such a good idea (not to mention it would make the
  patch longer ;)

* The --find-* forms are still shorter to spell

-- 
Yann Dirson - Bertin Technologies
