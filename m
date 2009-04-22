From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Wed, 22 Apr 2009 22:40:01 +0200
Message-ID: <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
	 <20090422082652.GA32698@gmail.com>
	 <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
	 <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwjGE-00029T-24
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbZDVUkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 16:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZDVUkE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:40:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:25131 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbZDVUkD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 16:40:03 -0400
Received: by yx-out-2324.google.com with SMTP id 3so115043yxj.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O/LxeP0QM5re4Zj5GBbuXSU96dwGq3bgYuBXK929hI4=;
        b=hUjPyyzovV29gn72orAHfE9O5XEBO5frgFknnJ4uCyfXGt3JZQ3wTRuk4nbNMZB+oR
         yBSImjTClYVRjGYHul1a23/s7YhMysPWkSaXKsIjGovJz4y2c4l3rxReqcu9PdfD96iK
         MaHHcNI/5czvRzGCJfN2ttqb+7usJDz2K0dzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FNQRIaZ/8VZWyeNLHBM5QH2fSyNuGOI6GAQx3ItKnWg5LXqE572bPWi9iLYCN9LHYt
         rgZTYb02NtqQcthclXpPb1faEwhG3cVwEM3cDpeeUWqcDPYmWVTi6WEKaaJc2FB9VZm+
         IYR6xTyenZTSs5x0ZNIXrQlFArsnhJli7R1Qk=
Received: by 10.151.69.7 with SMTP id w7mr490363ybk.10.1240432801457; Wed, 22 
	Apr 2009 13:40:01 -0700 (PDT)
In-Reply-To: <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117255>

2009/4/22 Junio C Hamano <gitster@pobox.com>:
>> Yes, FWIW. I intentionally stopped signing off patches for
>> Windows, ActiveState Perl and Cygwin: they usually harm the
>> rest of the world, while just allowing Windows users limp along.
>
> I have to wonder if you are doing that with the full understanding of=
 what
> Signed-off-by means. =C2=A0I do not think the provenance of your patc=
h is
> affected by your distaste towards the system it has effects in any wa=
y.

I'm trying to avoid being associated with development for the platform =
:)

=46rankly, I just always forget about it. The patches to my windows
repository are mostly just hacks to either make it pass test suite or
workaround another, the platforms specific, stupidity. Not sure anyone
is actually interested in them (because, I repeat, they mostly hurt
everyone else, while making the platforms port "a little working").
