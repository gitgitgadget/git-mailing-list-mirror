From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 0/3] Isolate If-Modified-Since handling in gitweb
Date: Tue, 27 Mar 2012 20:57:31 +0100
Message-ID: <201203272157.31870.jnareb@gmail.com>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org> <201203272124.23145.jnareb@gmail.com> <20120327194933.GA32529@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:57:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCcWP-0004Lg-8H
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 21:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab2C0T5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 15:57:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63828 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab2C0T5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 15:57:32 -0400
Received: by wejx9 with SMTP id x9so179213wej.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=AFTOav+jazKMzZabS8z4u/sTtkG8LFYBV/lObsih+Oo=;
        b=ZIhVbI3OHLIWKiaCQKtIG3Q905+DTI1ttdVA09h/+Zgu3Nr1lAgCB2lbJB2wtpGVfj
         +W4/aCYXXRL5GLyEj6vQVm4a7XKRVzqv8LHp3Lcn42Ucc2pig++tncMx7oTYfOoBgUyn
         q1dVqw6BI15z3xIVdCixUP1TMZoYazOZ+Niv7zDDDM4smJ958f5oWVKbvuw9/gLm43Vm
         1qjq8GKUM+CX0hi28fAD2f1APeRMBHOHO0oQa6Z++ShrCbO+Hpvtc+9K5aLPSEFHTCoL
         nWEL+K/u2oqVT+MIyZoJHIrMIyhSYhHXvlMnlTZGn0kM/tu8zGTmDv2EmPt7yeAuozjb
         gecQ==
Received: by 10.180.104.231 with SMTP id gh7mr724098wib.10.1332878251553;
        Tue, 27 Mar 2012 12:57:31 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id o2sm3121647wiv.11.2012.03.27.12.57.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 12:57:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120327194933.GA32529@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194081>

W. Trevor King wrote:
> On Tue, Mar 27, 2012 at 08:24:22PM +0100, Jakub Narebski wrote:

> > Though I am not sure how lack of "Status:" header is different from
> > incorrect "Status:" header for 'grep "Status: 304" gitweb.headers'...
> 
> It's not for the 304 tests.  I thought it would be a good idea to grep
> for a 200 status before looking for Last-Modified times, to ensure you
> actually get to the successful response stage.

Right.

Testing both sides of a new feature (i.e. modified and unmodified here)
is a good testing practice.  Thanks.

-- 
Jakub Narebski
Poland
