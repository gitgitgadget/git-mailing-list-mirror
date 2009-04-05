From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: non-ascii filenames issue
Date: Sun, 05 Apr 2009 12:54:28 +0300
Message-ID: <87ab6v2zor.fsf@iki.fi>
References: <20090405093640.GA9803@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gregory Petrosyan <gregory.petrosyan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 11:56:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqP5s-0000iK-S1
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbZDEJyd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 05:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756837AbZDEJyd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:54:33 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:33987 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761AbZDEJyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 05:54:32 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 49CA1E670078FC91; Sun, 5 Apr 2009 12:54:28 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LqP3c-0000Do-1X; Sun, 05 Apr 2009 12:54:28 +0300
In-Reply-To: <20090405093640.GA9803@home> (Gregory Petrosyan's message of "Sun\, 5 Apr 2009 13\:36\:40 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115650>

On 2009-04-05 13:36 (+0400), Gregory Petrosyan wrote:

> # Changes to be committed:
> #   (use "git rm --cached <file>..." to unstage)
> #
> #  new file:   "\321\204\320\260\320\271\320\273"
> #
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                  "=D1=84=D0=B0=D0=B9=D0=BB" should be here instead

It can be fixed with command:

    git config --global core.quotepath false
