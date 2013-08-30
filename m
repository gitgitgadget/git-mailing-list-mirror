From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Fri, 30 Aug 2013 07:16:34 +0200
Message-ID: <b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
References: <20130829180129.GA4880@nysa> <xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com> <CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 07:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFH4m-000730-AL
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 07:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab3H3FQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 01:16:48 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:51670 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3H3FQr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 01:16:47 -0400
Received: by mail-we0-f179.google.com with SMTP id t58so1199040wes.10
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=Hs6mkZq5p6cQBgX1H7tqt3MljrvHt0PXl9Y21D3TXbc=;
        b=vXCHGwAkSiqx2MDKhFAvfmyNxc36OTSnNFBebaPub58meX/uxNx10rPIg/YFMWlAkx
         g4dVrG5rfHRC5Id5YhDNAwECWGFp6R4OqO+JoQ+F71HQ4ChvI35+2iyzQfZrdy0HfGP0
         oNIdTuUVHvmS2jDooWGHsPcWQJzj2bI5Cj/I/o+kg6joVg9MGxRQGkhIuIDP3yClxJOp
         zJG917Kj9Kj3mhXYQFU/PgDpPbvOAssdinseg61n31m9Umup2hEzRc8PisKDWpH1q9aq
         FfGk5c9RufbnhpdgKwyzh6kM68qZQEjbzd4SVMYAl4V6M+U542pouQ+k+/p6Kxpv0u+Q
         oUmQ==
X-Received: by 10.180.8.42 with SMTP id o10mr925565wia.0.1377839806360;
        Thu, 29 Aug 2013 22:16:46 -0700 (PDT)
Received: from [100.106.110.201] ([46.77.124.201])
        by mx.google.com with ESMTPSA id i3sm1324495wiw.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 22:16:45 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233393>

Drew Northup <n1xim.email@gmail.com> napisa=C5=82:
>I agree with Junio. This effort is better spent making the
>documentation clearer and more succinct. The reality is that a user
>needs to build a model in their mind of what they are doing which maps
>enough (completely is not required) to what is actually going on to
>get work done. If the documentation or the instruction is getting in
>the way of that in the name of simplifying the presentation then the
>presentation is wrong.

Why do you think the "stage"  model do not map enough?=20


>We add content snapshots to the index of content (creating
>"temporary"--they will be garbage collected eventually if they become
>orphans--objects into the store at the same time). We build commits
>from those snapshots (in whole or in part, typically only using the
>most recent snapshots of new things added to the index) and save those
>in the object store with the content and tree objects. Sometimes we
>create tag objects to record something special about commits, trees,
>and content blobs.

The above can be rewritten to use the 'staging area' concept just fine.=
 And I don't think you should say to inexperienced users things like 't=
ree objects'.

A good exercise would be to take documentation of some command and show=
 that it can or can't be rewritten to use the other term.=20

Instead of 'indexing' or 'staging' content you could also use term 'mar=
k'. You mark content to add, for removal, you can diff it or revert.=20



>
>That's the real model (with some rough edges). Explaining what that
>has to do with distributed version control is the hard part.


--=20
Piotr Krukowiecki=20
