From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 2/5] tree-walk.c: remove name_compare() function
Date: Thu, 19 Jun 2014 01:04:18 -0700
Message-ID: <20140619080418.GA15698@hudson.localdomain>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <1403117117-10384-3-git-send-email-jmmahler@gmail.com>
 <20140618190359.GS8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:04:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxXKh-0000SY-Dd
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 10:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbaFSIEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 04:04:25 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51095 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362AbaFSIEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 04:04:22 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so1558508pdj.8
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RD/1mFjdQrY5XDI95W4SsUSJj6vHXh4506Gs20b6vno=;
        b=CcxlyupbQeoSV8KGKZQGxdGfMkLiDuh+SMVYRAPa4G4bZkHyqpejwGz7AjDYjSAdcD
         Qg1iglKSX5lDuY3mJb9cif8Eqp71DpJxu7uXR+cInOkoP7HMF1AwsIQMTGsdJqouak00
         uSIwAnizY2xHwsoz76zdsk6Ge4H6nMFZ7DJ09as2ud+aV/PZ04HuJpG0R1FA1ldHJaZM
         10P8OPhLyR4+5hcCzEqiIcmw0R6ASuCPmJQ+naQjGJTRkvPcFcqhbrh3cVgclravZ20u
         G3Rzk4xajXZerMF/FAo3hOdZppUm//qL+wb4s47aVhG7NJSO802XQqhqMkMi45IIj1rh
         rXzA==
X-Received: by 10.68.226.197 with SMTP id ru5mr3586405pbc.77.1403165061985;
        Thu, 19 Jun 2014 01:04:21 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id su8sm7146712pbc.72.2014.06.19.01.04.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 01:04:20 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140618190359.GS8557@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252099>

Jonathan,

On Wed, Jun 18, 2014 at 12:03:59PM -0700, Jonathan Nieder wrote:
> Jeremiah Mahler wrote:
> 
> > Remove the duplicate name_compare() function and use the one provided by
> > read-cache.c.
> 
> I'd squash this into patch 1/5.
> 
> > ---
> > Notes:
> >     There is one small difference between the old function and the new one.
> >     The old one returned -N and +N whereas the new one returns -1 and +1.
> >     However, there is no place where the magnitude was needed, so this
> >     change will not alter its behavior.
> 
> This is useful information for anyone looking back at the patch in the
> future, so it belongs above the three-dash divider.
> 
Makes sense. I will add it to the log message.

> Thanks,
> Jonathan

Thanks,
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
