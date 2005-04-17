From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 14:44:18 -0400
Message-ID: <4262AE82.1070702@dwheeler.com>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417170539.B13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170937020.7211@ppc970.osdl.org> <4262A767.4040300@dwheeler.com> <20050417192000.C13233@flint.arm.linux.org.uk>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:38:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEfQ-0006Py-7O
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVDQSma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVDQSma
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:42:30 -0400
Received: from cujo.runbox.com ([193.71.199.138]:62672 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261403AbVDQSmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:42:25 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNEis-0000Qv-4K; Sun, 17 Apr 2005 20:42:22 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNEir-0002Gq-Lh; Sun, 17 Apr 2005 20:42:22 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417192000.C13233@flint.arm.linux.org.uk>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>On Sun, 17 Apr 2005, Russell King wrote:
>>>>One thing which definitely needs to be considered is - what character
>>>>encoding are the comments to be stored as?
...

I replied:
>>I would _heartily_ recommend moving towards UTF-8 as the
>>internal charset for all comments.

Petr said:
 >Not that the plumbing should actually _care_ at all; anyone who uses it
 >should take the care, so this is more of a "social" thing.

The _plumbing_ shouldn't care, but the stuff above needs to know
how to interpret the stuff that the plumbing produces.

Russell King said:
> Except, I believe, MicroEMACS, which both Linus and myself use.  As
> far as I know, there aren't any patches to make it UTF-8 compliant.

Since plain ASCII is a subset of UTF-8,
as long as MicroEMACS users only create ASCII comments,
then the comments you create in MicroEMACS will still be UTF-8.
No big deal.

For reading comments, if the text is almost entirely
plain ASCII, you could just ignore the problem and have the
occasional character scramble.  If you need more, you'll
need a tool that's more internationalized or a working iconv,
but if that's important you'd be motivated.

Again, I'm looking for more generalized solutions, where
non-English comments are more common than in Linux kernel code.

--- David A. Wheeler
