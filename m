From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Spec file for StGIT (or equivalent)
Date: Fri, 8 Jun 2007 09:46:05 +0100
Message-ID: <b0943d9e0706080146n5f19beffi385e706f40146062@mail.gmail.com>
References: <200706080224.20493.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 10:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwa6m-0006hx-5C
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 10:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936824AbXFHIqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 04:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936873AbXFHIqJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 04:46:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:45260 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936824AbXFHIqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 04:46:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so895298ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 01:46:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d53h98qvLrFg3WL5fjk96Mdx4vXMux2Bx1C6GYZ/uob3IvOGpMXfSv86x6UkfDntwtnd3G4DtgMlx90UVSzvlf8dYKF+qhvadi0xDFUUCmTxQwZ7YBD9ajVBw6srgY5Z5n3ziJ/npoyp0l7Q+wHerNTX3mC2SUowWjfTGhsvtVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TzmmTnK2LmIlcqlRs7vcYOKjGbSZCek9liyMOIY93h2WNBWyOpIcWAXC4nd6JN7BWLZabok5VZrDlElR6iKlIkuJNu8cko/TiS8+8hHQLTFZ0xC4G2KIK4j5OcebSDT6IY16HwuIyFCRxLts3Yjv4hFmyxE6UKoFt4rEvOJWmTA=
Received: by 10.67.28.2 with SMTP id f2mr1819809ugj.1181292365602;
        Fri, 08 Jun 2007 01:46:05 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Fri, 8 Jun 2007 01:46:05 -0700 (PDT)
In-Reply-To: <200706080224.20493.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49451>

On 08/06/07, Jakub Narebski <jnareb@gmail.com> wrote:
> I can see that stgit repository contains some helper files to build deb
> package. How to build rpm package from current version of stgit?

python setup.py bdist_rpm

I have a release script that build rpm and dist, I should add it to
the contrib dir.

> Is here main version planned to be released soon?

Yes, 0.13, in about a week or as soon as I clear some of the bugs in
https://gna.org/bugs/?group=stgit.

-- 
Catalin
