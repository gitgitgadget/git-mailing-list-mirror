From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 09:22:25 +0000
Message-ID: <e2b179460803050122g4648270eqd65549f4db39b14b@mail.gmail.com>
References: <200803041459.29000.michal.rokos@nextsoft.cz>
	 <47CD78C9.80003@viscovery.net>
	 <200803050937.40345.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, GIT <git@vger.kernel.org>
To: "Michal Rokos" <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpq6-0008Qk-Vp
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 10:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbYCEJW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 04:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481AbYCEJW1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 04:22:27 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:10277 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbYCEJWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 04:22:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so833239rvb.1
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 01:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Nst060jZnWOu2V2cM3HrGxsqhtGII501QFlKLPHbS9I=;
        b=U1gS5jerat9Bn70pS/1QIAelxHvRe6Ip+ymvPju9HC1Enlkgb0sjKBVyquIoUds/ORuNGNlw2t7XqtUTFSPz/0uDaLHJjVO2AZiUTX+uGj4cvA2/eRulMSJQY6j+ZSYT8mpZ9FYFezr3RHByHDhArEJT+QBcBrTkD2bqmjWl6YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lMM/OVjIhVG0YlIzaYYGNN5QDQslhAyrKYS9nBpuYXLhNx1hKBjI0teCytXnuBfr7Y3zaYGQXW8PExuFhryS1hXGO2v38yjxzoDUZ1EWO8QEfPXr7hSQ+n5n3eSsnWRtjzyWo1j8HXxrjP9WhYTHOEKBZwtRmRm+qoV5wKhA0cU=
Received: by 10.141.22.1 with SMTP id z1mr1101229rvi.67.1204708945027;
        Wed, 05 Mar 2008 01:22:25 -0800 (PST)
Received: by 10.141.19.11 with HTTP; Wed, 5 Mar 2008 01:22:25 -0800 (PST)
In-Reply-To: <200803050937.40345.michal.rokos@nextsoft.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76202>

On 05/03/2008, Michal Rokos <michal.rokos@nextsoft.cz> wrote:
>  Could somebody else try to run testcase above on some other OSes?

AIX isis 3 5 00C0FEDC4C00
case1: 5
case2: 5
case3: 5
case4: 5

<faints/>
