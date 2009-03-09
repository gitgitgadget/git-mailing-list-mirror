From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib/difftool: use a separate config namespace for 
	difftool commands
Date: Mon, 9 Mar 2009 11:52:50 -0400
Message-ID: <76718490903090852se7fc756m818f5d8ba49278b5@mail.gmail.com>
References: <1236589956-13486-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:54:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgho6-0008ON-CJ
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbZCIPwx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 11:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbZCIPwx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:52:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:21114 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZCIPww convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 11:52:52 -0400
Received: by rv-out-0506.google.com with SMTP id g9so1811131rvb.5
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3YDzY8ONq4DdsyQbJt1LQJYUFG4BA51obNpF67/Kg0E=;
        b=XssNvI443M06D1n92HDDbDlgUqQVyQUO84D+Mha9rSax2j825kdeL1hiUeU+OwUvqG
         MhkAmeJXKPmKbiw5s/3bG9UfJulVRxkDkGQl9iyxWNt5Eg4XDgNiqiFK/FYn4kujPZpl
         deqkPFC9ePVnS+MTVJx1azO+zlLbBe+lwX+k0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RrHi+6L2gWp6C6tpSm5Ozz/Wsrqe0R/FT8ac8fm5ZGbhqNj2juVB80xLdP1nQpkq1t
         WkGq7wiZx2UT5BFSFmj0OGVQBh17WAUEVlVC/cSV3PRUr1KcXTk+ps5L+7VvPxlUm1bh
         VFz80bMKWmLc19JXntS7QPg9pwc+BTXk06yso=
Received: by 10.141.122.1 with SMTP id z1mr3126247rvm.275.1236613970736; Mon, 
	09 Mar 2009 08:52:50 -0700 (PDT)
In-Reply-To: <1236589956-13486-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112708>

On Mon, Mar 9, 2009 at 5:12 AM, David Aguilar <davvid@gmail.com> wrote:
> =C2=A0contrib/difftool/git-difftool =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A06 +++---

Aside, (for Junio I guess...), what's the reason this command is in
contrib, and by what criteria might it graduate to being installed
with the rest of the git commands?

j.
