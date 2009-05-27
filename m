From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 2/4] git-am foreign patch support: autodetect some patch 
	formats
Date: Wed, 27 May 2009 10:19:41 +0200
Message-ID: <cb7bb73a0905270119w30d1053ah6427363b9cbe4428@mail.gmail.com>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vd49vj9mb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 10:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9EMb-0004Zu-6b
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 10:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240AbZE0ITo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 04:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755537AbZE0ITm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 04:19:42 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:55671 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbZE0ITl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 04:19:41 -0400
Received: by bwz22 with SMTP id 22so4394353bwz.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ph4+eRSxSEo2jI3oKgVxxIObBHDMj2TwRi7yepuS9oI=;
        b=kaqQ0z+NIjobiv7I7ym+XQpWx74uT5iM+nBkRQ+AdgHwNn2Uv+Jk0P6wCbSW5X1WSu
         26W3UHkWClzCxv9diNtN8zejzdnzjkRmADPzKmGfv81EWjp+68O7inxNw6hlbi0xh5Z9
         nU87J6ljEJnvOaNu+XZngJgkoXqzlhzfyibto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hf5R8THt/PU73DmPM5Cucu7Q7jzjeZeFO5fwK9i7QaCf/u9R5qj72nDazDxWqXljCz
         PwIMRPobaLodRHbDVel3hlbyr9IxfNXQJDtDvyAS+vqU46m79wBs/74gycfpBWI6eNy+
         XUgX+YrPkRx4uhyHZkM5h2hT5BhKictQG952A=
Received: by 10.204.31.77 with SMTP id x13mr9050589bkc.6.1243412381957; Wed, 
	27 May 2009 01:19:41 -0700 (PDT)
In-Reply-To: <7vd49vj9mb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120046>

On Wed, May 27, 2009 at 9:19 AM, Junio C Hamano <gitster@pobox.com> wro=
te:

> Don't make the case unnecessary too deep nor redundant.
>
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0read l3
> =A0 =A0 =A0 =A0case "$l1" in
> =A0 =A0 =A0 =A0"From "* | "From: "* )
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0patch_format=3Dmbox
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;

Oh thanks. I think I had tried the construct this way but failed to
make * and | work together. Looks like I was doing it wrong.

--=20
Giuseppe "Oblomov" Bilotta
