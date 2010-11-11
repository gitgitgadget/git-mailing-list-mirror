From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Time::HiRes is in core for Perl 5.8
Date: Thu, 11 Nov 2010 20:01:48 +0100
Message-ID: <201011112001.50202.jnareb@gmail.com>
References: <20101109182754.15256.996.stgit@localhost.localdomain> <7vwrojhjiz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 20:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcPJ-0000ll-TJ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab0KKTBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:01:55 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34247 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab0KKTBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:01:55 -0500
Received: by fxm16 with SMTP id 16so1618100fxm.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 11:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fJHMBYOLbHz5BCmpHBfjWJumlWwF1YD1nvSFEdozsBQ=;
        b=n6qC8+IPIpGvpgWhfgvbW3xG7C8oXaBQ08YD9cjbBM6PKmXoVRnqYxwASIaY8BOW/H
         j0R0mDWzG4wLlIhe34ul8YaDA4OADJdm89/pu9fxeba8A70L/9RgWI2cBb81ZIhLgSBG
         bnw7e4kfJUGY19GBafpyZuO/O9oMJhBe+fc6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ghR5MvxvEFI9GqVK83V2zPMw9S6me2zRn3yYsWoRWTh4nrPEVaaKzOBKK32HM0neYU
         tWRDWsa2sfywmmWhoD2eAt5R6IqzyPwJJS/37trNdfrHAAgcmsOW3/hf6eNkNWPa8QfA
         WlOci2wm+ilTXRZ+xBLrysbZksNkfVxjXidys=
Received: by 10.223.78.140 with SMTP id l12mr498804fak.147.1289502113717;
        Thu, 11 Nov 2010 11:01:53 -0800 (PST)
Received: from [192.168.1.13] (abvw231.neoplus.adsl.tpnet.pl [83.8.220.231])
        by mx.google.com with ESMTPS id y13sm1090583fah.26.2010.11.11.11.01.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 11:01:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrojhjiz.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161292>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Therefore there is no need to check if it is installed.  We can also
> > import gettimeofday and tv_interval.
> >
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> I think "... and 'use 5.008' is at the begining of the script already, "

because gitweb requires Perl 5.8, in order to have good Unicode support.

> is missing before that "Therefore".  But otherwise it is a reasonable
> thing to do.
> 
> Thanks.

Would you amend commit message when applying it, then?
-- 
Jakub Narebski
Poland
