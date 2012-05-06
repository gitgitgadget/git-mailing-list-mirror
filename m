From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Index format v5
Date: Sun, 6 May 2012 12:49:27 -0400
Message-ID: <CABURp0rAjrhVACQEafrZRxtXBAmajpEqfp+EmB7s595dobqHQQ@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 18:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR4ef-00065E-VL
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 18:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab2EFQts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 12:49:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61005 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab2EFQts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 12:49:48 -0400
Received: by yenm10 with SMTP id m10so3216320yen.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ANXAzMLF581TS9pEvfhfnQ6wVhchuRlK3FlBrr9MC1o=;
        b=aEdmz3f1Fty9ZHTtE6blJwBos2QwHODdJmtqEHezlIgzoNMX9j+VPlP+0cBLKJVM8I
         1tM0HVcUYzgXGJVECyjjs32YVHN1aEH/3Af0BJvhKPupPpRgB7VmpR4ugIYhI6h0CP/i
         kCq9CkKm25NvymNNvdxITaRbWZsA3Pv4Xov01iDIittJ9pIpSF4hhGZujpDsoOP9V6vC
         cNaqoqS1969puPkBcB13jCahm7E1GQlkAajmzqnaRs0Q3DqYkdDrLjD6VO5KrnFH6vLg
         oxGVnqaIeCRwEk0/TGVtE9D2Y4oIjjlPVBR5JCkyb2fwwch5K27IOCtX37oOcTL1Wkcd
         FvQg==
Received: by 10.236.125.168 with SMTP id z28mr16022558yhh.120.1336322987735;
 Sun, 06 May 2012 09:49:47 -0700 (PDT)
Received: by 10.146.122.15 with HTTP; Sun, 6 May 2012 09:49:27 -0700 (PDT)
In-Reply-To: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197202>

On Thu, May 3, 2012 at 1:25 PM, Thomas Gummerer <t.gummerer@gmail.com> =
wrote:
> I have been drafting the Version 5 of the index format over the past
> few days with the help of Thomas Rast, Michael Haggerty, cmn and
> barrbrain on IRC. It will save with prefix compression on the path, a=
nd
> using a crc32 over the stat data, instead of the full data, since it =
is only
> used for checking if the file is changed. (Thanks Michael Haggerty fo=
r
> this hint. Unless we are missing something this will save another
> ~4 MB on the Webkit index.

=2E..

> =3D=3D Directory entry
>
> =A0Directory entries are sorted in lexicographic order by the name
> =A0of their path starting with the root.
>
> =A0Path names (variable length) relative to top level directory (with=
out the
> =A0 =A0leading slash). '/' is used as path separator. '.' indicates t=
he root
> =A0 =A0directory. The special patch components ".." and ".git" (witho=
ut quotes)
> =A0 =A0are disallowed. Trailing slash is also disallowed.

typo: The special _path_ components ".." and ".git" ...
