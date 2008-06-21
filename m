From: David <wizzardx@gmail.com>
Subject: Re: avoiding committing personal cruft
Date: Sat, 21 Jun 2008 17:53:13 +0200
Message-ID: <18c1e6480806210853k72274173gaaeb11dd7991c8ed@mail.gmail.com>
References: <e5e204700806210620m35fce27eh8eddaf7cb68f1986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 17:54:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA5Pl-0007O6-KS
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 17:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbYFUPxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 11:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYFUPxO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 11:53:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:13572 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYFUPxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 11:53:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6155678rvb.1
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cXCiVxe4WbSt7cywgbk/pdQU8rEcUCZaAoFh0FB06nE=;
        b=ppCQNmrhPV5ngbDqaGlQvyUhQ5sO/XPI8eayJtutpniCGk7jY5vk7a2bC2ObZvmYvD
         MmQdEGcrc39QdRpDWeppZw55fMos/oKPK8aXoSLSNcaKGVcGg0XtuwftBxgNzvIy6Ply
         qJYxfnPTJq0njVkDI1DtyFyyRsXBXcZhEwJ90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jWPaV9/U0B8HPVXsaKq1+YWRlPx2St4bhqcN8GvDWwN6ulxXSDxtM+/RifQBuG3IJl
         FZ6Yh14PSaVOucTZcXFIBIBR+gEwErAzh890xZtn3vPDPN83veFVHlqocv5wunMziLit
         BsWEnBfVLaWufXQTOvt8lxPAkSJeWxfcw3Js8=
Received: by 10.141.210.21 with SMTP id m21mr9557528rvq.23.1214063593153;
        Sat, 21 Jun 2008 08:53:13 -0700 (PDT)
Received: by 10.140.132.18 with HTTP; Sat, 21 Jun 2008 08:53:13 -0700 (PDT)
In-Reply-To: <e5e204700806210620m35fce27eh8eddaf7cb68f1986@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85711>

On Sat, Jun 21, 2008 at 3:20 PM, James Sadler <freshtonic@gmail.com> wrote:
>
> The ide-branch has nothing in it except the cruft from the IDE and the
> paths leading up to that cruft.
> The master branch has a .gitignore that ignores the IDE files so I
> won't end up polluting master by accident.
>
> It's a manageable solution for now.  I tend to think of it
> conceptually as 'layering' two branches: I want the
> content of both present in the working tree.
>
> I was just wondering if anyone else has tried something similar.
>

Sounds like a normal use of topic branches. Branches rebased against
master, where you you keep changes you don't want to go into the main
branch at this time.

David.
