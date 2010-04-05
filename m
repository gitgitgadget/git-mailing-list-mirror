From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Sun, 4 Apr 2010 21:15:13 -0500
Message-ID: <h2rfabb9a1e1004041915u3754016cr10e874c12f2a24e6@mail.gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com> 
	<1270392557-26538-1-git-send-email-avarab@gmail.com> <20100404224324.GB12655@gmail.com> 
	<y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com> 
	<7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 04:15:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nybql-0003p1-CB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 04:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab0DECPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 22:15:35 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:40507 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab0DECPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 22:15:33 -0400
Received: by yxe29 with SMTP id 29so1883859yxe.4
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 19:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5poeFlazzz/Z5U4TRDxk44JyTdeA16WvUUtPzsni7Ss=;
        b=sl6xb7aH/UnDmhNPEaur4BkjK/YSTC+pfwJ82KQY606Hf06c5HtVlYLq6UAkt5Apkg
         sl7LVc+gg0vq8KpGRKA7tQhezOLVds6zYabRxs18UXdRI45l/HHBSszUbR7ryOqQ54cm
         vdNgByYxugp+fUumuW0hJ4k5v7t+ZjFVggxqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vNl9hC8Aw1eoIhSVXwzkPbLwsPR61NuviHwiP+5hhZq1Bjf963gLhzcLQ3Fx4tB3L0
         gr84dmZp91uOgw+KNOxtj1KlJp0/SFEipWpZiHZESj28q1xkXukFs3G+LnyxCYGpy73Z
         10Z2845sWQVeMDddsJu5C5nwB/8KDUkmtJUqo=
Received: by 10.100.206.13 with HTTP; Sun, 4 Apr 2010 19:15:13 -0700 (PDT)
In-Reply-To: <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
Received: by 10.101.28.5 with SMTP id f5mr9336544anj.35.1270433733150; Sun, 04 
	Apr 2010 19:15:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143966>

Heya,

On Sun, Apr 4, 2010 at 21:11, Junio C Hamano <gitster@pobox.com> wrote:
> As a Porcelain, "git commit" has some leeway to enforce sensible poli=
cy on
> the users, and "forbid commit that does not explain anything" is one =
such
> policy. =A0It is not generally a good idea to expose the full capabil=
ities
> of plumbing to Porcelain if it leads to bad user behaviour, and such
> "artificial" limitations are safety features we do not want to remove=
=2E

You contradict yourself:

commit 5241b6bfe2285a6da598a0348c37b77964035bc8
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Dec 3 00:03:10 2007 -0800

    git-commit --allow-empty

    It does not usually make sense to record a commit that has the exac=
t
    same tree as its sole parent commit and that is why git-commit prev=
ents
    you from making such a mistake, but when data from foreign scm is
    involved, it is a different story.  We are equipped to represent su=
ch an
    (perhaps insane, perhaps by mistake, or perhaps done on purpose) em=
pty
    change, and it is better to represent it bypassing the safety valve=
 for
    native use.

    This is primarily for use by foreign scm interface scripts.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>


--=20
Cheers,

Sverre Rabbelier
