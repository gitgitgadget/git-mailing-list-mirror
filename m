From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 11:19:48 +0300
Organization: Private
Message-ID: <abqgltqz.fsf@blue.sea.net>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<47168E70.4070305@op5.se> <ejftl3c2.fsf@blue.sea.net>
	<200710180031.54819.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 10:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiQcm-0006Ng-FS
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 10:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXJRIUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 04:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbXJRIUr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 04:20:47 -0400
Received: from main.gmane.org ([80.91.229.2]:39477 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755039AbXJRIUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 04:20:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiQc2-0007xF-RJ
	for git@vger.kernel.org; Thu, 18 Oct 2007 08:20:14 +0000
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 08:20:14 +0000
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 08:20:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:PD+VORVvlIx69yJXZTBhESsR9tk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61503>

* Thu 2007-10-18 Dmitry Torokhov <dmitry.torokhov@gmail.com>
* Message-Id: 200710180031.54819.dmitry.torokhov@gmail.com
> On Wednesday 17 October 2007, Jari Aalto wrote:
>
>> - Any editor will display the text written in "all spaces"
>>   100 % the same. Regradless of any viewer or editor used.
>> 
>> But the same is not true with text that uses tabs (because you
>> really can't know what options the editor is preset / user set /
>> regarding the treatment of tabs).
>> 
>> The score is 1 - 0 for "all spaces" in this contest.
>> 
>
> How about this - I like tabs because when you removing it you
> need to hit Backspace just once and don't have to strain your
> eyes figuring out "Did I delete enough? Does it line up now?"

First I must say that you're right. From user's perspective some things
are convenient and some things not so convenient; it depends:

 a) select an editor where these are no-issues
 b) use an editor that can be configured so that these are no-issues
 c) use the current editor and live by its limitations

I do not speak for any particular project here, just from a general
perspective[1]:

    A project policy QA enforces standards so that everybody can expect
    things to work the same way. The common denominator from view
    perspective (person A, B, C, D ... loads the text into a editor) is
    "all spaces". Similarly if code is post processed, all tools can
    expect that there are no surprises (it's all spaces, no combination
    of spaces and tabs).

The effect of a project policy in general is to enforce standards that
may not necessary match everybody's preferences[2].

Jari

[1] 99 % of the projects do not use Kernel's 8-wide indentation
convention. In all seriously taken editors, the TAB-key is configurable
to move to specific positions; so called "tab stops". Therefore "hit
TAB-key to insert tab character" does not usually apply in coding
context. In coding, the TAB-key is used to control the indentation
level, which is a measure defined in Project policy (coding style).

[2]
The tabs vs spaces issue is simular to those of:

- Starting curly brace placement policy: at EOL, or at separate line
- Identifier naming policy: camelCase vs. dash_names

-- 
Welcome to FOSS revolution: we fix and modify until it shines
