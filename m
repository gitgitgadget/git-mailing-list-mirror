From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: git-svn and local only topic branch
Date: Thu, 3 May 2007 13:24:01 +0200
Message-ID: <8b65902a0705030424o4bd63435h143ba36ca5166902@mail.gmail.com>
References: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
	 <4638E127.4010303@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 03 13:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjZQ0-0005Wr-G6
	for gcvg-git@gmane.org; Thu, 03 May 2007 13:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXECLYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 07:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXECLYF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 07:24:05 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:6402 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbXECLYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 07:24:02 -0400
Received: by an-out-0708.google.com with SMTP id b33so449385ana
        for <git@vger.kernel.org>; Thu, 03 May 2007 04:24:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q303i03Bzn0qxGr4t86gesGko/t2U7Hg19U8rNK5pqG5esNrcUzZUklSSKYW4XgeHFfCqtPflKy/3f2Z4qEXlre6L1kBWnQQj4h61CsD9ISFxBRmH31aPcXKbjDoSaFurhiADAs9eq9aoSYVLzkRK3CDyLJFlnxVYkmpwGjSKLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IIfvkhMiR+mYOeP3F4VJK4Muy/5UE2L1epwDEEQquzQuyAQ3oKrdAWkSZ6QNw4nd0EUhKnpDKwbY0Aoh+PCS0e+RA8GswpDnNGVIYa/YLCE23KE8ZhNcAScr9KhnnHMlrlnbP76PeJ8orRRPGzhtrcAu5wtFVFsNN/sPiZwd3rM=
Received: by 10.100.108.11 with SMTP id g11mr1433297anc.1178191441437;
        Thu, 03 May 2007 04:24:01 -0700 (PDT)
Received: by 10.100.46.11 with HTTP; Thu, 3 May 2007 04:24:01 -0700 (PDT)
In-Reply-To: <4638E127.4010303@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46080>

On 5/2/07, Steven Grimm <koreth@midwinter.com> wrote:
> In his reply to my script, Junio correctly pointed out that all this
> fiddling really ought to be happening in git-svn itself; it ought to
> know that you've done a merge and should record that fact directly in
> the metadata for 4' rather than treating it as a single-parent commit.
> If you do the above a zillion times you'll end up with a huge grafts
> file which is not so clean. But as a stopgap measure, this does work
> adequately.

Yes, it's seems just fine. Thanks for the tips.

I'm not aware with the internal Git's features. As grafts seems to be
a quick hack, is it posible to imagine that, after git-svn rewrited 4
in 4', an other tool rewrites (completly) the commit to produce a 4"
with 2 parents?

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
