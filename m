From: malc <av1474@comtv.ru>
Subject: Re: [PATCH] Change octal literals to be XEmacs friendly
Date: Fri, 23 Jan 2009 22:53:31 +0300 (MSK)
Message-ID: <Pine.LNX.4.64.0901232158290.2186@linmac.oyster.ru>
References: <871vuwbnio.fsf@linmac.oyster.ru> <7vbpty1m1r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 21:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQT3m-0006Q3-BC
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 21:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbZAWUyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbZAWUyA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 15:54:00 -0500
Received: from fe02x03-cgp.akado.ru ([77.232.31.165]:58625 "EHLO akado.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754763AbZAWUx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 15:53:58 -0500
X-Greylist: delayed 3608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jan 2009 15:53:57 EST
Received: from [10.0.66.9] ([10.0.66.9] verified)
  by fe02-cgp.akado.ru (CommuniGate Pro SMTP 5.1.16)
  with ESMTPS id 41884367; Fri, 23 Jan 2009 22:53:35 +0300
X-X-Sender: malc@linmac.oyster.ru
In-Reply-To: <7vbpty1m1r.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106913>

On Fri, 23 Jan 2009, Junio C Hamano wrote:

> malc@pulsesoft.com writes:
>
>> case uses eql and (eql ?\001 1) evaluates to nil under XEmacs
>> (probably because some internal type of ?\001 is char)
>
> And I presume the new way to spell is compatible with non XEmacs emacs?
> It may be obvious to you, but please spell it out.  Parenthesized
> "probably" does not help building the confidence in the patch either.

Fair enough.

XEmacs:
(type-of ?\1) yields character

FSF Emacs:
(type-of ?\1) yields integer

>
>> Signed-off-by: Vassili Karpov <av1474@comtv.ru>
>
> How are the (nameless) author of the patch malc@pulsesoft.com and Vassili
> Karpov, the person who signed off, related?

Both are my e-mail address used in ~/.gitconfig and ~/.emacs (and used
by GNUS which was used to post the message via gmane's nntp interface)
respectively.

> Next time, please spend a few minutes to see if there are active
> developers who are familiar in the area you are touching, and Cc your
> patch to ask their input.
>
>    git blame -L562,+29 contrib/emacs/git.el
>

Okay.

> tells me that most of this came from 40f162b (git.el: Display file types
> and type changes., 2008-01-06) by Alexandre, so I am Cc'ing him.
>

[..snip..]

-- 
mailto:av1474@comtv.ru
