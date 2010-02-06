From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 5/9] revert: add --ff option to allow fast forward when
 cherry-picking
Date: Sat, 06 Feb 2010 16:41:43 +0100
Message-ID: <hkk2jl$ghl$1@ger.gmane.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org> <20100205231112.3689.67634.chriscool@tuxfamily.org> <4B6D38FB.9000307@gnu.org> <201002061629.05640.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 16:42:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndmnc-0000Ur-B8
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 16:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab0BFPmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 10:42:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:59034 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab0BFPmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 10:42:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NdmnM-0000I2-Ju
	for git@vger.kernel.org; Sat, 06 Feb 2010 16:42:04 +0100
Received: from 93-34-208-53.ip51.fastwebnet.it ([93.34.208.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 16:42:04 +0100
Received: from bonzini by 93-34-208-53.ip51.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 16:42:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93-34-208-53.ip51.fastwebnet.it
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <201002061629.05640.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139175>

On 02/06/2010 04:29 PM, Christian Couder wrote:
> On samedi 06 f=E9vrier 2010, Paolo Bonzini wrote:
>> On 02/06/2010 12:11 AM, Christian Couder wrote:
>>> As "git merge" fast forwards if possible, it seems sensible to
>>> have such a feature for "git cherry-pick" too, especially as it
>>> could be used in git-rebase--interactive.sh.
>>>
>>> Maybe this option could be made the default in the long run, with
>>> another --no-ff option to disable this default behavior, but that
>>> could make some scripts backward incompatible and/or that would
>>> require testing if some GIT_AUTHOR_* environment variables are
>>> set. So we don't do that for now.
>>
>> I would still like to have a no-op --no-ff so that scripts that do r=
ely
>> on that can be future proofed (or also, scripts that do "git cherry-=
pick
>> $blah -e COMMIT" could use --no-ff to avoid errors in case $blah
>> contains --ff).
>
> Ok, I will add a --no-ff option but I think it should be incompatible
> with --ff rather than overide it.

Whatever it does it should be the same as git merge.

Paolo
