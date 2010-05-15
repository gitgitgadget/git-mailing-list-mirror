From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add global installation target for gitweb
Date: Sat, 15 May 2010 20:43:04 +0200
Message-ID: <201005152043.05698.jnareb@gmail.com>
References: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com> <201005151449.31609.jnareb@gmail.com> <AANLkTilxlnUdfGEvpsaIKm3waSTGH_jUG9pW8ozc1PUJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 20:43:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODMKh-0005HU-8G
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 20:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab0EOSnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 14:43:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63635 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0EOSnQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 14:43:16 -0400
Received: by fxm6 with SMTP id 6so2505329fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UQ9go6H7/fL9R674GIX/E91iC9VfZSQqaKU/UPuRYxk=;
        b=n3P/GurAA9MRTJUzCvvlx63BwLUTvb3+gi4j0YuvVdxwyZQcFheER3v7JuvgdOkNHv
         U0a8pqmV7PXZfGifIQp0s3F9L1FI/UoFrZaZBlb0laMdxQ+g8427qIRyzHyqlS/2Zwg3
         JDL1TQdnUZhzLltv+QuMnThF8YhWMrja3Sm28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=saTKF/88qc6eX53UZv6OqMspaHq6ejKnwGeqzaKOsSZaVKa72YIHe7A/AN5HuBIPLd
         cW38ighksg8BnSku3ED5ohHoPfyTCENf/gbDHGNhhWcxF5WvCz4dL9tUrxo8qwkw0WzT
         WhZjbTZKzEAWPpvr2Dnk9eTIlNAbRLMSaVEig=
Received: by 10.223.19.18 with SMTP id y18mr3631838faa.6.1273948994691;
        Sat, 15 May 2010 11:43:14 -0700 (PDT)
Received: from [192.168.1.13] (absh50.neoplus.adsl.tpnet.pl [83.8.127.50])
        by mx.google.com with ESMTPS id u12sm16993927fah.16.2010.05.15.11.43.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 11:43:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilxlnUdfGEvpsaIKm3waSTGH_jUG9pW8ozc1PUJ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147158>

On Sat, 15 May 2010, Pavan Kumar Sunkara wrote:

> So, what I need to do in this patch is add default values. Not
> installing in 'install' target. ??
> Or any thing else.
> 
> If you could specify what needs to be done, I will be happy resend
> the patch. 

To get my ACK for this patch it is enough to *not* add installing gitweb
to 'install' target in main Makefile.  IMVHO it should be left for next
patch in this series.


P.S. By the way, you should write in comments to patch, i.e. between 
"---" separator and the diffstat, that this patch is based on 'next'
branch, or perhaps even that it is based on commit 152d943 in 
'jn/gitweb-install'.

>From Documentation/SubmittingChanges:

   If you are preparing a work based on "next" branch, that is fine,
   but please mark it as such.
              ^^^^^^^^^^^^^^^

Keep up good work!
-- 
Jakub Narebski
Poland
