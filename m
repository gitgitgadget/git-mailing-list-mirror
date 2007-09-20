From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 0/2] add support for per branch merge policy
Date: Thu, 20 Sep 2007 15:07:50 +0200
Message-ID: <8c5c35580709200607s428e898ay32fd4cdad30f096e@mail.gmail.com>
References: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 15:08:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYLl7-0007Eu-FL
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 15:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbXITNHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbXITNHw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 09:07:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:22442 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbXITNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 09:07:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so603401wah
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kEzF4TACPKn27m5vWvW9pc/iolJr0wQdRQ4MnroOiXw=;
        b=ORTJB/0QusL8/UHqYoffzWx3s05v3xZd2/ncoVR73PW7LkXd2Ac4qmcuwvnO/nWdtfIhFyVMnlLd5Gbj+H4TRXES2D0Aon1G9iSS02V7zzAIFOsaTqr9bkvjh0dCigCvIxuJalRiJphDykId4QOa3BNM9F2Yn/W13A/LiwD0krI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cs3LlHXAbDy+TOZm7D3xm/PHXF7FlVrkL6k2jt4CQDZW+SXoXSQBiHLHV3Msee/YnuNtF9EACkl4Y5XprRPh/3QpUXC2D3iq6Q0Myv8ezgA3jBiUdTEa3gRUsNgFyNeXbdpHG9SpKfgqtiOXaxHdUSfAq2HpzHqlLjEOHeMpKUY=
Received: by 10.114.15.1 with SMTP id 1mr2124218wao.1190293670504;
        Thu, 20 Sep 2007 06:07:50 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 20 Sep 2007 06:07:50 -0700 (PDT)
In-Reply-To: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58775>

On 9/20/07, Lars Hjemli <hjemli@gmail.com> wrote:
> branch.<name>.integrationonly

Btw: we might want to call this 'branch.<name>.mergepolicy' with the
possible values 'synchronize' and 'integrate'.

--
larsh
