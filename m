From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 19:18:21 +0200
Message-ID: <20100127171821.GB20820@Knoppix>
References: <1264608977-20665-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e1001270822u7727b0fdq3270ee5bb3ce546c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 18:18:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaBXD-0000U9-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 18:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab0A0RS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 12:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755807Ab0A0RS0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 12:18:26 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:42816 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab0A0RSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 12:18:25 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id E0359C80D5;
	Wed, 27 Jan 2010 19:18:24 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A01977DBED9; Wed, 27 Jan 2010 19:18:24 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id C863F2BD47;
	Wed, 27 Jan 2010 19:18:21 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1001270822u7727b0fdq3270ee5bb3ce546c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138174>

On Wed, Jan 27, 2010 at 05:22:07PM +0100, Sverre Rabbelier wrote:
> Heya,
> 
> On Wed, Jan 27, 2010 at 17:16, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> > it isn't likely anyone is using VCS setting and multiple
> > push URLs, as VCS setting is meant for non-URL-based helpers
> 
> I don't like that assumption, I've used the vcs setting with regular
> urls myself, is there a different way to solve this without
> introducing that assumption? Also, what happens if one _does_ do that,
> do we crash? abort?

If you have url-based remote helper, then use the <helper>::<URL> syntax.

As for what would happen: If you don't override with URL, the first
URL would use remote helper specified by vcs setting.

Maybe it would be better idea to have vcs setting set the default
helper (that gets used unless you override?)

-Ilari
