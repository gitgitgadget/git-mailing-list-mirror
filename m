From: Deskin Miller <deskinm@umich.edu>
Subject: Re: Problems Cloning an SVN repo.
Date: Tue, 9 Dec 2008 13:12:17 -0500
Message-ID: <20081209181217.GA13231@euler>
References: <c115fd3c0812090954n6e5e527anadf04936e1ca01f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA7AX-0004wL-LG
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 19:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbYLISRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 13:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbYLISRb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 13:17:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:38914 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbYLISRa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 13:17:30 -0500
Received: by nf-out-0910.google.com with SMTP id d3so25909nfc.21
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=et4XezmEj5dCehL3w8tITdrFxM4lud2eTnzvZOz9LUc=;
        b=gRi+d2+t3ft8dUulmfY2i0Qc6EA/VEyNjquFTtt2h24idVzmyovQPy0MX8y6cGqX5y
         SAORA0ohSOjZP7ur0S5RozM70X2YIUQWu7ZtvRi8251jg/mxRAaCL2r02JK8LHPHNpKa
         XGOu7UQ8Tvcxxd6zNIgO0AgCqG/htRmF99TC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rQhuZjrdVgTbFE4Bn7l42rg8kB8UFf4e8N9HeSfPigPVEE5Ja4Ze5vLWXKk0h+VShy
         U0DSlgDXWeMTpWc3T23kisLHpLh6EssBXMOAtFltwTxAFcnik4akSWxFe4sx9RHqh8+Q
         fIH5gS/f22szQSpQPuvCXcZA6PVfbaYpw3Zzw=
Received: by 10.210.46.14 with SMTP id t14mr501918ebt.39.1228846346572;
        Tue, 09 Dec 2008 10:12:26 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id 10sm61434eyd.53.2008.12.09.10.12.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Dec 2008 10:12:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c115fd3c0812090954n6e5e527anadf04936e1ca01f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102645>

On Tue, Dec 09, 2008 at 12:54:20PM -0500, Tim Visher wrote:
>     Can't locate SVN/Core.pm in @INC (@INC contains:

This is perl's way of saying "you don't have the SVN perl bindings in
some place I can find them".  I've not used git-svn under cygwin and
lack a windows computer to test, but on debian the SVN perl bindings are
in packages called libsvn-perl or libsvn-core-perl; I'd look for
similarly-named packages in cygwin's installer, or alternately packages
related to SVN.  If you're sure that the bindings are already installed,
you can fiddle with perl's module search path to detect them in an
unusual location: look at the -I flag to perl.

If that doesn't work, you can try building svn from source under cygwin,
and installing the perl bindings that way.

Hope that helps,
Deskin Miller
