From: David Kastrup <dak@gnu.org>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 08:59:37 +0200
Message-ID: <86d4xp471i.fsf@lola.quinscape.zz>
References: <f99cem$4a4$1@sea.gmane.org>
	<30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
	<Pine.LNX.4.64.0708081810130.14781@racer.site>
	<75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
	<Pine.LNX.4.64.0708082228520.21857@racer.site>
	<76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
	<e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
	<2383328F-300E-459C-A299-90242DA230F7@zib.de>
	<e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
	<EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
	<e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com>
	<30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de>
	<85fy2l1i1g.fsf@lola.goethe.zz>
	<ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 09:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILCrP-00077F-8f
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 09:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbXHOHAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 03:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbXHOHAA
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 03:00:00 -0400
Received: from main.gmane.org ([80.91.229.2]:57172 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbXHOG77 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 02:59:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILCr7-0005Sr-Bu
	for git@vger.kernel.org; Wed, 15 Aug 2007 08:59:49 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 08:59:49 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 08:59:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de> (Steffen Prohaska's message of "Wed\, 15 Aug 2007 07\:43\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:CAfShwJuHJjSAGZNXf5cEVqga44=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55884>

Steffen Prohaska <prohaska@zib.de> writes:

> On Aug 15, 2007, at 7:30 AM, David Kastrup wrote:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>> Author: Johannes Schmidt-Ehrenberg <schmidt-ehrenberg@zib.de>
>>> Date:   Mon Aug 13 19:00:39 2007 +0200
>>>
>>>     mergetool: fixed parsing of registry entry for kdiff3
>>>
>>>     The old code failed on Windows Vista. The output of
>>>     reg.exe or something else may be a bit different.
>>>     This patch improves the parsing code to be more robust.
>>
>> I seem to remember that you can't rely on reg.exe being available on
>> Windows.  The Microsoft support pages talk about using regedit.exe
>> instead (which is quite more cumbersome).
>
> I successfully ran it on at least Windows XP and Vista. On Vista,
> it was present on a quite fresh system (Visual Studio not yet
> installed). So I'm quite confident that it's likely to be there.
>
> Do you have a reference? I searched msdn and was not able to
> immediately find the recommendation you're referring to.

<http://www.microsoft.com/technet/prodtechnol/Windows2000serv/support/FAQW2KCP.mspx>

    Q.	What other tools are available for using the registry in batch?
    A.	

    If you install the Support Tools from the Windows 2000 CD-ROM, you
    can use REG.EXE to Add, Delete, Copy, Compare, Export, Import,
    Load a Hive, Query, Save, Restore, and Unload a Hive. To install
    the Support Tools:

    1.


    Insert the Windows 2000 CD-ROM into your CD-ROM drive.

    2.


    Click Browse this CD, and then open the Support\Tools folder.

    3.


    Double-click Setup.exe, and follow the on-screen instructions.


That does not sound like one could rely on its presence out of the
box, at least on Windows 2000.

-- 
David Kastrup
