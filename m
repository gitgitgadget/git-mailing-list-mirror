From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Integrating with hooks
Date: Thu, 15 Nov 2007 02:43:22 +0100
Organization: At home
Message-ID: <fhg87q$k21$1@ger.gmane.org>
References: <20071113173721.GI25282@penguin.codegnome.org> <fhdane$kfs$1@ger.gmane.org> <20071115011837.GD32746@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 02:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTm0-0005Sh-HB
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbXKOBnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 20:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbXKOBnr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:43:47 -0500
Received: from main.gmane.org ([80.91.229.2]:55871 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631AbXKOBnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 20:43:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IsTlW-0005gu-Q7
	for git@vger.kernel.org; Thu, 15 Nov 2007 01:43:34 +0000
Received: from abwg44.neoplus.adsl.tpnet.pl ([83.8.230.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 01:43:34 +0000
Received: from jnareb by abwg44.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 01:43:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwg44.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65041>

Todd A. Jacobs wrote:

> On Wed, Nov 14, 2007 at 12:07:29AM +0100, Jakub Narebski wrote:
> 
>> Take a look at gitattributes(5), namely 'filter' attribute.
> 
> Thanks, I took a look at the man page you suggested. The "ident" feature
> almost does what I want, but doesn't seem to take any sort of format
> string. 

The `ident` feature provides only sensible Id for a file (if you want to
avoid potentially rewriting _all_ and not only changed files on checkout /
switching branch / reset --hard). All Ids which have commit info, like
commit id, commit date, author are not sensible in mentioned sense.

> So, I thought I'd explore "filter," but can't really find any 
> examples of how to implement the smudge and clean commands, which seem
> to be what I'm really trying to do here.
> 
> Is there an example somewhere that you can point me to? The man page
> doesn't really show any examples of how to implement the filter
> attribute, so I'm a little unsure how to proceed.

Cannot help you there, but see examples of `diff` and `merge` attributes,
it should I think be similar.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
