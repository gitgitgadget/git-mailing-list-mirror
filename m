From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 2 Nov 2007 02:20:21 -0700
Message-ID: <985966520711020220q5d0b0481r9b95f4429f8680c6@mail.gmail.com>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
	 <7v4pg55893.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inshg-00085T-HD
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbXKBJUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbXKBJUX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:20:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:38137 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbXKBJUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:20:22 -0400
Received: by wa-out-1112.google.com with SMTP id v27so885278wah
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Qm4TXYx6aMerfRpLf8eQpu/0IfymBgMLuNVxsmXtI7U=;
        b=R5ziiVN5p8thdwLggBahLJFr8kaIoKg+oE6yl7nGmCBAhb+EbPRyeASF2NfIo2S7rmDMbjP5H5rVgHFSkM5mgo367PEsS5s4bFcdis3BifxKv0XSoHxseHMzu+C7nD6YXyCPJ3+3D435lGnQ8grZ5plerMHeKH1hsjKkPBr2WFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJI2PZMn9lOxP+bKP39tNB9ytuFNe+J37hkTPJd2HRUP7LaxyxRbX/LMkJmzUvUF03uxhdQCn4UYwm4CnHxxmqjCP2uyncU9ogBzZlAcPRCuthzxuDEe/Dass49YpQpqQZ3y6aRj10ItczLJOVgLwt8ODty4PyYVl4wws9VuS6o=
Received: by 10.114.150.1 with SMTP id x1mr1631252wad.1193995221340;
        Fri, 02 Nov 2007 02:20:21 -0700 (PDT)
Received: by 10.114.176.14 with HTTP; Fri, 2 Nov 2007 02:20:21 -0700 (PDT)
In-Reply-To: <7v4pg55893.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63081>

On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> I do not have an access to a Darwin box, but do you mean 10.5
> gives 9.0.0 as uname_R?

Yeah, apparently that's how they roll.

~/Source/OpenSource/git$ uname -r
9.0.0
~/Source/OpenSource/git$ system_profiler SPSoftwareDataType
Software:

    System Software Overview:

      System Version: Mac OS X 10.5 (9A581)
      Kernel Version: Darwin 9.0.0

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
