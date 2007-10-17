From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 01:02:32 +0300
Organization: Private
Message-ID: <k5pll7rb.fsf@blue.sea.net>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<471476B7.5050105@users.sourceforge.net>
	<8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	<47148F72.1090602@users.sourceforge.net>
	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	<B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
	<3awb7zw6.fsf@blue.sea.net>
	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	<1192565900.6430.16.camel@athena>
	<alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	<20071017015109.303760cc@localhost.localdomain>
	<alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	<3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	<E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 00:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiGz3-0005sd-0j
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 00:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbXJQWDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 18:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbXJQWDI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 18:03:08 -0400
Received: from main.gmane.org ([80.91.229.2]:49841 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852AbXJQWDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 18:03:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiGyl-0001XL-US
	for git@vger.kernel.org; Wed, 17 Oct 2007 22:03:04 +0000
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 22:03:03 +0000
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 22:03:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:G1MsYsX2a3jvnVJxxgJ9VwaqNuI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61430>

* Wed 2007-10-17 Michael Witten <mfwitten@MIT.EDU>
* Message-Id: E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu
> On 17 Oct 2007, at 3:17:08 AM, Luke Lu wrote:
>
>> But I still haven't seen any compelling arguments against the "all
>> space" case
>
> Overhead!
>
> If you use 8 spaces instead of one tab,
> that's using up 7x more space!

Software is the right place to worry about optimization. We should trust
SCM to make proper and efficient deltas. If not, algorithms need
improvemnts.

Any cross platform development or electronic exchange is guaranteed to
be interpreted correctly when policy enforces "only spaces"

As we have already seen in numerous times in this thread, using tabs
will - eventually - be interpreted in some editor, in some display, in
some encironment using some tools ... incorrectly or different than the
author intended. Simply because editors are configurable and we cannot
know what settings they may have when they load the file in.

There is no such problem with spaces. 

The storage constraints are insignificant given the disk space vs. cost;
including possibly used compression algorithms in storage or transfers.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
