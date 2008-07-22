From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: extracting the history of a single file as a new project [Was: Re: making a branch with just one file and keeping its whole]
Date: Tue, 22 Jul 2008 08:15:57 +0200
Message-ID: <bd6139dc0807212315j4d1f1ff7rcc92077a8c70dba7@mail.gmail.com>
References: <20080721061804.223f7801@mail.tin.it>
	 <loom.20080721T161926-61@post.gmane.org>
	 <alpine.DEB.1.00.0807211907270.8986@racer>
	 <279b37b20807211122w3a1e0687wc84693bd95689326@mail.gmail.com>
	 <alpine.DEB.1.00.0807211937390.8986@racer>
	 <20080722041457.52120c2f@mail.tin.it>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, madewokherd@gmail.com
To: ncrfgs@tin.it, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLBBB-00079F-K0
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbYGVGP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 02:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbYGVGP6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:15:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:14212 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbYGVGP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 02:15:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2009392wfd.4
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 23:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EoXnty4Dzt440DZJ/SsQKQ5mKMNpmYRJwJqK8/uhLr4=;
        b=l3j81djfVDZgRkGapQjIMEn0FH949whZX8LQNdVg8fVgOVUa3Bwceds8knHF5I2KGh
         LT40lu6SJsKXFjiT7gggNfPI/lDZfPCfsqrPfKAYz/faNG8jE801ZcnKYBJDx2IlUD/e
         lt8iJY3tslhA60BHvIJ8Oub0unxLygRQ1/jxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Zo9N2LTkXKk0Nmv1kRh2K7cS79eTOZHi3fafhoptDW5UX3odBuRC4OTA9ce28eFGCW
         z+feltkMf+G/SpDh1kCZdVVdmXjinqmK1zf921nc7YR55QoGawIy232pYzAmVAUhgSbS
         fNvypsIgdsD3KHEwN9UrXMTXj67K0H0FvHHOo=
Received: by 10.142.154.20 with SMTP id b20mr1710942wfe.99.1216707357355;
        Mon, 21 Jul 2008 23:15:57 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Mon, 21 Jul 2008 23:15:57 -0700 (PDT)
In-Reply-To: <20080722041457.52120c2f@mail.tin.it>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89444>

On Tue, Jul 22, 2008 at 4:14 AM,  <ncrfgs@tin.it> wrote:
> Let's say we are at commit #3000, I have this content I want to start a
> new project from, which has been put in three different files:
>
> path1/filename1 from commit 1 to commit 1000
> path2/filename1 from commit 1001 to commit 2000
> path2/filename2 from commit 2001 to commit 3000
>
> In the meanwhile path1/filename1 has been created on commit 2500 with
> path1/filename1 having nothing to do with the new project I'd like to
> start.

<snip>

> My first idea to accomplish what I'd like to do, was to use the ouput of
> `git-log -p --follow path2/filename2` with another git command; on
> #git@freenode I've been suggested to use git-clone and
> git-filter-branch.
>

It would seem that this is a valid use-case for a properly working
"git log --follow", yes?

-- 
Cheers,

Sverre Rabbelier
