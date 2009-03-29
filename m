From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sun, 29 Mar 2009 13:03:01 +0200
Message-ID: <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <1238258794470-2549665.post@n2.nabble.com> 
	<8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> 
	<1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> 
	<1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> 
	<1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> 
	<1238323876827-2552153.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 13:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnsot-000721-EC
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 13:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZC2LDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 07:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZC2LDU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 07:03:20 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:1927 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbZC2LDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 07:03:19 -0400
Received: by fk-out-0910.google.com with SMTP id 18so701200fkq.5
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZPcxCGA2S3UNpbvpcyr/l6pomb32DSZvuyd4k3HpCq0=;
        b=rPjEqWd2h8Bwmarl+sLmV5N4eQ6ILja+xMYzzFo4W2AJrMnxmT02afraPK6jB7xCI2
         L5Sn+cpHw0914J9pLWPmbc2F62Hmu88rwMjrdYHrJL3EvzBjkvS3JcIkh4bELVlmbgcX
         GCLZT108qlPqEL8psu7lqf8tjXdIAQxoD0s5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=viGhxO5WSS+p6TJ1n1tGqXaHYJJFC20UXxi0W94oFWktedZUKDj8Hz9vS9vOzBURs/
         lIea3a4nJVs7rZsK4ASZ4jyHnDy+W+i9rB+kkmLpNQc4nNxLv/9/E+TO5AKGuKU6FzqB
         tUd0/ChL2tMq0Qq2Vau0mILqLRgzIDlrr7Pu8=
In-Reply-To: <1238323876827-2552153.post@n2.nabble.com>
Received: by 10.103.241.5 with SMTP id t5mr1186010mur.127.1238324596240; Sun, 
	29 Mar 2009 04:03:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115017>

Heya,

On Sun, Mar 29, 2009 at 12:51, jamespetts <jamespetts@yahoo.com> wrote:
> However, after several hours of downloading (I left it overnight), it gave the error, "The connection was aborted: Can't read from connection: The connection was aborted at C:\Program Files\Git/libexec/git-core/git-svn/ line 2490".

You can continue downloading, just issue' git svn rebase' again, and
it will continue where it left of.

> When I look at my repository on Github, it is still empty, apart
> from the empty README file that I created just to initialise it.
> Why would it be going wrong? How do I deal with that?

You would have to push the repository to github regardless of whether
'git svn rebase' finished in one go. Keep in mind that' git svn
rebase' is the way to get changes _into_ your _local_ repository.
You'll need to use 'git push' to get your changes up to github.

-- 
Cheers,

Sverre Rabbelier
