From: Bill Lear <rael@zopyra.com>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Sat, 20 Jan 2007 13:54:14 -0600
Message-ID: <17842.29542.229557.460473@lisa.zopyra.com>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 20:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8MIO-0007F5-CB
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 20:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbXATTy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 14:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965361AbXATTy1
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 14:54:27 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60711 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965360AbXATTy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 14:54:27 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0KJsOE01234;
	Sat, 20 Jan 2007 13:54:24 -0600
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfya57ast.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37284>

We are using git 1.4.4.1, the latest I thought available, not 1.4.4.4
(perhaps you mis-typed?).

In any case, I personally would love to try the latest build of git,
but I don't think I can convince the rest of the company to do so.

I just got an email from one of the developers.  He seems to think
this is alleviated by using bash instead of tcsh.  He said he is
debugging his environment to see if he can isolate the problem.  I
have asked for more details and if I can find out more, I will
certainly communicate it here.

If I were to get people to agree to try the latest git build, would I
be able to just let the developer install and use it on his machine,
or would I need to also update our company repo?  If the former, I
would have a much easier time convincing them.

Thanks.


Bill

On Saturday, January 20, 2007 at 11:33:38 (-0800) Junio C Hamano writes:
>Junio C Hamano <junkio@cox.net> writes:
>
>> Bill Lear <rael@zopyra.com> writes:
>>
>>> % git push
>>> updating 'refs/heads/master'
>>>   from 6b421066e842203e383e1dc466c1cdef10de56b1
>>>   to   2a8e554ae0c99d44988690c9fce693b3f5f128fa
>>> Generating pack...
>>> Done counting 61 objects.
>>> Result has 32 objects.
>>> Deltifying 32 objects.
>>>  100% (32/32) done
>>> Writing 32 objects.
>>>  100% (32/32) done
>>> Total 32, written 32 (delta 18), reused 0 (delta 0)
>>> Unpacking 32 objects
>>> fatal: protocol error: bad line length character
>
>By the way, I can see from the pack-objects output above that
>you seem to be using git before commit 67c08ce1 (Nov 29, 2006);
>most likely you are using the official 1.4.4.4?
>
>Is it possible for you to try git built from the tip of 'master'
>to see if it reproduces?
