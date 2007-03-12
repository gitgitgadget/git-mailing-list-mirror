From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] More build output cleaning up
Date: Mon, 12 Mar 2007 10:04:00 +0100
Message-ID: <81b0412b0703120204m2d7a543ep3eec68a580f595ff@mail.gmail.com>
References: <81b0412b0703061513g7aafc9daq46feea69d969089a@mail.gmail.com>
	 <20070311184827.a98691c3.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Sergey Vlasov" <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Mon Mar 12 10:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQgS2-0001Uj-Dw
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 10:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965396AbXCLJEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 05:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965389AbXCLJEK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 05:04:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:11030 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965396AbXCLJEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 05:04:04 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1933583nfa
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 02:04:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oDD2zHE2bkhAeO8GkwAPafhbP1NwiVJAbJeALWdyQDUpWlcqTBPNn/j1htX8tM8zg0TYo3u4SL6ujyw0j+LecsXOzWptnLz5g71zMJWbOl6ZryH02Wi4NmhRXLn7Lumc71VQDL3pxwJ9onMpeoeqcjem4T9ONBCypg/lVTQVeOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gcu+h6/QLGSgt3Q5Oaj0c9fGeQ3Ma5I6npGgnxenP+kHXlyTUnvKv+YvT5uNvqOEeHR7HqJ9jRDVPz5yiibCnyeWtoB8pXtMI5qI8LXopYd2OFY+eXJNWfTX9XjzfGvVKngb7sN42c6S5K9DJcvz5tljb6g3yB+BJcznKZQMuyg=
Received: by 10.78.203.13 with SMTP id a13mr595811hug.1173690240979;
        Mon, 12 Mar 2007 02:04:00 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Mon, 12 Mar 2007 02:04:00 -0700 (PDT)
In-Reply-To: <20070311184827.a98691c3.vsu@altlinux.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42015>

On 3/11/07, Sergey Vlasov <vsu@altlinux.ru> wrote:
>
> Using --no-print-directory will break movement to the location of an
> error/warning message at least in vim (emacs will probably have
> problems too), if the error is in some file in a subdirectory.  The

You can setup the make command-line to contain -w. It will work
for git and for any other project you may have.
