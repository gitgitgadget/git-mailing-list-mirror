From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: .git/index
Date: Wed, 25 Mar 2009 14:03:43 -0400
Message-ID: <9e4733910903251103m7c78b2e7lee21a25a140bbeca@mail.gmail.com>
References: <9e4733910903251016n117c37fdp94f91b2862cd7bf@mail.gmail.com>
	 <alpine.LNX.2.00.0903251749270.11062@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXUB-0002oK-59
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758459AbZCYSDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757829AbZCYSDr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:03:47 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:37323 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746AbZCYSDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 14:03:46 -0400
Received: by qyk16 with SMTP id 16so324156qyk.33
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U15wKYUYsnlZnyjKq7UVBA+v8fY3Dbcw+1Ghhdlmvns=;
        b=CHTtN/wAEbrEgmoPVLywvGC1p1sk94l4SwEBcB9760tCCeaMQk5G26ifgMQrjHnF17
         E/V22Jmx/wC2h1PZGnT4rzKy/lFdAvQxhnEyz5Tw36a1IQDgphklY9Kw068TM2JeNGlZ
         K2XWC2BP7QitzNCHGbuNvcPXCzMGBL337AZLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SJYvjUhQY05TL5Vrh18yiAZHxiGB4Q9RU/2JVjau8pKPwzvju+Kq/VG2Ud4N/FYlN1
         /aQuW+uMLZ5N4SNXqhS1Gkd1HAFTJ84FAottNhm1mkbOp8VhOsMjBZHpHPEH0eK7czjT
         NtvEIFwusW3n1xQHGurzqIfZ+5SZ28jyIt++s=
Received: by 10.220.45.135 with SMTP id e7mr3205537vcf.7.1238004223486; Wed, 
	25 Mar 2009 11:03:43 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0903251749270.11062@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114633>

On Wed, Mar 25, 2009 at 1:52 PM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> On Wed, 25 Mar 2009, Jon Smirl wrote:
>
>> I pushed a repo up to my server. I want to view this repo with gitwe=
b
>> but it is not visible in my project list like my other projects. I
>> suspect this is because the newly pushed repo is missing .git/index.=
 I
>> ran update-server-info on the repo and that didn't create .git/index=
=2E
>> What command builds this index?
>
> .git/index is the default name used for what is commonly referred to =
as the
> staging area these days. =A0It's only needed when you have a work tre=
e, and is
> expected to be absent from a bare repository.
>
> A more likely cause for a repository to not be picked up by gitweb is=
 file
> permissions.

It needed to be added to the gitweb projects file.

>
> --
> Julian
>
> =A0---
> <MFGolfBal> rit/ara: =A0There's something really demented about UNIX
> =A0 =A0 =A0 =A0 =A0 =A0underwear...
>



--=20
Jon Smirl
jonsmirl@gmail.com
