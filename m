From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Q about git rev-parse {--is-inside-work-tree, --show-cdup}
Date: Sat, 04 Dec 2010 16:12:39 +0100
Message-ID: <4CFA5A67.2020108@dirk.my1.cc>
References: <4CF95BDC.60506@dirk.my1.cc> <7v4oauo8fj.fsf@alter.siamese.dyndns.org> <20101203215032.GB3972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 04 16:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POtn8-00069y-9L
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 16:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab0LDPMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 10:12:44 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:52127 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab0LDPMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 10:12:44 -0500
Received: from [217.87.113.135] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1POtmz-0004B5-J7; Sat, 04 Dec 2010 16:12:41 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <20101203215032.GB3972@sigill.intra.peff.net>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162894>

Am 03.12.2010 22:50 schrieb Jeff King:
> On Fri, Dec 03, 2010 at 01:25:36PM -0800, Junio C Hamano wrote:
>
>> That would break existing scripts that expect "-q" to squelch only the
>> error output, no?  I think the risk of breaking existing scripts that
>> other people wrote over time that you (and I) haven't seen outweighs any
>> benefit (i.e. "if test $(rev-parse...) = true" vs "if rev-parse...") you
>> are seeing here.
>
> Right now "-q" doesn't do _anything_ for --is-inside-work-tree, AFAICT.
> It is a useless no-op. So I don't know if we are breaking anybody. What
> does somebody doing "git rev-parse -q --is-inside-work-tree" expect to
> happen?
>

Peff, Junio, thanks for your answers.

I already had a suspicion that changing plumbing tools like
rev-parse was a bad idea. You confirmed that. However, I still
think it's a little bug that "--show-dup" returns an empty string
instead of a dot when already in topdir. But it's too late to
change that, I guess. I didn't know about Peff's suggestions
"git-sh-setup" and "--show-toplevel". They may help me.

@Peff, right, it's annoying that -q sometimes works and
sometimes doesn't. To my opinion switches like --quiet and
--verbose should _always_ work.

     Dirk
