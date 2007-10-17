From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 02:38:05 +0300
Organization: Private
Message-ID: <ejftl3c2.fsf@blue.sea.net>
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
	<k5pll7rb.fsf@blue.sea.net> <47168E70.4070305@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 01:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiITA-0006s7-Mm
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269AbXJQXiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757735AbXJQXiV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:38:21 -0400
Received: from main.gmane.org ([80.91.229.2]:57040 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbXJQXiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 19:38:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiISw-0008SJ-4O
	for git@vger.kernel.org; Wed, 17 Oct 2007 23:38:18 +0000
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 23:38:18 +0000
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 23:38:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:JJDB7IdkIHOuWYoqbzN74jx+dtQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61440>

* Thu 2007-10-18 Andreas Ericsson <ae@op5.se> gmane.comp.version-control.git
* Message-Id: 47168E70.4070305@op5.se
> And simply because nearly all (unix) editors still insert a hard tab
> when pressing the tab key, and *mixing* tabs and spaces makes the
> situation *really* unbearable, one really shouldn't use all spaces.

There was no assumption about a particular OS or editors. 

The QA tools will take care of warning or making automatic formatting
before the code is put to SCM. In projects you cannot assume anything
about people, their tools or what OS they might use at hand.

>> There is no such problem with spaces. 
>>
>
> I beg to differ, for reasons stated multiple times elsewhere in this
> thread.

Consider:

- Any editor will display the text written in "all spaces"
  100 % the same. Regradless of any viewer or editor used.

But the same is not true with text that uses tabs (because you
really can't know what options the editor is preset / user set /
regarding the treatment of tabs).

The score is 1 - 0 for "all spaces" in this contest.

-- 
Welcome to FOSS revolution: we fix and modify until it shines
