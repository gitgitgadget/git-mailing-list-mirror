From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log --graph
Date: Mon, 12 Oct 2009 08:54:36 +0200
Message-ID: <vpqtyy5rtjn.fsf@bauges.imag.fr>
References: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
	<fabb9a1e0910111135v4f3c75a7v6657f5dcfacf13ac@mail.gmail.com>
	<c94f8e120910112001l50f9332fs43d0762bbd9207a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 09:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxEvr-0002zC-MW
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 09:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbZJLG6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 02:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZJLG6Q
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 02:58:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:63635 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbZJLG6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 02:58:16 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n9C6saZs014663
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Oct 2009 08:54:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MxEnk-0007ql-A5; Mon, 12 Oct 2009 08:54:36 +0200
In-Reply-To: <c94f8e120910112001l50f9332fs43d0762bbd9207a3@mail.gmail.com> (Dilip M.'s message of "Mon\, 12 Oct 2009 08\:31\:59 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 12 Oct 2009 08:54:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129991>

Dilip M <dilipm79@gmail.com> writes:

> Understood. it shows only when I have merged conflicts!
>
> In case, it is a fast forward merge. It doesn't show. Which is good :)

Fast-forward and merge conflicts are two different things. Non-fast
forward occurs when you merge two branches which are not a direct
ancestor of each other, i.e. both have commits that the other do not
have.

In case of non-fast forward, if you didn't touch the same file in both
branches, the merge is still trivial and conflict-free. If you touched
the same files, then Git has to apply in-file merge strategy, but that
doesn't mean you'll get conflicts either. Conflicts will occur when
you touched the same part of the same file.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
