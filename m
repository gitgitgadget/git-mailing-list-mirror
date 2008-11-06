From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Added test case for mirror to not push stash refs
Date: Thu, 6 Nov 2008 09:34:36 +0100
Message-ID: <bd6139dc0811060034q14e47232n5f00471e5420efbb@mail.gmail.com>
References: <20081028212327.GA25358@sigill.intra.peff.net>
	 <1225942397-20513-1-git-send-email-david@statichacks.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@statichacks.org
X-From: git-owner@vger.kernel.org Thu Nov 06 09:35:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky0LJ-0003JP-EP
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 09:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbYKFIek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 03:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbYKFIej
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 03:34:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:11457 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbYKFIei (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 03:34:38 -0500
Received: by fk-out-0910.google.com with SMTP id 18so497856fkq.5
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 00:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wWzoKvbJiklbDKAtdsnp3dI/X/512BzfVexmxIxCtMY=;
        b=fNLJK+jG0SQofygHjCh3ajxt/76VwbESAOWfdVlnyuVFLBhAyJVhpmyjpZ2aPI8gcm
         DPS/Y7DsvcVtLM9R14lVp4mZ5IE37+fOQ5ehQdKHP3VqGGd0rmg96m7FDG4DFzPVTIFV
         tRmdG/FqBj0mZJvD2Oa5LxBBAeVH3DpvmiAeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=wrWWlADo2EfMl2tPTBYK2gIpGb9soSl6sw5gbM65r8+FQo3zlVFm8UycnU0qhuADOW
         tzAz2x0HKYfw9aD/TCwOO/kr7VWWX35ly88/4S2LCNN89ZMsRFbItb1b0GOzR+Fibinx
         KkKjPfnCKr2Ela7RMlTXoq8+EyboxEcvKNJYw=
Received: by 10.187.204.16 with SMTP id g16mr403212faq.14.1225960476689;
        Thu, 06 Nov 2008 00:34:36 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Thu, 6 Nov 2008 00:34:36 -0800 (PST)
In-Reply-To: <1225942397-20513-1-git-send-email-david@statichacks.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100218>

> +               git push --mirror up
> +       )
> +'

I don't quite get how this works, I don't see a test here anywhere to
actually test that the stash refs were not pushed?

-- 
Cheers,

Sverre Rabbelier
