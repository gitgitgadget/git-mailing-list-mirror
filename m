From: Mark Junker <mjscod@web.de>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Tue, 22 Jan 2008 09:09:33 +0100
Message-ID: <fn48bp$ff8$1@ger.gmane.org>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>	<7vlk6iv0ik.fsf@gitster.siamese.dyndns.org> <7vr6gatidd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 09:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHED9-0002it-9G
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 09:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbYAVIJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 03:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbYAVIJn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 03:09:43 -0500
Received: from main.gmane.org ([80.91.229.2]:40604 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbYAVIJm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 03:09:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JHECS-0007od-1Y
	for git@vger.kernel.org; Tue, 22 Jan 2008 08:09:40 +0000
Received: from 80.146.179.234 ([80.146.179.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 08:09:40 +0000
Received: from mjscod by 80.146.179.234 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 08:09:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.146.179.234
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
In-Reply-To: <7vr6gatidd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71430>

Junio C Hamano schrieb:

> To support the above scenarios, I think each instance of
> repository needs to be able to say "this path (specified with a
> matching pattern in the filename encoding) should be converted
> this way coming in, and that way going out."  UTF-8 only project
> would have NKC<->NKD on HFS+ partition, and nothing on
> everywhere else.  EUC-JP project that checks out as-is would
> specify nothing either, but people on Shift_JIS platforms would
> locally specify that EUC-JP <-> Shift_JIS conversion to be made.

Just to sum up what you wrote and to be sure that I understand you 
correctly:

Lets have two encodings:
- Encoding for path names stored in the repository
- Encoding for path names from/to file systems

Do conversion only if they are different. Both encodings are configurable.

Regards,
Mark
