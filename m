From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: GIT max file size.
Date: Thu, 8 May 2008 20:46:15 +0200
Message-ID: <81b0412b0805081146s2f16f256u39717f107ff91c02@mail.gmail.com>
References: <48232B48.9010900@cc.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "epankala@cc.hut.fi" <epankala@cc.hut.fi>
X-From: git-owner@vger.kernel.org Thu May 08 20:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuB91-0005zK-ON
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563AbYEHSqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757301AbYEHSqS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:46:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:19946 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbYEHSqR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 14:46:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so479648nfc.21
        for <git@vger.kernel.org>; Thu, 08 May 2008 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UefqRW7l+1ks26jlOijV27HtHfDexGvHYGfWmz+nsPc=;
        b=h83uzoVysYo8immPLZRii3M1ER9TbnpCD6i0Jqmi8NnL3cKdIvQ7M/ipIKOdqP5ZdqMhT1sTbzKri1G+qKfWYn6ou112UJsrWPfifgFrwN1y/Ocl7szQS/ZgM/OvGU0y41ca/3pDMZuthsGfLw0enyMFeR18dnze49lTFlF1g1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XaUdV18Ao6m3tXD9NZLRzBcdaasn7SS4jOWQ9Vxl80VMJHXbrvmkK0csRZfFjYQ2uBK1r/GX768VMBRx/ziIC4PZjgGlXLLcshEkt3lzGmdVM3uJdkiD9aXrhn/hkbp1rE9k+AH1FMh6EAFRe4JDpbt08xHneisG+ujR/6ioAJA=
Received: by 10.78.164.18 with SMTP id m18mr1000053hue.87.1210272376013;
        Thu, 08 May 2008 11:46:16 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Thu, 8 May 2008 11:46:15 -0700 (PDT)
In-Reply-To: <48232B48.9010900@cc.hut.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81552>

2008/5/8 epankala@cc.hut.fi <epankala@cc.hut.fi>:
>  Is git going to support >2G files

Maybe sometime. For now, the error could be handled better.

> ... or is having "everything that is
>  needed to complete build process from beginning to bitter end" in
>  version control something that git is not meant for?

That was the plan :)
