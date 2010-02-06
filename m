From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: show notes in commit(diff) view
Date: Sat, 6 Feb 2010 23:17:17 +0100
Message-ID: <cb7bb73a1002061417n41213e65g6348bf4fd752f672@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002061534.02972.jnareb@gmail.com> <cb7bb73a1002060813l451ad669nf9ba2dc4643bbd58@mail.gmail.com> 
	<201002062250.43613.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 23:17:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdsyG-0006Z1-NC
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 23:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab0BFWRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 17:17:39 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:36957 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0BFWRi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 17:17:38 -0500
Received: by ewy28 with SMTP id 28so1275396ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hHyj/fWWRc0NBFp/7bg9pBZ6IOiLRhLilqhNHudYxWY=;
        b=F2j7dP0yRMjg0VQQ/Uz5qtER/vY5Q/fGOpXftnGccL6tj28O6LSWkohDS6naU0lQmF
         uXwp0vpWYlDl45regMVGNF+s2HuzU7kQwoe9arjukPqQao+eES+Hw+QbIViBm4O0nwiS
         8NJRx9ykLqHN3kKnZM1A9uSHTUJuDbV+AJ2Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HZoBqzqiVzJDfavPr8jzaZKDKaDr7OLiy+ykPKSbx0sP0HhvPiLhEULzvunlsVs/rZ
         ql3I8vZ030rQJyAA3B2Id7xV3W2y9G7clWvregcskYFaT78FK75CtnGLtMzq8PQWlDyT
         U9QiPHQvK7+NZdfqWLTwOuW2ehisshxCSuUF8=
Received: by 10.213.109.152 with SMTP id j24mr3885879ebp.25.1265494657133; 
	Sat, 06 Feb 2010 14:17:37 -0800 (PST)
In-Reply-To: <201002062250.43613.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139197>

On Sat, Feb 6, 2010 at 10:50 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> Oh, so it should be something like the following, then?
>
> =A0 sub get_note_refs {
> =A0+ =A0 =A0 # reset to default value (can be called with $/ set to "=
\0")
> =A0+ =A0 =A0 local $/ =3D "\n"; # line by line

Yes, it's probably worth to mention it in a comment.

--=20
Giuseppe "Oblomov" Bilotta
