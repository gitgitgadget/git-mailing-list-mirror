From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 3/3] gitweb: add test cases for snapshot settings
Date: Mon, 24 Aug 2009 14:36:12 +0200
Message-ID: <200908241436.13626.jnareb@gmail.com>
References: <4A91BA53.1040800@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Aug 24 14:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfYmn-0003zr-KM
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 14:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZHXMgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 08:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbZHXMgW
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 08:36:22 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53046 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbZHXMgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 08:36:20 -0400
Received: by bwz19 with SMTP id 19so1420056bwz.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qqy6q63I0KoOj8YniC52SVsZYwHeXKYW6SvpOuavddw=;
        b=ql/an+8vfL6LAYgGKwS/h+ku4w8xzcIB7WFx24ayZZaGdNe3yazfgmbrFweLBLmSsT
         9aFOXkXdghn6OIzP+NUM9+hkycWdK/9zZWZdaNncyQBokFrNuO3mcYxFc6jbrF8wkKZu
         7bRk90gcLfNhdGpMJRaGrHyTZiFHVAQ91G+YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bZKMamLYJ0fhkNM1/O+pcbwOmm1yvGWZ+AvPnmmRB6PJt3+N4EVat9Cs028Ourg6vI
         zxIFXhZunk4MMmwHSfzdh4TuxsKb8LhdhBnQ78FdMcSIcA6CsOjR2IP7miLxrylAIPTW
         oH67wTONmex4st6oHHqfABwoqD2lnaDYgFK9U=
Received: by 10.103.80.25 with SMTP id h25mr1893553mul.15.1251117381714;
        Mon, 24 Aug 2009 05:36:21 -0700 (PDT)
Received: from ?192.168.1.13? (abwd173.neoplus.adsl.tpnet.pl [83.8.227.173])
        by mx.google.com with ESMTPS id j9sm21623677mue.56.2009.08.24.05.36.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 05:36:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A91BA53.1040800@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126921>

On Sun, 23 Aug 2009, Mark Rada wrote:

> This commit adds a new test file (t9501) that is used for gitweb test
> cases that parse gitweb output to verify the HTTP status code or
> message.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---

I would rather put emphasis on the fact that new test is created, which
is meant to check that gitweb produces expected HTTP status codes.

-- >8 --
Subject: gitweb: Add t9501 test for gitweb's HTTP status codes

This commit adds a new test file (t9501), that is used for gitweb test
cases that parse gitweb output to verify the HTTP status code or
message.

Currently the only tests are about 'snapshot' feature settings
-- [end cut] --

Or something like that.
-- 
Jakub Narebski
Poland
