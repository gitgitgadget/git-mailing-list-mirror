From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git drawbacks?
Date: Fri, 6 Nov 2009 11:49:36 -0500
Message-ID: <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com>
References: <loom.20091106T160709-387@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 17:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6S0v-0002pX-JU
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 17:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759511AbZKFQtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 11:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759478AbZKFQtv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 11:49:51 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:38963 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759469AbZKFQtu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 11:49:50 -0500
Received: by ywh40 with SMTP id 40so1053108ywh.33
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 08:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=q/TlqYjRz492h2qTYMgF3UOyxnZtPFTHW4IzpDNRZRM=;
        b=AVJQPOyPrrTDddUCbZXV6DfgeC+0Ipepn40VM0zJTRzRucAF67RYueF/mgAcTFsyAy
         SOkuFNtS+ocy9aVCHmI1pEInPjd64Pi//7f63JqHvTPn81WRUZMweIkoV7lJAvDRWMGx
         pvT8w/b3qgyBTNauiJyBZA2oov09HAY3jZwXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PQJ/xxxPuGPUSZ3q3M8TgzY/sfR7kdcJ34jxesfnDV3XfLPAHpaqY1Z1plTDeh6LSj
         gt+nzzgn+FO5EZKRURqyQRImXkHjFARp87gmsTgxHXuKt4GFYII/3Bsz/N5sO8QVpdJs
         9s78ZVJfViB1kBXoeUCzwcW0KEYWkw8Rix4uk=
Received: by 10.150.14.3 with SMTP id 3mr8053568ybn.288.1257526196078; Fri, 06 
	Nov 2009 08:49:56 -0800 (PST)
In-Reply-To: <loom.20091106T160709-387@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132311>

On Fri, Nov 6, 2009 at 11:17 AM, Dmitry Smirnov <divis1969@gmail.com> wrote:
> Here is the wish list for the VCS I would prefer:
> 1. Atomit commits
> 2. The possibility to get any slice of the code repository with the possibility
> to commit my changes on tip or on separate branch.
> 3. The minimum footprint of the same code on my local machine.
> 4. No code/history on my machine untill I really need it.
> 5. Easy mirroring and replication
>
> I would say, ClearCase might be my favorite if it is not commercial. :-)

#1 and #5 are features of any DVCS, so git already has them.  #2, 3,
and 4 are all just saying the same thing: "I can't afford the disk
space to store the entire repo."  Are you sure this is true, or is it
a preconception?  Even a 1GB repository is tiny by modern disk
standards.

My (limited) experience with ClearCase is that it's so slow that you'd
do *anything* to track fewer files in your working copy, so they put a
lot of work into exactly that, and no work into performance.  This
lousy performance isn't the case in git (except in Windows).  Are you
using Windows, by chance?

Have fun,

Avery
