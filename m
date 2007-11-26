From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:11:41 +0100
Message-ID: <FF804F69-3EEC-4FED-AE92-18C4F5B3645F@lrde.epita.fr>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <20071126192703.GB25784@efreet.light.src>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:12:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwkJQ-0003au-Oe
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbXKZULx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbXKZULx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:11:53 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:58543 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbXKZULx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:11:53 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IwkJ4-0001Wa-Fp; Mon, 26 Nov 2007 21:11:50 +0100
In-Reply-To: <20071126192703.GB25784@efreet.light.src>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66109>

On Nov 26, 2007, at 8:27 PM, Jan Hudec wrote:

> On Mon, Nov 26, 2007 at 18:11:43 +0100, David Kastrup wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> If you would write git from scratch now, from the beginning, without
>>> concerns for backwards compatibility, what would you change, or what
>>> would you want to have changed?
>>
>> Get rid of plumbing at the command line level.  It is confusing to
>
> No, please. It's extremely useful. It should be a bit more hidden,  
> but it's
> a big advantage of git that the plumbing is available.
>
>> users, and command line arguments, exec calls and I/O streams are not
>> efficient and reasonably typed mechanisms for the kind of operations
>> done in plumbing.  Instead using a good extensible portable scripting
>> language (I consider Lua quite suitable in that regard, but it is
>> conceivable that something with a native list type supporting easy
>> sorts, merges and selections could be more efficient) and  
>> implementing
>> plumbing in that or in C would have been preferable for creating the
>> porcelain.
>
> POSIX shell is really the best extensible portable scripting language
> available for the job. Because the whipuptitude is the most important
> property and shell is simply best at one-liners. And since you use it
> for regular work (running editor, compiler, git porcelain), it is the
> obvious choice for whiping up a short function.


Perl seems pretty portable.  If we had a decent, complete libgit, it  
would be easy to create bindings for various languages and script Git  
in other languages than Shell script.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
