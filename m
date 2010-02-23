From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] git gui blame: Show History Context broken since  29e5573d
Date: Tue, 23 Feb 2010 07:40:16 +0100
Message-ID: <vpqiq9omp4f.fsf@bauges.imag.fr>
References: <vpqaav1llpn.fsf@bauges.imag.fr>
	<cb7bb73a1002220718p6b6621der6df062cd2f490d89@mail.gmail.com>
	<20100222223802.GA9898@book.hvoigt.net>
	<cb7bb73a1002221529r6aee3202l5b6609b59aea01fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjoRc-0006wX-SY
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 07:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab0BWGk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 01:40:28 -0500
Received: from mx1.imag.fr ([129.88.30.5]:60430 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab0BWGk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 01:40:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1N6bsUa012610
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Feb 2010 07:37:54 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NjoRN-0002HL-7d; Tue, 23 Feb 2010 07:40:17 +0100
In-Reply-To: <cb7bb73a1002221529r6aee3202l5b6609b59aea01fd@mail.gmail.com> (Giuseppe Bilotta's message of "Tue\, 23 Feb 2010 00\:29\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2010 07:37:55 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140770>

[ Adding Pat Thoyts, author of the first patch, in Cc ]

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Mon, Feb 22, 2010 at 11:38 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> On Mon, Feb 22, 2010 at 04:18:11PM +0100, Giuseppe Bilotta wrote:
>>> On Mon, Feb 22, 2010 at 9:27 AM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> > Hi,
>>> >
>>> > In "git gui blame", right-clicking on the left fringe and chosing
>>> > "Show History Context" in the context-menu doesn't work for me in the
>>> > latest git. It says:
>>> >
>>> > couldn't change working directory to "": no such file or directory
>>>
>>> Definitely my fault. _gitworktree was not being set up correctly when
>>> support for bare repositories was enabled and the repo was not bare
>>> (like in the blame case). Patch incoming, can you see if it does the
>>> job for you? It seems to fix it here.

[ patch available here :
  http://thread.gmane.org/gmane.comp.version-control.git/140688 ]

>> Isn't this the same bug as this one fixes:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/140288

It seems it is, yes.

> I believe my fix to be more correct in this regard.

Not familiar enought with the code to say which is the right one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
