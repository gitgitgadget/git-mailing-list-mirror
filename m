From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sat, 19 Mar 2011 19:18:52 +0700
Message-ID: <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 13:19:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0v86-0004RU-EX
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 13:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab1CSMTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 08:19:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48813 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab1CSMTX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 08:19:23 -0400
Received: by wya21 with SMTP id 21so4583536wya.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=pf3eeYGQ4ZIYFAeSLZ7gOOqi+vP7/XrSZp2RQVbZ9po=;
        b=RWTTy5u5SgqFdS8BgNk/5gQ5VMCAI+fD6S7yi4v14VBFkKSlahOF0sc+TK/7jjxwMS
         I2WKNKWt1Vbkvy7DBB0COi6bszjj17TIzBdqPGErMMfMISS00obcR4ZekFVba+JF/ZUR
         xBLC1gUisQktiHQ1csiQlSy+CV1JkqYZCEt6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tE5sW1oD8HNf20TzSEg3EQQfvf1UcFtNX3AU3VkXF0PmaVVTFizrdPzzXz3CgDSmX8
         ZdYuGewp7tRsDDk2jYtuc8jK0RC9QLgTusuk0JXtv0rhVFsrezIKcU8LC5mnNHLP0/Xp
         hs9BFPOQqKQMRRVUR6WGRtJx0swTBg9/n7cqw=
Received: by 10.216.120.129 with SMTP id p1mr2283762weh.81.1300537162150; Sat,
 19 Mar 2011 05:19:22 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Sat, 19 Mar 2011 05:18:52 -0700 (PDT)
In-Reply-To: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169427>

On Sat, Mar 19, 2011 at 7:08 PM, ryenus =E2=97=87 <ryenus@gmail.com> wr=
ote:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for e in `cd "$PAC=
KDIR" && find . -type f -name '*.pack' \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for e in `cd "$PAC=
KDIR" && /usr/bin/find . -type f

I'd rather have something like in test-lib.sh (with conditions)

find() {
/usr/bin/find "$@"
}

Even better, rewrite this script to C.
--=20
Duy
