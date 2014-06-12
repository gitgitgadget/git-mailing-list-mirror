From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 12:36:42 -0700
Message-ID: <20140612193642.GB17077@hudson.localdomain>
References: <cover.1402557437.git.jmmahler@gmail.com>
 <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
 <539960B8.1080709@virtuell-zuhause.de>
 <20140612082218.GA5419@hudson.localdomain>
 <xmqqmwdi55co.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAnq-00046x-Et
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbaFLTgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:36:46 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:43704 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaFLTgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 15:36:45 -0400
Received: by mail-pa0-f41.google.com with SMTP id kq14so1346407pab.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OJeQ+dxww3MGkndEvfP4YAHwXt49AfpHZxD/3LchYOk=;
        b=Ep7W5wwGHkIu7BjL6tPXreLdFlXEmk0nVS1TQ8VfpGHCysLeDEfQ/KSouSEdssHlfc
         pquOw87qwhP2opodTpDcXHefZzuIgQggCnnSqdS14IWLc5SapGkmRFqWhtft/qHlVOXA
         VjvwIRfKQvyQpR6/gPTSN1t08Bd+r/latsyJ36QV41NO9CvlAzG0ESUorgwpJs9jNwN6
         ueD5od4LU9akwQ7VQFcX4jyG0KgNdPcxgc+ZvgdHmteBdxUDAYVepJyTc/zRs3OIzgSy
         z5cLEBs3B/0d2CnxUTOWKg84wdnbcxh7w9c49XONXeOzzbrb7rU2DxglO8p9b7ag82U4
         Sa9Q==
X-Received: by 10.66.102.74 with SMTP id fm10mr1037040pab.79.1402601805318;
        Thu, 12 Jun 2014 12:36:45 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id qq5sm81860118pbb.24.2014.06.12.12.36.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 12:36:44 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqmwdi55co.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251485>

Junio,

On Thu, Jun 12, 2014 at 11:51:19AM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
> > Thomas,
> >
> > On Thu, Jun 12, 2014 at 10:11:36AM +0200, Thomas Braun wrote:
> >> Am 12.06.2014 09:29, schrieb Jeremiah Mahler:
> >> > A common use case with strubfs is to set the buffer to a new value.
> 
> strubfs???
> 
I was trying to make it plural.  Perhaps strbuf's?

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
