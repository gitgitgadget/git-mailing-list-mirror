From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: git-remote-hg
Date: Sat, 12 Apr 2014 16:42:35 -0500
Message-ID: <5349b34bb72db_473d1391308ac@nysa.notmuch>
References: <20140120.181832.898588286941108442.Christophe.Troestler@umons.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Christophe <Christophe.Troestler@umons.ac.be>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 23:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ5r8-0002rG-5d
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 23:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbaDLVwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2014 17:52:38 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:35720 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbaDLVwi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2014 17:52:38 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so7675269oag.22
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=kOrpEN0FDJxwIDRTJHqlCIyFYfCwyTPN/Wi0kyHlx74=;
        b=R18ISyYi4YDXcVjvpvosHF6Kx6NfmyzLrfRt7X6aohBR4fByc1HkTzpurRgjglDPyr
         Z6lW1JSsfe1MsBIs64hFreGJHJJkaC9CSe/EBuyZkrsDK+gdvxRH1qIguEh+9zRliyl7
         ZYX8F9MiKLRhcuwrpEC36wK6NHbLygWzkx4qSf0pq3IGpeWkHsKMYjyZiqX+u8KMjI4u
         eTSUyEsahzoWlKnr80VE4NaSq5U52v4UDF2MqJw8IU1uy5QGVb3z/TYTUcflFS3O9AlK
         sfNgB48FEvksux2ZhTZGHXHqIFnLuuSh52tcQkNYrUVg58dBPxxC4bieZSCx/oi5Ggk/
         fOVw==
X-Received: by 10.60.39.131 with SMTP id p3mr26608387oek.44.1397339557753;
        Sat, 12 Apr 2014 14:52:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ko3sm49828093oeb.1.2014.04.12.14.52.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 14:52:36 -0700 (PDT)
In-Reply-To: <20140120.181832.898588286941108442.Christophe.Troestler@umons.ac.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246196>

Christophe wrote:
> I am using git-remote-hg to access to projects on bitbucket.  I can c=
lone the
> master branch fine and push to it.  I also see hg branches as
> remotes/origin/branches/=C2=ABbranch=C2=BB.  However, if I create a l=
ocal branch
> "branches/x" and want to push it to remotes/origin/branches/x, it get=
s pushed
> to the remote master (aka default) branch.

Which version of the script and Git are you using?

If I do `git push origin branches/test` it works fine, I can see the br=
anch in
bitbucket.

> What is the recommended way of working with multiple branches when
> interacting with a remote hg repository?

My recommendation is to avoid them (I don't see the point of them), but=
 they
should work.

--=20
=46elipe Contreras