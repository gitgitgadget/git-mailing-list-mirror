From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: noob user, want checkins to all be forced to LF terminated
 lines
Date: Sat, 31 Jul 2010 08:39:18 +0300
Message-ID: <20100731053918.GA19688@LK-Perkele-V2.elisa-laajakaista.fi>
References: <i308gl$v6p$1@dough.gmane.org>
 <20100731044957.GA8920@burratino>
 <i30bg7$50k$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 07:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of4lh-0007zM-F3
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 07:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0GaFhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 01:37:43 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45662 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab0GaFhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 01:37:42 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id E7E8918D23C;
	Sat, 31 Jul 2010 08:37:40 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0658FD67C1; Sat, 31 Jul 2010 08:37:40 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 9282E41BE6;
	Sat, 31 Jul 2010 08:37:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <i30bg7$50k$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152303>

On Fri, Jul 30, 2010 at 10:14:40PM -0700, Walter Bright wrote:
> 
> A final question: where does the repository actually go (so I can
> back it up)? This is a local thing, I'm not trying to set up a
> networked or remote repository, so it'll be the default location.

.git directory in root of working copy. One way to backup is just
to do recursive backup of entiere working copy[1].

[1] But upon restore, the working copy cache will be wrong and
needs to be rebuilt (git update-index --refresh).

-Ilari
