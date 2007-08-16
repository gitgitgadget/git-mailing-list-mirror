From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Thu, 16 Aug 2007 07:55:55 -0400
Message-ID: <30e4a070708160455t78eae31cx3e6d3a7203d0b4b8@mail.gmail.com>
References: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
	 <85fy2l1i1g.fsf@lola.goethe.zz>
	 <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de>
	 <86k5rx474o.fsf@lola.quinscape.zz>
	 <20070815073811.GL27913@spearce.org>
	 <30e4a070708150542m3f3f5c62l5e4bf5b3ff098b52@mail.gmail.com>
	 <30e4a070708150548r3234cd66yd4ee6a85989a98b1@mail.gmail.com>
	 <3F9AF722-0610-4778-A244-DBE5A0918D0B@zib.de>
	 <46C39A06.7020003@gmail.com>
	 <3CDBDF39-F6FB-411D-9691-3146B882B8EC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"David Kastrup" <dak@gnu.org>,
	"Torgil Svensson" <torgil.svensson@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 16 13:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILdxJ-0000Gs-NP
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 13:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbXHPLz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 07:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbXHPLz5
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 07:55:57 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:33227 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbXHPLz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 07:55:56 -0400
Received: by nz-out-0506.google.com with SMTP id s18so77351nze
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 04:55:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IYGtgGgeLWtir/ifdPjxTzIoVau14lBVbBj6DuEYbikJLbXr1tQ7biMZC3JyXUcN0WYlhUEMyVFjv0DkdEgAWm8usD9qpHY309lSHEDC6Ebga6BcDR2ZliPGX5wVnYkuQqJYawD7P3D/EdCXzlWMHp23IgqXjg1h31cipLLZKOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bnf08N9gXdFfIIhSZO1Z05zW1+Z/rq58nUFP0E5SiAMGbAmfk0F8xc9fF2cqJ1MUjbtxOYsZCGvnxY6ZA+jbiVP7v3cKtAeGrSCuVi239cSKgpVkFrVbsdf+o6/D+93ynO2LQW6sSykolxVcm8DH8eDl1BxuHtUaR+vT8L6pDtA=
Received: by 10.142.234.12 with SMTP id g12mr82998wfh.1187265355390;
        Thu, 16 Aug 2007 04:55:55 -0700 (PDT)
Received: by 10.143.156.1 with HTTP; Thu, 16 Aug 2007 04:55:55 -0700 (PDT)
In-Reply-To: <3CDBDF39-F6FB-411D-9691-3146B882B8EC@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56008>

> Assuming that 'REG' is only available on Windows and has a defined
> meaning seems to be reasonable assumption to me. I don't see the need
> to test which platform the script is running on. Testing if 'REG' is
> available seems to be sufficient.
>
>         Steffen
>

I don't think that REG is a a name reserved for use only on Windows
that could never exist on another box. Its meaning is undefined
outside of Windows. Undefined means unreliable and therefore, not
useful as a test to decide what to do on arbitrary platforms. Also, on
Cygwin you would use regtool and parse things differently anyway,
while Cygwin users tend to be educable enough that if they want to use
kdiff or whatever, they'll symlink it or otherwise put it on their
path.

Mark
