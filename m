From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Using filter-branch to move repo contents in subdirectory
Date: Wed, 11 Aug 2010 10:01:15 -0500
Message-ID: <AANLkTimu+V8zJeBV65nhqw0zaQHVHzZZahw2q-20SaWO@mail.gmail.com>
References: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com> 
	<AANLkTi=TeJvF+swpMWddDtA7jh4XWedQ+FjigEdRYkx_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:01:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCoN-00038H-T5
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab0HKPBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 11:01:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64103 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab0HKPBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 11:01:41 -0400
Received: by fxm13 with SMTP id 13so165093fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=vudmshNowmd37D+XCm2leXcflRGdWE8CfMRLOnBNlwk=;
        b=eN1Aq669o+3awVH29lAvDr0JuWKa69ksuZ8twNwDiSFoniymM/m0dMOilDut0Kwc+l
         s6KuA6Da5mWVtLklrY8gr2mRGilceFbdundUZOQxUjT2r16forf9PP8lTz1UV6jDlkvq
         W5pGMxrDd0H+QK0NBNH3XFokELKZNiqEZEnLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=WuZvrXgG1WTiBKutOUYE3e+R9ipLEstxE3qdJf7C/S96kwgiKxH5yXKyJ9vfKG/A5+
         5AURdXzYTmM3FCROCUsNV7uRDcA20+WvCyuy9JpWJ9V3SXlQfm1NkZYbNatp8v7vfNmN
         WRuvtH6Y452enyPoH+p6qjqmWcMhUo1RNwB0o=
Received: by 10.239.187.137 with SMTP id l9mr912046hbh.205.1281538899782; Wed, 
	11 Aug 2010 08:01:39 -0700 (PDT)
Received: by 10.239.183.74 with HTTP; Wed, 11 Aug 2010 08:01:15 -0700 (PDT)
In-Reply-To: <AANLkTi=TeJvF+swpMWddDtA7jh4XWedQ+FjigEdRYkx_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153238>

On Mon, Aug 9, 2010 at 14:36, Adam Mercer <ramercer@gmail.com> wrote:

> I'm trying to do this with another repo now and am getting a differen=
t
> error message:
>
> $ git filter-branch --index-filter \
> =A0 =A0'git ls-files -s | gsed "s-\t\"*-&sftlib/-" |
> =A0 =A0 =A0 =A0GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
> =A0 =A0 =A0 =A0 =A0 =A0git update-index --index-info &&
> =A0 =A0mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
> Rewrite b3100fb24a7eb2f349801f3b87cf995dc3d14bba (1/44)mv:
> /Users/ram/git/eah2/.git-rewrite/t/../index.new: No such file or
> directory
> index filter failed: git ls-files -s | gsed "s-\t\"*-&sftlib/-" |
> GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new git update-index --index-info &&=
 mv
> $GIT_INDEX_FILE.new $GIT_INDEX_FILE
> $
>
> Any ideas?
>
> This is on Mac OS X 10.6.4, with git-1.7.2.1, and GNU sed 4.2.1

Anyone?

Cheers

Adam
