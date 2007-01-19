From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-cvsserver won't add new content on update
Date: Fri, 19 Jan 2007 09:54:53 +0000
Message-ID: <200701190955.00335.andyparkins@gmail.com>
References: <200701181616.38318.andyparkins@gmail.com> <20070118162222.GE15428@spearce.org> <46a038f90701181101w1ea300b6lb4d7e4354d89be95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 19 20:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zgw-00030R-Q6
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbXASTqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 14:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbXASTqT
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:46:19 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:35551 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbXASTqS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 14:46:18 -0500
Received: by an-out-0708.google.com with SMTP id b33so298618ana
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 11:46:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iycjf/1d/65Z8v8qGPVOCLbJv3WaV6SFknIzvpsL49ZFkN1CjcQNGMrT76z/s0VABazNgN9fS/ZewNNUDHoPefYv3INBv7ChYM3nTi2gQ3Exwie7YuYRPEVHBeQ/ZRfC9rQGtqPhoROdYhWxF7a/BxRlRBFV2KyIT/PBOxGggMM=
Received: by 10.78.185.16 with SMTP id i16mr196240huf.1169200680468;
        Fri, 19 Jan 2007 01:58:00 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164])
        by mx.google.com with ESMTP id 33sm2194628hue.2007.01.19.01.57.58;
        Fri, 19 Jan 2007 01:57:59 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <46a038f90701181101w1ea300b6lb4d7e4354d89be95@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37196>

On Thursday 2007, January 18 19:01, Martin Langhoff wrote:

> yup. Also make sure you are using a really recent git-cvsserver, I
> recently fixed a couple of problems related to file adds.

I've just tried again with the git-cvsserver from current next, with the same 
result.

I also repeated with pu and got the same result.  In all cases, the log is 
showing the "Tell the client the file will be added" message; which seems 
correct.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
