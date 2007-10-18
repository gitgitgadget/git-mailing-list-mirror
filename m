From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 09:15:53 +0200
Message-ID: <87k5pkzydy.fsf@lysator.liu.se>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu> <k5pll7rb.fsf@blue.sea.net> <47168E70.4070305@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 09:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiPg5-0003Wu-JF
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 09:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbXJRHUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 03:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756809AbXJRHUJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 03:20:09 -0400
Received: from main.gmane.org ([80.91.229.2]:39053 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211AbXJRHUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 03:20:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IiPfm-0000r7-Ry
	for git@vger.kernel.org; Thu, 18 Oct 2007 07:20:02 +0000
Received: from 77.241.128.250.bredband.tre.se ([77.241.128.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 07:20:02 +0000
Received: from davidk by 77.241.128.250.bredband.tre.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 07:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 77.241.128.250.bredband.tre.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:/NSPvfTP4U4V3ApIuZyq9eryuZ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61499>

Andreas Ericsson <ae@op5.se> writes:

> Jari Aalto wrote:
>> * Wed 2007-10-17 Michael Witten <mfwitten@MIT.EDU>
>> * Message-Id: E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu
>>> On 17 Oct 2007, at 3:17:08 AM, Luke Lu wrote:
>>>
>>>> But I still haven't seen any compelling arguments against the "all
>>>> space" case
>>> Overhead!
>>>
>>> If you use 8 spaces instead of one tab,
>>> that's using up 7x more space!
>>
>> Software is the right place to worry about optimization. We should t=
rust
>> SCM to make proper and efficient deltas. If not, algorithms need
>> improvemnts.
>>
>> Any cross platform development or electronic exchange is guaranteed =
to
>> be interpreted correctly when policy enforces "only spaces"
>>
>> As we have already seen in numerous times in this thread, using tabs
>> will - eventually - be interpreted in some editor, in some display, =
in
>> some encironment using some tools ... incorrectly or different than =
the
>> author intended. Simply because editors are configurable and we cann=
ot
>> know what settings they may have when they load the file in.
>>
>
> And simply because nearly all (unix) editors still insert a hard tab
> when pressing the tab key, and *mixing* tabs and spaces makes the
> situation *really* unbearable, one really shouldn't use all spaces.

I guess that means that you consider emacs to be an obscure or
non-unix editor?

When you press TAB while editing program code in emacs it doesn't
insert a hard tab. It reindents the current line according to the
indentation rules. The whitespace at the beginning of the line is
filled with spaces and/or tabs, depending on the indent-tabs-mode
setting.

--=20
David K=C3=A5gedal
