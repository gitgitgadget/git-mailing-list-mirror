From: David Brown <git@davidb.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 22:47:00 -0700
Message-ID: <20080430054700.GA1345@old.davidb.org>
References: <alpine.LFD.1.10.0804291132060.23581@xanadu.home> <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com> <alpine.LFD.1.10.0804291232130.23581@xanadu.home> <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com> <alpine.LFD.1.10.0804291352120.23581@xanadu.home> <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com> <alpine.LNX.1.00.0804291410340.19665@iabervon.org> <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com> <46a038f90804291958u14eddc49sb54c7fd4a3a10381@mail.gmail.com> <7f9d599f0804292218x7d94d7del20d4d48bbad80fb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Wed Apr 30 07:48:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr5Am-0006UF-1M
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 07:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbYD3FrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 01:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbYD3FrM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 01:47:12 -0400
Received: from mail.davidb.org ([66.93.32.219]:48093 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbYD3FrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 01:47:11 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1Jr59g-0000PP-6S; Tue, 29 Apr 2008 22:47:00 -0700
Mail-Followup-To: Geoffrey Irving <irving@naml.us>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7f9d599f0804292218x7d94d7del20d4d48bbad80fb5@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80794>

On Tue, Apr 29, 2008 at 10:18:55PM -0700, Geoffrey Irving wrote:

>>  PS is Turing complete, and does know about dates. So yes, you can make
>>  such conditionals.
>
>I knew postscript was Turing complete, but had (naively) assumed it
>executed sandboxed and deterministically and would therefore display
>uniformly barring interpreter bugs.  Looking over the spec, I can't
>find where it's possible to read the current date, but the
>usertime/realtime variables are sufficient as long as the attacker
>knows how fast the relevant machines are.

usertime and realtime are from the start of the invocation of the
postscript interpreter, not based on the outside world.  So, the
interpreter could wait arbitrarily long, but has no way of knowing any
external reference to time.

I could imagine trickery with PDF signatures and their expiration times,
but you shouldn't be able to do anything with the information, so it would
be an exploit, and would probably be fixed.

David
