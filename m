From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH 0/5] gitweb: Some code cleanups (up to perlcritic --stern)
Date: Mon, 11 May 2009 15:13:20 +1000
Organization: I know I put it down here, somewhere.
Message-ID: <877i0op6hb.fsf@rimspace.net>
References: <200905100203.51744.jnareb@gmail.com>
	<7vy6t4sbxj.fsf@alter.siamese.dyndns.org>
	<200905110333.52127.jnareb@gmail.com>
	<7viqk8s20j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 07:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3NwQ-0003Xy-JU
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 07:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbZEKFSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 01:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbZEKFSK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 01:18:10 -0400
Received: from main.gmane.org ([80.91.229.2]:36098 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbZEKFSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 01:18:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M3Ntt-0001Iw-Lg
	for git@vger.kernel.org; Mon, 11 May 2009 05:18:05 +0000
Received: from sdcarl02.strategicdata.com.au ([203.214.67.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 05:18:05 +0000
Received: from daniel by sdcarl02.strategicdata.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 05:18:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sdcarl02.strategicdata.com.au
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:xBkv+uza3Wu4CL515PE2zirIM+U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118773>

Junio C Hamano <gitster@pobox.com> writes:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Mon, 11 May 2009, Junio C Hamano wrote:
>>
>>> But this series, when queued to 'pu', seems to break t9500; I haven't
>>> looked at the breakage myself yet.
>>
>> I'm sorry about that. My bad. The fix is in the email (unless you
>> prefer for me to just resend the series)...
>
> That's Ok.  I had them near the tip of 'pu', and I can just replace them.
>
> But this episode does not give much confidence in Perl::Critic does it?
> The runtime "use strict" diagnosed undeclared globals in the cleaned up
> code, but presumably the Critic did not complain anything about it, right?

Perl::Critic is about coding style, not about tests like 'use strict'
that are detected by Perl already, for better or worse.

In other words: like checkpatch on the LKML, not like sparse. ;)

Regards,
        Daniel
