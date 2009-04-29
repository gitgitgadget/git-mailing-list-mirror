From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Wed, 29 Apr 2009 14:50:51 -0400
Message-ID: <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEs3-0000m9-KD
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbZD2Su4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbZD2Suz
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:50:55 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:62950 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZD2Suy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 14:50:54 -0400
Received: by gxk10 with SMTP id 10so2819866gxk.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sVbXLzlXVHTN7/85e65XAfmd6r7/3QD5l2mk/YMvMTM=;
        b=T1fOLZ2aSoXtztNbQVFoqYCYp2xYU+Eg3yfKvl4YdYGDRpFnMAWFyrhzlElCAcpQS9
         uUqZwvXLteEs4xYnJxQ+8ExMjQpOCoQJ29au6xPqY7jjuHiGEYPRsf7c+Phid6I7ctSF
         j3RaCWwSoNaCyforERtqTsT6YQzlGF7WgoE30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nNwh85qcuaLowal56VFJDBy3zPOqXcS7e55yfLrqhdbYer28QZvwy4jA14AxyQj0jF
         ylgmoM75WNem3+znGBIknYiyTgVSLpb+XHzoLVd63zQboXZG/UbuiUBBdV1c9caTfe20
         bQJepMs4uq3nkUhTA6guMvep5J1ZRs2jH78hk=
Received: by 10.151.122.3 with SMTP id z3mr1860712ybm.231.1241031051842; Wed, 
	29 Apr 2009 11:50:51 -0700 (PDT)
In-Reply-To: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117911>

On Wed, Apr 29, 2009 at 11:11 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Steps to repro, and error message:
>
> $ =A0git svn clone -T trunk --ignore-paths releases
> http://paintweb.googlecode.com/svn paintweb.git
> r3 =3D 30548c9192aefcde23337f70542ab59e193a1b9e (trunk)
> usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
> fatal: unable to run 'git-svn'
> $ git version
> git version 1.6.2.4.10.g2254d <=3D=3D this is maint as of right now
>
> The same problem exists with master as of right now (v1.6.3-rc3-12-gb=
79376c)

I just tried this (commit 2254d) and was unable to reproduce; it
worked fine for me (Debian etch).

  git svn clone -T trunk --ignore-paths releases
http://paintweb.googlecode.com/svn paintweb.git
  ...
  r6 =3D 8561205fe08e0bcefb592710f4e34db91f3099df (trunk)
  Checked out HEAD:
    http://paintweb.googlecode.com/svn/trunk r6

Maybe you can try 'git bisect' to narrow it down.

Have fun,

Avery
