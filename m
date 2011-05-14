From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #06; Fri, 13)
Date: Sat, 14 May 2011 10:03:30 +0700
Message-ID: <BANLkTimHdZ_9PUg509Yb7g2Oyp3qk0cKdA@mail.gmail.com>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, joey@kitenet.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 05:04:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QL59F-0005YR-6B
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 05:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392Ab1ENDED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 23:04:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34088 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573Ab1ENDEB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2011 23:04:01 -0400
Received: by bwz15 with SMTP id 15so2551727bwz.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=sPdCzxRLw20D9ZV04zrO1BjxThttrm9moXB6iVHokc8=;
        b=dc7z7eKt+a3qPHxB6FJgLjh9CXruNMi0e90wIMnL7yUJ1JZXjHD1m/DuLyXZdk1+lY
         rHUmPES3VVRe48/i9sExbAPjOLMidFbzkdQn/92UqeWZAU/bNNXAxf9RpEbelmNDjvg7
         fh+lzaogpyAn6NOqgNdlC5yC++62pfhuXux8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gW0rj/gdws6roUD+82KBJIaXml/h6FBg7a5pPNbfIt8ymgbbSEC6HMx3KlQLn0TNYD
         C28Q76v3KLxWa24fMgjhkKJdhKIIReDU1DhhOgXFoyjPbDxCCSzaND4F9rQqfw3p7O4N
         MlyXSq5H2L1AF3Red34xfGvIUugyTefk1QORI=
Received: by 10.204.32.146 with SMTP id c18mr904166bkd.182.1305342240168; Fri,
 13 May 2011 20:04:00 -0700 (PDT)
Received: by 10.204.177.147 with HTTP; Fri, 13 May 2011 20:03:30 -0700 (PDT)
In-Reply-To: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173573>

On Sat, May 14, 2011 at 3:03 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * jc/streaming (2011-05-12) 5 commits
> =C2=A0- write_entry(): use streaming API for writing working tree fil=
es
> =C2=A0- stream: a streaming interface to read from the object store
> =C2=A0- sha1_object_info_extended(): expose a bit more information fr=
om object-info
> =C2=A0- write_entry(): separate two helper functions out
> =C2=A0- packed_object_info_detail(): do not return a string
> =C2=A0(this branch uses jc/convert.)
>
> The counterpart to jc/bigfile to cover the write-out codepath. This d=
oes
> not yet have "read directly from pack or loose object without slurpin=
g the
> whole thing in memory" yet, which is still work in progress.

You haven't sent this to git@vger, or it failed to deliver to me.

Anyway, do you plan to extend sha1_object_info_extended() further, to
support external storage too (git-annex way for example)?
--=20
Duy
