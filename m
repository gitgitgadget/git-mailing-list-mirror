From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 6 Jul 2007 17:59:19 +0200
Message-ID: <81b0412b0707060859u6a1c3a24p4399a71d84038615@mail.gmail.com>
References: <468E59B3.7080007@nrlssc.navy.mil>
	 <20070706151145.GA15341@informatik.uni-freiburg.de>
	 <468E5E31.8040504@nrlssc.navy.mil>
	 <Pine.LNX.4.64.0707061631560.4093@racer.site>
	 <468E64F9.9080805@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=" 
	<ukleinek@informatik.uni-freiburg.de>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:59:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qDN-0004eV-Pc
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762042AbXGFP7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbXGFP7W
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:59:22 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:22361 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762042AbXGFP7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:59:21 -0400
Received: by ik-out-1112.google.com with SMTP id b32so237182ika
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 08:59:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rTGAlt9LT3FrxIRMvlb2t9KuHXScPmBP/n/llSJukHgC3DtTdzNpiP30G1BOf+jLz8sd7VwubVMPSkitoi/AuJ7NrSUF+wjyd1aa0RFSggoR0kDJ/XbHGf/uTEbiK1vmnGHGUpI2mHAHFArTCPWTj8blqTrziUC0LZUJAHRpgOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h4PMtaSdgxuOFaq/xOV31X7zHdyuIMJwIj2Ap/Ekf5sblHW7YJzHm9AHr3q8DNnC+4+lyoM09yuggHBOp33QVyCb90JhWPbIW5ZA7JEYqO43+NR6tFtiJGnA4w8l0nOY4atNs6rhBf601tha9/XPrpcTSK+jNgoL+Ej93Uz6Ffw=
Received: by 10.78.172.20 with SMTP id u20mr376247hue.1183737559714;
        Fri, 06 Jul 2007 08:59:19 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Fri, 6 Jul 2007 08:59:19 -0700 (PDT)
In-Reply-To: <468E64F9.9080805@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51768>

On 7/6/07, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>
> Is the recommended tab stop 8 characters as it is for linux? or 4?
>

Tab is always 8 spaces. It is indentation which can be 8, 4, 3, 2, and even 1.
It is 8 in Git.
