From: Russell <russellsteicke@gmail.com>
Subject: Re: v1.5.4 plans
Date: Tue, 4 Dec 2007 09:48:04 +0900
Message-ID: <c1b8b6670712031648q4c6ed92cx4295042d2a80bf18@mail.gmail.com>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 01:48:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzLxf-0006Ur-HU
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 01:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbXLDAsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXLDAsH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 19:48:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:33998 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbXLDAsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 19:48:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5653924wah
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 16:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KGckCajDmU/aix5RTFZrfhhPkQFpsXFROy/i+NQPi3Y=;
        b=oUuEb4kjPHRzmNtMPvdoOkJRIZ1NAiigqvYAkEpsqVX8kkhu5QahfgD+a27KkLSoubN0eckkJif3SWM2d2BlmuSOekORiC3X4KlrK1ENzB4jBS7ky2Cpal5QnTlfALRCCuo7PF+sIytOVDahU/4B7CIe/YAmQINc8cuEleM3BZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q5RC5keB7qn9CnQ/dX1y2WbbdVnXKabEst9zJE3WWg+GiZHf+d4SSNw3CjAq4LpCFPjAbTFk8NWH0fkps4FDNz364CXlyIXVXNnz8NXhzMoslgeoIJvMPWv9AihRmfLdCKgK87a/01K7xEuk5Bkzx0bwH1YA+8MKcdAqOqs7k8I=
Received: by 10.115.106.7 with SMTP id i7mr43554wam.1196729284352;
        Mon, 03 Dec 2007 16:48:04 -0800 (PST)
Received: by 10.115.78.5 with HTTP; Mon, 3 Dec 2007 16:48:04 -0800 (PST)
In-Reply-To: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66982>

On Dec 3, 2007 7:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * We have already removed svnimport without giving a deprecation notice
>    in the release notes of the previous feature release, which was bad.
>    Maybe the users will forgive us.  Maybe not.

Ah, that explains that.  I was in the middle of importing the open2x
project into a git repo.  It's a large tree which looks like it
includes several copies of linux 2.4, and importing is taking several
days.  Occasionally the svn connection times out or something, and I
just restart it and it continues.  In the middle of that I built and
installed git 1.5.3.7 and was surprised when git-svnimport wasn't
there the next time I tried to restart it.  Back to 1.5.3.6 for now.

I see there's a thread about using a git-svnimport tree with git-svn,
so I'll do that.

Oh, and you're forgiven.  :)



-- 
Virus found in this message.
