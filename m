From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb $export_ok question
Date: Tue, 30 Dec 2008 15:02:37 -0800 (PST)
Message-ID: <m3ocytb6ze.fsf@localhost.localdomain>
References: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu>
	<m3sko5b84t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Amsler <tpamsler@ucdavis.edu>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:04:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnd5-0001K2-4P
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYL3XCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYL3XCl
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:02:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:33889 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbYL3XCk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:02:40 -0500
Received: by nf-out-0910.google.com with SMTP id d3so669153nfc.21
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 15:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=k50z0zaIEB/LtmC04fi+T7SM38ovng6GXA9nvHKtI0w=;
        b=FXrROty7IxGvUca6KGFEXLu/qozsCbcjWR0EnKq05VnTBvhRokOIefaFPPY/C8bzBg
         xzWXbVeNCcIqlFJjIi5LoBZnAX+F1cZDeigmoGWYXg4yXn11IgNOEBrsnnqoEEddjswN
         19FtIlRoFwKaunHKxx6i5k7606ejBbF1voyOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=D0ex49HWGB1rr6z57JLD+cNukfHijfx2V/2rd0MJn07pKu4RqkvEgijE2OL80FVUyy
         kCH3g8UKSvMJmXcj0kK8EPRGUiqXD/8XuRsL/OCDV9rj4OBMqwoM9TDuhbv5dpCqFuaT
         S0KKO44fUpG9welzcVCNk+JH/CtLXY7AlOXAo=
Received: by 10.210.45.17 with SMTP id s17mr17971754ebs.69.1230678158601;
        Tue, 30 Dec 2008 15:02:38 -0800 (PST)
Received: from localhost.localdomain (abwv44.neoplus.adsl.tpnet.pl [83.8.245.44])
        by mx.google.com with ESMTPS id 5sm2446823eyh.18.2008.12.30.15.02.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Dec 2008 15:02:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBUN47NH028504;
	Wed, 31 Dec 2008 00:04:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBUN45w1028501;
	Wed, 31 Dec 2008 00:04:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3sko5b84t.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104221>

Jakub Narebski <jnareb@gmail.com> writes:

> in the GITWEB_CONFIG file (usually gitweb_config.perl, installed
> in the same place as gitweb.cgi) [...]

I'm sorry, I forgot about GITWEB_CONFIG_SYSTEM which as you
wrote is by default /etc/gitweb.conf (and is also Perl).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
