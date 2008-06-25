From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 17:14:39 +0100
Message-ID: <3f4fd2640806250914v7b0ee72aw65f5dfe72790ce3c@mail.gmail.com>
References: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:15:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXf2-00043U-Dz
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbYFYQOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbYFYQOn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:14:43 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:58373 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYFYQOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:14:42 -0400
Received: by rn-out-0910.google.com with SMTP id k40so763058rnd.17
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fYmgVahuoWFP++/nU8/jwDX4J0/WppuYbHsY8IP7Yjk=;
        b=mH6FmYQHFtYTdJabyIHD3pZgLcmwq5cFRbetfPa8SwJV2+MTGanXI9K4VQeEcePNpP
         cn4wa8O32I9I1M0FKpofzkn2T+RS4QVWvtT1vwPMfHpPa+ozULF0flWz6gy7VPZ+GVNt
         hJo23aipl55ehVI1PtFxCy31DJhH9T6BmoxFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jxsH9nyKlmht28hU1QD47xys3Rb+zoNC4TKGEI+UN3J4fwWF31vIQW1q2rIQke6CzQ
         jEEAwdQOGyd7zwuL+zEjYAzt3vhd0SsVQEaQp7UQbeqsXVixNQaKgSWHPcUk2ZuPkdud
         Yr7oAKLDIJHeM5yBT9fIR2cskLQ9W8uQ3nfaU=
Received: by 10.142.171.6 with SMTP id t6mr6006858wfe.229.1214410479363;
        Wed, 25 Jun 2008 09:14:39 -0700 (PDT)
Received: by 10.142.164.3 with HTTP; Wed, 25 Jun 2008 09:14:39 -0700 (PDT)
In-Reply-To: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86296>

2008/6/25 Rhodes, Kate <masukomi@gmail.com>:
> I know ls-files is the tool I need but I haven't been able to figure out
> what combination of options will give me the files that have been added to
> the index.
>
> -Kate

`git status` will do this, unless you need to do additional processing
on the results.

HTH,
- Reece
