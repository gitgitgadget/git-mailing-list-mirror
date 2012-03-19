From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: A better git diff --word-diff (--word-diff-regex) ?
Date: Mon, 19 Mar 2012 10:50:29 +0100
Message-ID: <87ipi0vs0q.fsf@thomas.inf.ethz.ch>
References: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9ZEb-0006ES-Om
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 10:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758710Ab2CSJud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 05:50:33 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:24646 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758591Ab2CSJuc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 05:50:32 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 19 Mar
 2012 10:50:29 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 19 Mar
 2012 10:50:29 +0100
In-Reply-To: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
	(Piotr Krukowiecki's message of "Mon, 19 Mar 2012 10:44:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193422>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> is there a way to configure --word-diff to be a more programming
> language friendly? For example if I add one parameter to a function
> declaration, I'd like to see only the addition of the parameter as the
> change. But currently it shows much more.
>
> For example if
>   void foo(int x);
> is changed to
>   void foo(int x, int y);
> I'd like to see only ",int y" as the change, not "x, int y);".
>
> I think I'd like to ignore all white spaces and tokenize text on word
> boundaries and see the diff between the tokens. This way if I e.g. add
> a missing ";" it'll be shown as the only change.

Umm, what's wrong with

  echo '*.cpp diff=cpp' >>.git/info/attributes

Ok, the funcname patterns aren't so good, but the word regex is designed
to "tokenize" as far as that is feasible.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
