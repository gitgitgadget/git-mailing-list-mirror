From: Marcin Zalewski <marcin.zalewski@gmail.com>
Subject: Re: [PATCH] mergetool--lib: specialize diff options for emerge and 
	ecmerge
Date: Sun, 3 May 2009 14:47:38 -0400
Message-ID: <7c0fdf4f0905031147o47a7d2b1wbaa80df9058afeb6@mail.gmail.com>
References: <1241254641-54338-1-git-send-email-davvid@gmail.com> 
	<20090502194636.GA599@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, markus.heidelberg@web.de, charles@hashpling.org,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 20:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0gjN-0006Ob-1R
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 20:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbZECSry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbZECSry
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 14:47:54 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:63497 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbZECSrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 14:47:53 -0400
Received: by bwz7 with SMTP id 7so3267539bwz.37
        for <git@vger.kernel.org>; Sun, 03 May 2009 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8pLJvp2QGcF6ov6FRH4D68ebdQsAh6Lf9Q/vYkkWrYA=;
        b=hnMF89NYfgwN+QaRuUHXPtEwn0YCIQZQ+niSwv8tjOd8HY2Oh0pmlbrZrG3zRmRRKw
         3XLU3EN/vYyUbUlaOR8J61VWfvUpKwfXB28/pvwRmOZ2RmXTXFTUjiDjs+U2HkseLOc2
         yAiWaHo9VUr0yYwU8prFL0pSYNrfvDzkNSUOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kNB2PSJofgWFsVEDnCQyXSA3fcS6FAkJKFrJN1LlX4XOQrKeD7WuFlXov0AYPCjAtC
         kTbYua+BBPweQHtIm2w/4aFrcpTg/DGKUF+x8JGvoaHyieqpDXjrg2kFFEmzVfmINOmK
         5MDcJupBfWIDiryPn5OdMY/pxTosJUv9EtQwg=
Received: by 10.103.175.9 with SMTP id c9mr2999671mup.3.1241376473076; Sun, 03 
	May 2009 11:47:53 -0700 (PDT)
In-Reply-To: <20090502194636.GA599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118183>

David,

Thanks for your patches.

> If an emacs user could comment on the emerge snippet
> below (or perhaps suggest a better one ;)) then that
> would make me happy. =C2=A0As is, I have tested the
> emacs emerge snippet and it works, but I'm not
> sure if that's enough to resolve the issue reported
> by Marcin. =C2=A0Marcin?
>
> Here's the original thread:
> http://article.gmane.org/gmane.comp.version-control.git/117930

As far as I am concerned, this patch works well. Without the third
argument, ediff will not complain anymore that it is "too dangerous to
merge versions of a file visited by another buffer," which was my
original problem.

-Marcin
