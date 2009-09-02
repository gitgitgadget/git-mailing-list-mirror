From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: `Git Status`-like output for two local branches
Date: Wed, 2 Sep 2009 10:18:54 +0200
Message-ID: <fabb9a1e0909020118m2fe2e6e1g79cc83ce941ac000@mail.gmail.com>
References: <c115fd3c0908311320q46d585d2v457ccd0f411a6404@mail.gmail.com> 
	<20090902075713.GA1832@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mil3x-0002kU-MM
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 10:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZIBITO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2009 04:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbZIBITN
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 04:19:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:53033 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbZIBITN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 04:19:13 -0400
Received: by ey-out-2122.google.com with SMTP id 25so132345eya.19
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ha2VBlpEmkf0eOfo61dgnMqn2rKq3nlYfj7lCHHi54Y=;
        b=XCYieaHQciYrpUF80MongG1XEuHxU0i8yUsainAghYBWo40TIgK8IMMNzuHoF403R8
         COf5Im4IfsGGDezixHX2WfzdwiJ7dDkBVpe9+IAcGJ9EsMTZQUR8WYLEB89a4Sr48NoM
         WWIKG6FAMn/qn8Eepzd0Q8xE7RKI0YkoFg3pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HOyLIDO0Gbgp87NcponlpZnyv5ov8V/PKSSiOCvF4KcwGZcquDe4xkEutFRK/pSL2q
         oslY/S8bHElNBkOqKtilVft3DH+4cKxt0MdC0Sre2F7eSR2iZnaNeJd1nQSNB3Gp0pVg
         Aq/95KRC9+EnaLSpSdxLTrIhpPb8GgcJb2TLI=
Received: by 10.216.53.12 with SMTP id f12mr1372427wec.72.1251879554201; Wed, 
	02 Sep 2009 01:19:14 -0700 (PDT)
In-Reply-To: <20090902075713.GA1832@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127595>

Heya,

On Wed, Sep 2, 2009 at 09:57, Jeff King<peff@peff.net> wrote:
> =A02. Count the commits on each side that are not in the other.

[...]

>      You can also do that by parsing the output of:
> =A0 =A0 =A0 git rev-list --left-right $a...$b --

Perhaps it is useful to introduce a --left-right-count or such?

--=20
Cheers,

Sverre Rabbelier
