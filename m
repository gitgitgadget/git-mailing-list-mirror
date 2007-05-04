From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 10:47:24 +0200
Message-ID: <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dana How" <danahow@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 10:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjtS0-0005hP-7Y
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbXEDIrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 04:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933036AbXEDIrg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:47:36 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:63747 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbXEDIrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 04:47:36 -0400
Received: by an-out-0708.google.com with SMTP id b33so764831ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 01:47:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XJSojbeSDR6znjwBkJVMf7BlA4ztDrydfjtV/EBVyTDJvnlUYLYSGWuc2jyhzJUSSK7guFbNh4DGCPDZBMhyuNQIRe9FU9r2R7HLdVlRX++ZvWv2dlK5pC73hWXaCb1uA0wUL8BEys480Nhr+c4iY80rzY0BP21OLOWqrJo0oPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ufAInxWgDoPDvyrSk505TrvLLn5ijvbSDB2Jos0KATVC53gxt6lw/XIryXVA5dSPy2cviFyI3u0cpnLWds/VfRO2mDZpuy0X+jBE8/tJ9aPcqcHO0rqOBFkFNSDfaVLRvxvLSdvgPeX0VZFlitPkKTHA1CSxuAwxZFqaOZ4sWrc=
Received: by 10.100.213.3 with SMTP id l3mr2435485ang.1178268444635;
        Fri, 04 May 2007 01:47:24 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 01:47:24 -0700 (PDT)
In-Reply-To: <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46147>

On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
>  (1) we say it was a mistake that we did not make it relative to
>      the current directory when we introduced the X:<path>
>      syntax (X could be empty or :[0-3]: for index, or a commit
>      or tree object name), and change the semantics in a future
>      major release for everybody, apologizing for potentially
>      breaking existing scripts; or

That would be my first prio preference

>  (2) keep the current behaviour as is, and come up with a
>      different syntax to use relative; or
>
>  (3) do nothing.
>
> My preference is (2), (3) and then (1), but I do not have
> offhand a suggestion for a good metacharacter we could use.

"./" :)
