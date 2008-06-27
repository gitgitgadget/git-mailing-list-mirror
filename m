From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 09:54:43 -0700
Message-ID: <9af502e50806270954q613087efub0eb05c25f2eefb9@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <20080627071014.GA12344@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHEi-0008Ro-RZ
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbYF0Qyq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 12:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbYF0Qyq
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:54:46 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:22293 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694AbYF0Qyp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2008 12:54:45 -0400
Received: by fk-out-0910.google.com with SMTP id 18so516760fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7GT8xYrL0w9opjjq4W3PLVrerLuMG9N+1pRMouyhBiw=;
        b=JQit7Prigj8kpwfwifeXo/nVOYeIIiJpkg4ZYDYo9KrlHYVqb2SaG8HzC//80mfNBb
         lFZ18UyBN19Oywuio/LeEDfM1WTlDHJbJMO41T2brT3DpPjt3KHYASF2kVgBapjkkAq3
         TyyuakhePsgjznRZ1OetWpId4bXj3wOF8GRp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cIF9lAduxu2c3FlXnt0ZTtSODsCe3USbZXF4tyF2afY44tiAHZSjLfz4oXshAdahM2
         PBu+g+M4GGc/EqQm1fP4zgH8fhS5npLvPDFpAEaeU2Vb+zclQ4NQgmd1Gk3l1JGNYK6w
         m/eZH92h6utJmegr5aR18fhpQzh4C22cuwutM=
Received: by 10.82.127.14 with SMTP id z14mr67068buc.67.1214585683077;
        Fri, 27 Jun 2008 09:54:43 -0700 (PDT)
Received: by 10.82.178.10 with HTTP; Fri, 27 Jun 2008 09:54:43 -0700 (PDT)
In-Reply-To: <20080627071014.GA12344@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86596>

On Fri, Jun 27, 2008 at 12:10 AM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.=
de> wrote:
> Hm, I use "stash" for that purpose, which leads to kind of the revers=
e
> of your approach. So I do sth. like this:
>  - hack hack hack
>  - Notice that I want to make two commits out of what I have in my
>   working tree
>  - git add -p -- stage what I want in the first commit
>  - git commit -m tmp -- temporary commit

This is a guess at the first commit?  I don't like it, but I'm still li=
stening.

>  - git stash -- stash away what doesn't belong in the first commit
>  - git reset HEAD^ -- drop the temporary commit, with the changes kep=
t
>   in the working tree

Now I have my guess at the first commit as my tree state, correct?
What happens when I decide I need a couple of hunks from another file
which I missed in my first guess, and is now in the stashed state?
How do I get those out of the stash and into the working tree?  If
there is no convenient way to do that, then this method is not
sufficient to cover the use case I am talking about.

Thanks,
Bob
