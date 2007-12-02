From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 17:12:52 +0100
Message-ID: <C1CE0786-FB89-4E5D-9FEA-1F2FFFD47D12@wincent.com>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyrRX-0008Rw-BP
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbXLBQMz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 11:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXLBQMz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:12:55 -0500
Received: from wincent.com ([72.3.236.74]:58058 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbXLBQMy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 11:12:54 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB2GCr39003946;
	Sun, 2 Dec 2007 10:12:54 -0600
In-Reply-To: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66788>

El 2/12/2007, a las 17:06, Steffen Prohaska escribi=F3:

> When I run
>
>   gitk 6e6db85ea9423eea755cf5acf7a563c0d9559063
>
> gitk complaints with 'Error: expected integer but got "Hamano"'.
>
> I tracked the problem down to the raw content of the commit object.
> The author line is lacking time and timezone information:
>
>    $ git-cat-file -p 6e6db85ea9423eea755cf5acf7a563c0d9559063
>    tree 5265f13d094e7c453a06f097add25eaefb843a79
>    parent d25430c5f88c7e7b4ce24c1b08e409f4345c4eb9
>    author Junio C Hamano <gitster@pobox.com>
>    committer Junio C Hamano <gitster@pobox.com> 1196466497 -0800

Yeah, and:

$ git show 6e6db85ea9423eea755cf5acf7a563c0d9559063 | head -3
commit 6e6db85ea9423eea755cf5acf7a563c0d9559063
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jan 1 00:00:00 1970 +0000

Cheers,
Wincent
