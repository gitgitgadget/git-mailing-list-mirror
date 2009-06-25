From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 1/3] gitweb: refactor author name insertion
Date: Thu, 25 Jun 2009 09:39:55 +0200
Message-ID: <200906250939.56361.jnareb@gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com> <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 09:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJjZA-0002U8-KJ
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 09:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbZFYHkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 03:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbZFYHkE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 03:40:04 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:56967 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZFYHkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 03:40:03 -0400
Received: by fxm9 with SMTP id 9so1254015fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uhWRy9XOR5G6XfSKBhorrYE2V9Dv6QHPGdGN9/FB8KU=;
        b=s+IYJTLGwwDtMSBLcL5a1foG5PLjHl8PDzG3hlG8CcCaYf5+BbRxByY1RaZDjB6o4l
         rTJRWH+F3D1oqv2stKAKFlH6lK58bEhoIYYsmqznfVEQCJ/OJTnYMDwZAGX3w1ndFf0+
         gsE/zyA6mLNdEWGdhWHABLbveC4lM5PxlVAAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d7njOB7l2flcYEEX3rL7CG7Uyu3P/JbHjOB2L3PKc1ryTQ9YDDaASp3TJQA9iGwNlA
         KzB4+t6Vza0kwxxc2ISGD+cwOy6jFLpJ9dOFQ+TMp/Mhq2ma5xh+a4BudKw9HAM1aHej
         a8qczull6qxSmfLvS1sqyhVCmTawq8MrUIiQU=
Received: by 10.103.213.19 with SMTP id p19mr1327716muq.32.1245915605039;
        Thu, 25 Jun 2009 00:40:05 -0700 (PDT)
Received: from ?192.168.1.13? (abvy107.neoplus.adsl.tpnet.pl [83.8.222.107])
        by mx.google.com with ESMTPS id j9sm9451610mue.21.2009.06.25.00.40.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 00:40:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122182>

On Wed, 24 June 2009, Giuseppe Bilotta wrote:

> The refactoring allows easier customization of the output by means of
> CSS and improves extensibility on the CGI side too.
> 
> Layout is preserved for all views except for 'commitdiff', which now
> uses the same format as 'commit'.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---

Could you please state here, in the comments area, what are the 
differences between v4 (previous) and v5 (current) version of patch,
and if there are any?  It helps with patch review...

>  gitweb/gitweb.css  |    5 ++-
>  gitweb/gitweb.perl |   79 +++++++++++++++++++++++++++++++---------------------
>  2 files changed, 51 insertions(+), 33 deletions(-)


-- 
Jakub Narebski
Poland
