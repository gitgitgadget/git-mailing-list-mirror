From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v6 14/14] difftool/mergetool: refactor commands to use
	git-mergetool--lib
Date: Sat, 11 Apr 2009 13:10:54 +0100
Message-ID: <20090411121054.GC10381@hashpling.org>
References: <1239175040-28974-1-git-send-email-davvid@gmail.com> <20090411120040.GA10381@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 14:12:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsc4W-0002qs-W5
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 14:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZDKMK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 08:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbZDKMK6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 08:10:58 -0400
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:23763 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587AbZDKMK5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 08:10:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEADol4EnUnw6R/2dsb2JhbADJaIN8Bg
Received: from ptb-relay01.plus.net ([212.159.14.145])
  by relay.ptn-ipout01.plus.net with ESMTP; 11 Apr 2009 13:10:55 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1Lsc2x-0003lt-Eg; Sat, 11 Apr 2009 13:10:55 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n3BCAte8011280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 13:10:55 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n3BCAsVm011279;
	Sat, 11 Apr 2009 13:10:54 +0100
Content-Disposition: inline
In-Reply-To: <20090411120040.GA10381@hashpling.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 0cb10297be3488e1c41ed1bb65a9cc1d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116296>

On Sat, Apr 11, 2009 at 01:00:40PM +0100, Charles Bailey wrote:
> On Wed, Apr 08, 2009 at 12:17:20AM -0700, David Aguilar wrote:
> > +    present=false
> > +    base_present &&
> > +    present=true
> 
> I'm not sure why, but from a style point of view, this seemed a bit
> inconsistent from the rest of mergetool and grated with me a bit.
> 
> I think I'd prefer
> 
> if base_present; then
>     present=false
> else
>     present=true
> fi

Although with 'true' and 'false' the corrent way around, obviously.

> 
> or even:
> 
> present=$(base_present && echo true || echo false)
> 

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
