From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3] git-instaweb: Add support for running gitweb via 'plackup'
Date: Tue, 25 May 2010 11:02:44 +0200
Message-ID: <201005251102.45182.jnareb@gmail.com>
References: <1274356584-2400-1-git-send-email-jnareb@gmail.com> <1274392538-29687-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 11:03:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGq2d-0006UN-1B
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab0EYJDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:03:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58401 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0EYJC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:02:56 -0400
Received: by fxm5 with SMTP id 5so3052800fxm.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MdV1BCqo2FOBIF4vhNPDo6w69G5DebTMzceGduNcusw=;
        b=HyIRgFrqUFpwPM+oGkuPYoxD6X1j/wabxGEvYwDsp0jM0Oh4qtoBGzWIWaVzKXI/pt
         yFJu4OIIRRr1m+m5MBEGj5NsPJ9rn2M3Evz4Omnys8XpTfAjzsCE+z+hpUJTakfwNBIJ
         vVRsTchm2KYvPr8SYsPbhRBJJ6zKZ7lFf8cck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uB/aHDOs5QhqvHnMHZzc+YS1jjQwaCqgypBakukaeAxmbIvW123Ou4o9mUYXQN1Z3F
         AsLXFkvowJtWYwAsWzqyWGLMzgDsyD+Hi3oNQSqc+lVZUPedPOkt10VIAFXH/T4Oswyg
         pDKQyfIZHWbNQF1FK+x8oJmlagErfekiebRO8=
Received: by 10.223.72.156 with SMTP id m28mr770642faj.26.1274778175179;
        Tue, 25 May 2010 02:02:55 -0700 (PDT)
Received: from [192.168.1.15] (abwg212.neoplus.adsl.tpnet.pl [83.8.230.212])
        by mx.google.com with ESMTPS id y12sm23852466faj.5.2010.05.25.02.02.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 02:02:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1274392538-29687-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147689>

On Thu, 20 May 2010, Jakub Narebski wrote:
> ---
> This is an RFC because it should be split into three patches:
> * a patch which makes git-instaweb remove pid-file after stopping server,
> * a patch adding and using httpd_is_ready function,
> * finally, a patch adding support for 'plackup' Perl web server.

I'll wait with resending it as a patch series for Pavan work on
git-instaweb to be in, to not force him to do additional work on
the new 'plackup'-related code in git-instaweb.

> 
> Also, it somwehat lacks documentation.

Hmmm... where should the documentation about requirements etc.
of specific supported by git-instaweb web servers be added?

-- 
Jakub Narebski
Poland
