From: Dongsheng Song <dongsheng.song@gmail.com>
Subject: Re: gitweb.cgi bug - XML Parsing Error: not well-formed
Date: Tue, 18 Feb 2014 22:57:18 +0800
Message-ID: <CAE8XmWpvQrW0Us309teZ_E8hvJWS8ihaGhOsU94EkOjeypGzhg@mail.gmail.com>
References: <CAE8XmWp3uTW7wGrVryC6ECTkkJRcc=ruC=B6PhOURGifnh90Sw@mail.gmail.com>
 <7A867C8D-4F20-44C2-BE16-7EF81E799998@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 16:01:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFmAL-0004l8-L1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 16:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbaBRPAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 10:00:51 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:51128 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbaBRO5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 09:57:40 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so18796336obc.29
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 06:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DYCEOuMgg7wf/uoBwORp1gdVovsbCor07qvSh7pOxs4=;
        b=Kn2gvwk4krn0P3TQD9TbTVbzWOeT9N0e1PvQIn2sH0xqTXAEztMl21FESid8D+jen0
         5YowDDs9FC1QjD/jyyjeWOSpqtyyUAn256aw1iZwGV/h/XRD70k9qwf+bCdrGWYkyW46
         4YPzgPSyKVvFJOZXEtjd817WpsgBDBeN1Fa0iWhN6ciBuu0z6vgDra2+KnU50k/TTQWA
         xE/08XTsJQlK/PHZlws1gQkKQwLDSv1RfOBQbrlJhMDXI/czleUd568/BlfXLUuggLm2
         C/zBpzGeL0b113Azpm6C9fTg1ZYlb57hhd6yVd9E2fPWndbM8DJ1BhrnwM7PbYFmbMqk
         Q0LQ==
X-Received: by 10.60.34.132 with SMTP id z4mr486704oei.83.1392735458357; Tue,
 18 Feb 2014 06:57:38 -0800 (PST)
Received: by 10.182.240.16 with HTTP; Tue, 18 Feb 2014 06:57:18 -0800 (PST)
In-Reply-To: <7A867C8D-4F20-44C2-BE16-7EF81E799998@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242328>

What's your mean ?

I think I had post enough information:

When I access https://xxx.info/repo/git?p=3DDRE/Reference.git;a=3Dcommi=
tdiff;h=3Dfbd4e74c867214062ad39282a899f1d14a2e89ba

Then gitweb.cgi generate invalid XHTML:


<div class=3D"patch" id=3D"patch19">
<div class=3D"diff header">diff --git a/RFC/2010/DRE-2010-004 RFC for
Update Synchronization Program &amp; Solve the Balance Adjustment
Issue v2.doc <a class=3D"path"
href=3D"/repo/git?p=3DDRE/Reference.git;a=3Dblob;f=3DRFC/2010/DRE-2010-=
004+RFC+for+Update+Synchronization+Program+%26+Solve+the+Balance+Adjust=
ment+Issue+v2.doc;h=3D3074448e2e68235e891ebd1301e6277d993973a5;hb=3Dfbd=
4e74c867214062ad39282a899f1d14a2e89ba">b/RFC/2010/DRE-2010-004
RFC for Update Synchronization Program &amp; Solve the Balance
Adjustment Issue v2.doc</a></div>
<div class=3D"diff extended_header">
new file mode 100644<span class=3D"info"> (file)</span><br/>
index 0000000..<a class=3D"hash"
href=3D"/repo/git?p=3DDRE/Reference.git;a=3Dblob;f=3DRFC/2010/DRE-2010-=
004+RFC+for+Update+Synchronization+Program+%26+Solve+the+Balance+Adjust=
ment+Issue+v2.doc;h=3D3074448e2e68235e891ebd1301e6277d993973a5;hb=3Dfbd=
4e74c867214062ad39282a899f1d14a2e89ba">3074448</a><br/>
Binary files /dev/null and b/RFC/2010/DRE-2010-004 RFC for Update
Synchronization Program & Solve the Balance Adjustment Issue v2.doc
differ<br/>
</div>
</div>

The last 'Program & Solve' should be 'Program &amp; Solve'

Regards,
Dongsheng

On Tue, Feb 18, 2014 at 10:34 PM, Andrew Keller <andrew@kellerfarm.com>=
 wrote:
> On Feb 18, 2014, at 6:41 AM, Dongsheng Song <dongsheng.song@gmail.com=
> wrote:
>
>> Here is gitweb generated XHTML fragment:
>>
>> =E2=80=A6
>
> You're going to have to be more specific.
>
>  - Andrew
>
