From: "Alexey Mahotkin" <squadette@gmail.com>
Subject: Re: [PATCH] more dependencies in doc generation
Date: Fri, 21 Sep 2007 01:42:39 +0400
Message-ID: <bb5b640b0709201442i5380097fu71bdd32ac30a5af8@mail.gmail.com>
References: <bb5b640b0709201343j5a04a554ib91785b43464d4d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 23:43:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTno-0003J2-UX
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbXITVnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXITVnN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:43:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:4673 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbXITVnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:43:10 -0400
Received: by nf-out-0910.google.com with SMTP id g13so589120nfb
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 14:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=40SbzEX8/u7BrKlizJGv3/cJsUxpbMjrO19DV7Qi1g0=;
        b=top/jNPNVSNPn3dNEX3k7Me1ujHIhy0+NXZ2NC39ibOTL4MQDFEs9nhGgClk/kaV+2pZZ4nHpv6veyndU4UN+peYm0mVyJlo/zsOnh7dkG+hvTAUl0ydVY9HShETlL8P7EsFYqzLhR8TfW1ZTyVm0SsZB6tiHFtUmCOEQshqdE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FkahREVL8q2fv25MMzwhfpcmCITPuvDzHou8Oi51mOqj/1d7+MidOM2hD9xDuazxn9Cz+unJOZJY+IQfOhIbvo94eq8ynl4MUFFjaDLst/Q3/iPqRe/pBsfmcENnLWkpF6YGDIyZRuG5MeTjBfVLPxiptuMzOayRw5AUocX6o6Q=
Received: by 10.86.86.12 with SMTP id j12mr1726312fgb.1190324559422;
        Thu, 20 Sep 2007 14:42:39 -0700 (PDT)
Received: by 10.86.66.18 with HTTP; Thu, 20 Sep 2007 14:42:39 -0700 (PDT)
In-Reply-To: <bb5b640b0709201343j5a04a554ib91785b43464d4d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58808>

On 9/21/07, Alexey Mahotkin <squadette@gmail.com> wrote:
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -135,11 +135,11 @@ clean:
> -%.xml : %.txt
> +%.xml : %.txt asciidoc.conf

This change is not needed, sorry.

-- 
Alexey Mahotkin
http://www.versioncontrolblog.com/
