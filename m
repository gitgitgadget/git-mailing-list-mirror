From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT4 PATCH] Add --no-color option to several calls to git
Date: Thu, 18 Oct 2007 01:38:29 +0200
Message-ID: <e5bfff550710171638l26d3e55ej9dc8b38f8aee7592@mail.gmail.com>
References: <1192643649-18908-1-git-send-email-ya@slamail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yaacov Akiba Slama" <ya@slamail.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiITQ-0006uF-5G
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759499AbXJQXig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759303AbXJQXif
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:38:35 -0400
Received: from ag-out-0708.google.com ([72.14.246.246]:28360 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758843AbXJQXie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 19:38:34 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2110121aga
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6CdufvdPw8V32gKu6v/w28YFtpp5M8JZAcIH9ifE8Aw=;
        b=AAXTh6b/V77r8k4RqDwTeN6Elgyr11QQSF3rIzyIFXy3f9umsHRu7zUYj1I4vn+nGt/ORg6zfUa0QDC4Kp6vxPMvBdIgpGX9e6a4lmnfmAgLvsjtG2qVtt+p/ArEreESYBaUFqjgEr2EQiAFjOtBuEnW4FpKl7ExfO45QMQPZuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZMAP9V95aBq5CXGdSgxEf8ItlKwavhwyy8ZZ+MMoihodElGA3e+eaMAsOqmw/ASk7zsoYkSr1+JUAFND2DgfG2yaM5uTAa4PmaPseWrouxBaLHX7x2jCdf34a/HhToUlsjP2/7clv6thGBb0aWrH0UspfHQ7AKfsyDehlXGgG7o=
Received: by 10.140.186.20 with SMTP id j20mr3267374rvf.1192664309427;
        Wed, 17 Oct 2007 16:38:29 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Wed, 17 Oct 2007 16:38:29 -0700 (PDT)
In-Reply-To: <1192643649-18908-1-git-send-email-ya@slamail.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61441>

On 10/17/07, Yaacov Akiba Slama <ya@slamail.org> wrote:
> Setting "diff.color = true" in the configuration makes
> the output of several git commands use color codes.
> The color codes aren't parsed by qgit, so adds the --no-color" option
> to the calls of these git commmands.
>
> Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>
> ---

Thanks for the patch I will apply probably this week-end.

Probably a point release both for qgit-2.0 and qgit-1.5.7 will be
needed. This is a new feature of git that could break current qgit.

Could you please confirm me that with this patch qgit works flawless
for you when "diff.color = true", I' m worried to push a new point
release just to discover we need to fix some more.

Thanks
Marco
