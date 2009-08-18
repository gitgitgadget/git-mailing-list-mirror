From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 01/11] Fix build failure at VC because function declare 
	use old style at regex.c
Date: Tue, 18 Aug 2009 23:03:54 +0800
Message-ID: <1976ea660908180803x416d64a9x87465d1c7e87980e@mail.gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171822130.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kusmabite@gmail.com, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 17:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdQEF-0005zj-0E
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 17:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193AbZHRPDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 11:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758943AbZHRPDy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 11:03:54 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:46506 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758687AbZHRPDx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 11:03:53 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1243804qwh.37
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wW/WyArGUNnlJVwrDtlL8v3kIP5TI7Pn2I/GGX7rNzM=;
        b=p679cSthbXCVhdNA30sSiVNez7gVU4XuSwd/fHcH1/2a/UgKNCHb6ndZ90LHzr6WMx
         hVozgGvYW7NBP0XqRaEnskG1hLDs805cBaMwo23heL+ZpyEKM62KHs81UDITBlDKBE0q
         RpEFWikMTQfHoiuhnupfFzg6wfzPyL9etn+o0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R9B/rIIIS+pK+QiO8zAY1lRg6GTCH1bMeUd0e8vT4ELnVOTrgAgp/meL00OuSVGI9Q
         D24s9jIN7A8ex2ZjcxNeUxkNiTH1/pMyXVsVKlVXqnKd8S4FSffU9PYyqy+yP+ZQk6u/
         Y0wjVHpZRxdzurDaCVox7pzy+CgOZbLr+eoiI=
Received: by 10.224.93.16 with SMTP id t16mr5517653qam.250.1250607834681; Tue, 
	18 Aug 2009 08:03:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171822130.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126401>

 - there are a lot more functions with K&R style function definitions t=
han
> =A0just regerror().
>

I double check it. VC can compile K&R style function. This patch is red=
undancy
