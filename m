From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Tue, 1 Jun 2010 18:25:33 +0200
Message-ID: <AANLkTimenYsHEhTO3wqW_BRMMKZbA6ExLOOytaopGLjh@mail.gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	<4BF7B751.7050704@pileofstuff.org>
	<4BFB7F7F.5090407@drmicha.warpmail.net>
	<4C041656.7000008@pileofstuff.org>
	<AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 18:25:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJUHj-0001UJ-N8
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 18:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab0FAQZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 12:25:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34268 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab0FAQZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 12:25:41 -0400
Received: by wyi11 with SMTP id 11so1131222wyi.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=o8spygZ+7Eg3guwi7xWjjFeYmRcEzTda6ZqrM+lRdeA=;
        b=Ma7/eeCxty7rnFCKkH64W5063cv6d2pWRT7+LOvpGrQGaWP2kL3OhdI3AZmhwkhe2a
         VwVk/ogmixas7aqo26z7dslIfgEtZiUWDgbKQhrSlkUaHwLWNOgcGBbpCon4POJeOTV3
         y5RNwoRPgiS95tbr0uZSlQsJIcsPg/X/Ri8AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=YUGivs4mx+hm6W9NgVYHC717s5IlpdxBOkmk7eGKh7Hu2SPLK+hNkTXByoWwYjzFdg
         EDuVZc3BYG4lCjfvCs11Gcs3FY5A+uVA+iueI7tXE94e64aGGRQzx7Yoi8RYyy5dtHds
         sxQ7/h3fzj/9XPJOTjyPFZbIygsR6Yvbxw8Lw=
Received: by 10.216.164.20 with SMTP id b20mr5580240wel.101.1275409533486; 
	Tue, 01 Jun 2010 09:25:33 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Tue, 1 Jun 2010 09:25:33 -0700 (PDT)
In-Reply-To: <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148137>

On Tue, Jun 1, 2010 at 6:00 PM, Daniele Segato <daniele.bilug@gmail.com=
> wrote:
> On Mon, May 31, 2010 at 10:04 PM, Andrew Sayers
> <andrew-git@pileofstuff.org> wrote:
>> On 25/05/10 08:42, Michael J Gruber wrote:
>>>
>>> Feel free to contribute to the Git Wiki maybe at
>>>
>>> https://git.wiki.kernel.org/index.php/GitDocumentation
>>>
>>> in the "User contributed Documentation" section.
>>>
>>> Michael
>>>
>>
>> Thanks for the hint - this turned into rather more than just uploadi=
ng a
>> PDF, and I've now finished a complete write-up here:
>>
>> =A0 =A0 =A0 =A0https://git.wiki.kernel.org/index.php/SvnMigration
>
>
> That's a great job!
>
> I want to point out some difficulties I encountered switching from
> Subversion to Git-SVN.
> I'd like to discuss them here before, eventually, contributing them t=
o
> that page.
>
>
> =3D Empty directories =3D
> Git do not track directories, it tracks content. That means you'll no=
t
> get/commit empty directory in your
> working tree.
> Sometimes empty directory may be needed by some fancy script or
> external software you use with your
> project (example, ANT).
>
> Developers should be aware of this: if they really need to create an
> empty directory they can both
> create it through subversion both create a "dummy" file in the
> directory and commit it, if that's an option.
>

This has been solved in recent versions of git: git-svn creates the
empty directories when you check out. It might not be 100% robust (I'm
not saying it isn't robust, I'm saying I don't know if it is), but it
works for my setup.

> You also can't create new Subversion branches or tags with git-svn,
> you'll had to use subversion directly for that.
>

Incorrect. git-svn have sub-commands called 'branch' and 'tag' for this=
 purpose.

--=20
Erik "kusma" Faye-Lund
