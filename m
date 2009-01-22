From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Short rant about git usability - make 'git clone' work on an 
	empty remote repository
Date: Thu, 22 Jan 2009 14:00:55 +0100
Message-ID: <bd6139dc0901220500q7bb91031o81c3aab41c68d518@mail.gmail.com>
References: <20090122100230.GA9653@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 14:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPzCR-0007ZR-2d
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 14:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbZAVNA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 08:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbZAVNA5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 08:00:57 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:59690 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbZAVNA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 08:00:57 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1912629ywe.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=LriyS+ZOYgdxmxyRURrayyDeVNQnPkUNdUysBOLehkE=;
        b=cqrC2XVjW/teV/DoEfjBw1czJWhmMsr0mZ57fcBgn8Cz5D+yM2eQI86XDVSRV5yyTF
         Wj9r9v1ZFxFNQLI/bXa07933ppkdZcmKcQ1itybfTbVYXaf4xMVRryQzcoS9xCTMeRLp
         krBnfxtMRaetrsz3GaZ5R+0yplmg/9+XPWbpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=XLppjMpITLbgenEskSc2Do02fvpU5QoRXrUcmFrSmTOmZDtIdu++0hVlSh5/6KWuCs
         bjkmz3iMVzXTHe7vcRIdVUANOV2G3gjaGT1PYtwCT1aYUYl8Pq0+QQdw6Mr9lBCse1t/
         bkdSgpnHObCEO3LG69CS1SviaoREY/XOJ0lrk=
Received: by 10.150.205.20 with SMTP id c20mr1093257ybg.180.1232629255795; 
	Thu, 22 Jan 2009 05:00:55 -0800 (PST)
In-Reply-To: <20090122100230.GA9653@amd.home.annexia.org>
X-Google-Sender-Auth: 91112d997ed03a4e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106749>

Heya,

On Thu, Jan 22, 2009 at 11:02, Richard W.M. Jones <rjones@redhat.com> wrote:
>  $ git clone git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git
>  Initialized empty Git repository in /home/rjones/d/ocaml-autoconf/.git/
>  fatal: no matching remote head
>  $ mkdir ocaml-autoconf
>  $ cd ocaml-autoconf
>  $ git init
>  Initialized empty Git repository in /home/rjones/d/ocaml-autoconf/.git/
>  $ git remote add origin git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git
>  $ echo test > README
>  $ git add README
>  $ git commit
>  Created initial commit 2c9a63a: Create repository.
>   1 files changed, 1 insertions(+), 0 deletions(-)
>   create mode 100644 README
>  $ git push origin master

Is, as far as I can see, the minimal you could have done to get your
remote set up. You are right in that cloning an empty repository would
be nice to have as it would save having to remember to do about 8
different commands. Then again, after digging through the source for
half an hour I'm still not sure I even understand what's going on, let
alone know how to fix it ;). You should ask on #git for cloning empty
dir support, maybe it'll annoy Dscho enough to fix it.


-- 
Cheers,

Sverre Rabbelier
