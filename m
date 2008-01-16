From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] treat any file with NUL as binary
Date: Wed, 16 Jan 2008 04:13:21 +0300
Message-ID: <20080116011321.GD13984@dpotapov.dyndns.org>
References: <1200407309-10992-1-git-send-email-dpotapov@gmail.com> <7vsl0yd6r8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:13:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwqq-0005vF-CB
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYAPBN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbYAPBN2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:13:28 -0500
Received: from smtp08.mtu.ru ([62.5.255.55]:55746 "EHLO smtp08.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbYAPBN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:13:27 -0500
Received: from smtp08.mtu.ru (localhost [127.0.0.1])
	by smtp08.mtu.ru (Postfix) with ESMTP id 9F015F770E6;
	Wed, 16 Jan 2008 04:13:25 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-67.pppoe.mtu-net.ru [85.141.191.67])
	by smtp08.mtu.ru (Postfix) with ESMTP id 17AF2F7701B;
	Wed, 16 Jan 2008 04:13:20 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEwqH-000409-4w; Wed, 16 Jan 2008 04:13:21 +0300
Content-Disposition: inline
In-Reply-To: <7vsl0yd6r8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp08.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70591>

On Tue, Jan 15, 2008 at 03:11:07PM -0800, Junio C Hamano wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > So, please, consider it for inclusion as a bug fix.
> 
> Somebody has to go back to the "git log" output and the list
> archive to see if you two did not forget other ramifications,
> because I vaguely recall this 1% thing was done for a reason and
> Linus had a very good argument (at least back then the argument
> sounded very good to me) supporting the deliberate difference
> between the two "binary" heuristics.

First of all, my patch does not make them being the same, it just
makes one being stricter than the other, and I explained why it
is the tight thing to do.

Second, it is difficult for me to find to what particular words
of Linus *you* refer to. However, if it is something like this
post:

http://article.gmane.org/gmane.comp.version-control.git/39618

Then it seems to me, Linus sounded more in favor of that change than
against it. His main argument was against 'diff' heuristic, which he
felt was not strict enough for CRLF translation: "It's *much* better
to miss some CRLF translation than to do too much of it."


Dmitry
