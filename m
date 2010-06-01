From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: How to add daily tags for a central repo?
Date: Wed, 2 Jun 2010 01:20:40 +0300
Message-ID: <20100601222040.GA28776@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1275369711233-5124575.post@n2.nabble.com>
 <4C04AC1E.7040502@drmicha.warpmail.net>
 <AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
 <4C04BF33.70300@drmicha.warpmail.net>
 <AANLkTinHU5z5njEpx1S_6DIR5ECauJbzWlcM95wNUVxf@mail.gmail.com>
 <4C04CA4F.40106@drmicha.warpmail.net>
 <AANLkTinpmkLhbBeqtdK9auG6NfqEsHqPWhrpUL18nFsG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Roy Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 00:22:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJZrJ-00074k-BO
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 00:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab0FAWWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 18:22:47 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:54036 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab0FAWWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 18:22:46 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 8FFC0EF6BE;
	Wed,  2 Jun 2010 01:22:45 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A037DE8E876; Wed, 02 Jun 2010 01:22:45 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 578304033;
	Wed,  2 Jun 2010 01:22:42 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinpmkLhbBeqtdK9auG6NfqEsHqPWhrpUL18nFsG@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148163>

On Tue, Jun 01, 2010 at 05:45:16PM +0800, Roy Lee wrote:
> 
> I've been using reflog locally for some time, but never thought that
> it could be used in this way -- combining with timespec to get the
> timestamps of updates to the server. :)
> 
> The only problem now is that the tag creator might not have the access
> to shell on the central server. To grant the shell access for the tag creator
> may be a quick way to circumvent this. But I think I'll try if git can export
> the reflog to the client in a native way or with some trickery.
 
Have an automated script that creates the tags and runs from cron or somesuch
(or from post-update hook)?

If you don't want to use tags, you can use refs in other namespaces (but these
would still be sent as refs to client, increasing bandwidth usage a bit).

-Ilari
