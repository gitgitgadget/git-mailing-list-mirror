From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepan.nemec@gmail.com>
Subject: Re: [PATCH 2/6] Fix odd markup in --diff-filter documentation
Date: Fri, 08 Oct 2010 20:40:32 +0200
Message-ID: <877hhsttnj.fsf@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
	<1286559080-27257-3-git-send-email-stepnem@gmail.com>
	<20101008173941.GA13738@burratino> <87bp74tvno.fsf@gmail.com>
	<20101008180327.GA13910@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 20:41:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Ht5-0005EZ-Kj
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759369Ab0JHSlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 14:41:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62744 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab0JHSlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 14:41:36 -0400
Received: by bwz15 with SMTP id 15so499446bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=j2/3McA0AlIj8UUrx0F/P+GKkcjSuigb8oGe4iyQWMc=;
        b=Xn8kkp6Vje3kNl/cGJA39zBl7Gp8iD8FF9DY7zOjzGgV8wlT9G8wQIuXgehncpqBWR
         9kAQC9voDsIRY1yWTnmGbe46+lnbeHUiXOgYEbX9fc2bbza7OMoJpx0zKLsdH6l1YRBU
         PLYhB5dbxQ3dCrb/tB/BmhEXLbuQgosJZgwQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=c1lMVqycw0xN/9f0UVhV2QIzLKU47wmYLf0WMIKEgq2MmWp+7lr7G4NtQKYsMOHHjR
         DC5wkZPxGc+pV4v4dNkgnUm5vrtDI3XTj/7iYWae2AI9IefQqAA9XojwhJGxhnQRDh5G
         yuibBTcE7FJgtFCNGd8YZl0GfYUKNMXd1qRgw=
Received: by 10.204.77.137 with SMTP id g9mr2225488bkk.189.1286563295412;
        Fri, 08 Oct 2010 11:41:35 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id 11sm2881976bkj.11.2010.10.08.11.41.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 11:41:34 -0700 (PDT)
In-Reply-To: <20101008180327.GA13910@burratino> (Jonathan Nieder's message of
	"Fri, 8 Oct 2010 13:03:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158524>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Strictly speaking, --diff-filter=3D (with empty argument) is allowe=
d, too,
>>> but I don't know if it's worth fitting that in.
>>
>> If it provides some kind of useful behaviour (I don't know and you
>> didn't clarify that either), then it should be documented I guess?
>
> Just a special case of the usual behavior: it selects the empty set o=
f
> files.  Doesn't sound useful to me, but maybe someone writing a
> front-end would want to be reassured that --diff-filter will still
> work if the user unchecks all the boxes.
>
> Of course, one can also just try it...
>
> If you can find a way to format it nicely (using brackets?), then I
> think it should be part of the documented syntax, yes.

Well, in that case simply replacing parens with brackets would do, i.e.

--diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]

instead of=20

--diff-filter=3D((A|C|D|M|R|T|U|X|B)...[*])

That would mean the following instead of the original [2/6]:

--- 8< ---
Subject: Fix odd markup in --diff-filter documentation

Instead of using the regex-like bracket expression, use grouping to mak=
e
it more consistent with other similar places. The brackets now have the
same meaning as in other documentation (i.e., the argument is optional)=
=2E

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/diff-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index cbf3c92..e954af0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -248,13 +248,13 @@ endif::git-log[]
        If `n` is specified, it has the same meaning as for `-M<n>`.

 ifndef::git-format-patch[]
---diff-filter=3D[ACDMRTUXB*]::
+--diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]::
        Select only files that are Added (`A`), Copied (`C`),
        Deleted (`D`), Modified (`M`), Renamed (`R`), have their
        type (i.e. regular file, symlink, submodule, ...) changed (`T`)=
,
        are Unmerged (`U`), are
        Unknown (`X`), or have had their pairing Broken (`B`).
-       Any combination of the filter characters may be used.
+       Any combination of the filter characters (including none) can b=
e used.
        When `*` (All-or-none) is added to the combination, all
        paths are selected if there is any file that matches
        other criteria in the comparison; if there is no file
--
