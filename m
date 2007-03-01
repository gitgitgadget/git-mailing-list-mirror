From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Thu, 1 Mar 2007 11:12:00 +0100
Message-ID: <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org>
	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	 <45E68897.8000607@lu.unisi.ch>
	 <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	 <45E68EDE.2090405@lu.unisi.ch>
	 <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	 <45E69297.8070001@lu.unisi.ch>
	 <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	 <45E69EEE.8070905@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Thu Mar 01 11:13:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMiHP-00058v-3F
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbXCAKMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbXCAKML
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:12:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:39664 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964798AbXCAKMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:12:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so328806uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 02:12:05 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sKtzDXq0pSt7I8LUxUxbB5IJvAfRWE4VQhweNaIzGtJPTEJ6iv9a0Rq9hhcYe9nEYtLbonALiU87JZLQ54Wm/YehRZ6J3nF1T27AGNjgX6Gxo7bY0PnhwQ+1sxXJyJYpFAeh+4H0knLYK9J4wv8da/RjbepPdwzdmO4qu/cxkY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aGtU/mSFZF9drm6b1L4vOubWx1td1nMiW8ScQBZRm0d2xv3iGQSgfBX+TWOLIKCOhj2TPGn8uGLtlaQy2u3XWIZwsU65lJaaiAs+ad3WrxmhN1evwepUZ64dILf9U/N4vVS03bz972t6K8Zyo72A9i+0YXUieqffDv/5M4KpbHc=
Received: by 10.78.180.18 with SMTP id c18mr136819huf.1172743925574;
        Thu, 01 Mar 2007 02:12:05 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 02:12:00 -0800 (PST)
In-Reply-To: <45E69EEE.8070905@lu.unisi.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41074>

On 3/1/07, Paolo Bonzini <paolo.bonzini@gmail.com> wrote:
> > Actually, how about making the default configurable _AND_ have
> > the --no-track option (for scripting)?
>
> Fine by me.  And also --track in case you want to try it out.  ;-)
>

Ack. Thanks!

> Patch attached.  --remove-section will go in a separate patch.

Still think it is a very dangerous operation.
