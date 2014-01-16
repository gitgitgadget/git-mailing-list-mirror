From: David Kastrup <dak@gnu.org>
Subject: Re: Potential bug: truncated diff output
Date: Thu, 16 Jan 2014 08:04:20 +0100
Organization: Organization?!?
Message-ID: <87ha944dcb.fsf@fencepost.gnu.org>
References: <CAAyYaWo7wtsVGGxUeE3wwG6UHZ_qc8wcPu4Dk6=DsF8JtyF6_w@mail.gmail.com>
	<52D78244.7020406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 08:07:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3h37-0002Iw-OG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 08:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbaAPHH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 02:07:28 -0500
Received: from plane.gmane.org ([80.91.229.3]:49011 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbaAPHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 02:07:25 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W3h2o-0001bN-Tx
	for git@vger.kernel.org; Thu, 16 Jan 2014 08:07:14 +0100
Received: from x2f3b11f.dyn.telefonica.de ([2.243.177.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 08:07:14 +0100
Received: from dak by x2f3b11f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 08:07:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3b11f.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:uTKS3my/WHjgUT9g1sv38s5YcrQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240509>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 1/16/2014 7:19, schrieb Misha Penkov:
>> I have a file in a git repo. It has changed during the last two
>> commits. I want to see the changes made in these two commits. The
>> following command should work:
>> 
>>     git diff HEAD^^
>
> Here, you revert the change...
>
> ... that you made here.
>
> Unsurprisingly, the net effect is no change in that area -- and git diff
> tells you exactly that.

Looks like I should have looked into the diffs before making my guess
about what happened.

-- 
David Kastrup
