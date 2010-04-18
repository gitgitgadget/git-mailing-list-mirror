From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Sun, 18 Apr 2010 23:10:16 +0200
Message-ID: <w2gfabb9a1e1004181410ia09cc99o1ba807b53744f3ee@mail.gmail.com>
References: <1271552047-sup-9523@kytes> <20100418025940.GA2249@progeny.tock> 
	<1271566767-sup-7167@kytes> <7vk4s4wqo5.fsf@alter.siamese.dyndns.org> 
	<m2pfabb9a1e1004181144x10f6a0f1x2e55bc025aba781b@mail.gmail.com> 
	<7vzl10v5mo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 23:10:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3blM-0008JS-FG
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 23:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0DRVKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Apr 2010 17:10:39 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:52975 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab0DRVKi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Apr 2010 17:10:38 -0400
Received: by bwz25 with SMTP id 25so4844587bwz.28
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HT7ZPIz5DHhaKC1WLqEZlZcCewXLChX7WFW0BMHjjqk=;
        b=nO0UaA+E11v54KPI+9XomnenFLEof/cyyOUwLq2mUaszs1QtD0RDmoJ8j4QGDwmTYX
         gdS+TKDx7CpNZWwYkFBnByiI4Gb9Q9hj716g9Q4vqvinitOAyFYV+e7Z7A2mfZRJ3U53
         fn21vK2gGwHYtVA+zmjqWVMiZVVj0XcIHV5p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oiqTS72g8nqhAUWvvtAKz7PvfbdrJB9939x6WSlKZMRgLSpFZLpWZQsQOXH/mVm5uJ
         lEMKAfi70e1ZJqC2wuuur3uZgKbVuz+7xdJVVIoyvk8vBpOqsWQsW0lmHzwpehAqk+2D
         ZNyfc6ijCA6wfr3cRKZUaKexndHYQR5+Q6ePQ=
Received: by 10.103.168.14 with HTTP; Sun, 18 Apr 2010 14:10:16 -0700 (PDT)
In-Reply-To: <7vzl10v5mo.fsf@alter.siamese.dyndns.org>
Received: by 10.103.35.5 with SMTP id n5mr2920933muj.93.1271625036063; Sun, 18 
	Apr 2010 14:10:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145248>

Heya,

On Sun, Apr 18, 2010 at 22:59, Junio C Hamano <gitster@pobox.com> wrote=
:
> Thanks. =C2=A0The end results look good to me, too.

Hmm. Do we want to get this into 1.7.1? With how much debate this
series has had I don't see much added benefit from having it cooking
in next. I noticed another doc patch got merged into master in the
latest cooking, so I'm sort-of assuming there's special rules for
documentation, please correct me if that's nonsense.

--=20
Cheers,

Sverre Rabbelier
