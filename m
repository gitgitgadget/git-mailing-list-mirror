From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Wed, 1 Sep 2010 06:56:24 +0300
Message-ID: <20100901035623.GA8775@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 05:54:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqePZ-0002Oj-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 05:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0IADyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 23:54:53 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:49369 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0IADyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 23:54:52 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 83161EF4EA;
	Wed,  1 Sep 2010 06:54:51 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0197F68802; Wed, 01 Sep 2010 06:54:51 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 3C3EB2BD44;
	Wed,  1 Sep 2010 06:54:47 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100831143839.GC16034@foucault.redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155013>

On Tue, Aug 31, 2010 at 10:38:39AM -0400, Casey Dahlin wrote:
> 
> And we can exchange them
> 
> 	casey@host_a$ git hive fetch nguyen for_casey
> 	casey@host_a$ git branch
> 	* master
> 	  stable
> 	  for_casey
> 
> Note that the two arguments in fetch are a regex which searches through user
> IDs and a branch name, which is why I can abbreviate to just "nguyen" in all
> lower case.

Any possibilty for adding remote helper for fetching/pulling directly using
fetch? You have full-duplex connectivity and Git running on both ends,
right[1]?

[1] remote-helper connect command is designed for just these sort of cases.

-Ilari
