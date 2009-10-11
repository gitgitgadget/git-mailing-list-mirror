From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log --graph
Date: Sun, 11 Oct 2009 21:40:16 +0200
Message-ID: <vpqhbu5zplr.fsf@bauges.imag.fr>
References: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
	<fabb9a1e0910111135v4f3c75a7v6657f5dcfacf13ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dilip M <dilipm79@gmail.com>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 21:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx4J7-0005cL-3Z
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 21:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbZJKTlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 15:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbZJKTlA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 15:41:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60759 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbZJKTlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 15:41:00 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n9BJe8A6029254
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 11 Oct 2009 21:40:08 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Mx4HB-0006bn-0f; Sun, 11 Oct 2009 21:40:17 +0200
In-Reply-To: <fabb9a1e0910111135v4f3c75a7v6657f5dcfacf13ac@mail.gmail.com> (Sverre Rabbelier's message of "Sun\, 11 Oct 2009 20\:35\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 11 Oct 2009 21:40:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n9BJe8A6029254
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1255894809.7462@fDAM0dwvQfoJzFHJss3sug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129948>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Sun, Oct 11, 2009 at 20:27, Dilip M <dilipm79@gmail.com> wrote:
>> I am trying git log --graph. (has commits in two branches...). But
>> always see one line :(
>
> It'll show you the history of one branch at a time online, you won't
> get the demo-ed multiple lines unless the branch you're looking at
> contains merges.

That said, git log --graph --all will show multiple branches.

I personnally like the format of
git log --graph --pretty=oneline --abbrev-commit
with ui.color set to true in ~/.gitconfig.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
