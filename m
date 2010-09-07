From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: explain "git branch --with"
Date: Tue, 7 Sep 2010 00:52:09 -0500
Message-ID: <20100907055209.GT1182@burratino>
References: <4C83FEC3.3040101@gmail.com>
 <7viq2jv05c.fsf@alter.siamese.dyndns.org>
 <AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
 <AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
 <AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
 <7v39tmtpci.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osr8a-0007Jn-98
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab0IGFyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 01:54:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56767 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab0IGFyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 01:54:13 -0400
Received: by yxp4 with SMTP id 4so1740269yxp.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 22:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=F6s0YvlPGGFGIJ4ODsF28CjUP9nzpECTUnYu5GGjhEU=;
        b=saastnaOHIuD3yRgW2JRne35oc2GxXaKR0pxrBFKiX5jBhwIjhSr4/r5oDvbN/SMN3
         UkvPq/Nj2FRQN+38hBWNmO2S7AcAsz3sgVuUP1imnmKeQoaPdVAK0luEUwdwwJTJjlM0
         BG94HGelDB1B1ptQtDcJhHhKzD/JjSVw4tM74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WC/vdtgQcj+WLSseK7inyb5scxUzvZ5acfvz7qZkhf3TnjXvwc1tw8kpJ7cYlvV11n
         KAuCpCScTzRvvbdn1EkELHPPhJfK/H51bRmJGDuYNyqbxGxpyTPWJVzvwYMwDP7a4/gY
         J+UfOR7UoiQJNK2hOR7De5j31C+td2rI1v15A=
Received: by 10.101.75.5 with SMTP id c5mr719322anl.190.1283838852727;
        Mon, 06 Sep 2010 22:54:12 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w6sm10736086anb.23.2010.09.06.22.54.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 22:54:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39tmtpci.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155680>

Junio C Hamano wrote:

> It was originally called --with.  I wrote it to help me in the exact use
> case in this thread, and the option was naturally named --with, as the
> request I wanted to make was "Give me branches _with_ this commit, so that
> I know which ones I need to rewind before reintegrating and publishing".
> 
> Somehow people wanted to see an option with a longer name, but by that
> time my fingers were well trained, so I kept "--with" but didn't bother
> advertising duplicated options.

More precisely, it is advertised by "git branch --help-all" but not
the manual or "git branch -h".

How about adding it to the man page so people can look up this option
after encountering it in the wild?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-branch.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1940256..f479e2f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -142,6 +142,7 @@ start-point is either a local or remote branch.
 	branch points to is not changed.
 
 --contains <commit>::
+--with <commit>::
 	Only list branches which contain the specified commit.
 
 --merged [<commit>]::
-- 
1.7.2.3
