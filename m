From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCHv2] git-web--browse: Add support for google chrome
Date: Wed, 19 May 2010 11:31:44 +0100
Message-ID: <1274265104.2121.7.camel@wpalmer.simply-domain>
References: <1274262692-3783-1-git-send-email-pavan.sss1991@gmail.com>
	 <1274262692-3783-2-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 12:31:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEgZ8-000122-N4
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 12:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab0ESKbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 06:31:50 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:64213 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab0ESKbt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 06:31:49 -0400
Received: by wwb22 with SMTP id 22so457831wwb.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=BcqKtEKCel5DzXKCTis20Y/QDT6pj2Xb5iXVRkmmGus=;
        b=YCG7wM9o33g2z8GR0HCF6YBJUaFj10yamF9zWfCHySK6yQkGYFR4TzJnG5h72FEx8f
         MPcFQh0ngL/GtD+RvPHy/dRVKLvUZIpMA/HQhL6qylf5AalbMNxHfgprBHVGA1nbmmsx
         aZEbSpA/pvsDDMOq/nTcxZbsklfcRj3k0eLoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MT+VnWefvHwXppGIweXXWEs2oGoPauxf238a4DmB7Pr1/IZjwR5XVlTfn2TM94dEX/
         ESPAqYuJH2orUCkYH6fot4fBuD0KyH5lQCmyztrlAmSO+qCB9Gg0RWOHFMQaMPvW0fbo
         YMaws4KYj9bTpYiWF3FPfYtK78ifCf9FhQ180=
Received: by 10.216.87.135 with SMTP id y7mr639543wee.10.1274265107909;
        Wed, 19 May 2010 03:31:47 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id g17sm2888081wee.17.2010.05.19.03.31.46
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 03:31:47 -0700 (PDT)
In-Reply-To: <1274262692-3783-2-git-send-email-pavan.sss1991@gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147325>

On Wed, 2010-05-19 at 15:21 +0530, Pavan Kumar Sunkara wrote:
> Add support for another web browser called chrome. To
> select it, the value of the browser is 'chromium'.

perhaps this has already been discussed, but aren't "chrome" and
"chromium" two different browsers? (based on the same code, sure, but
different releases which are often installed separately, all the same)

In my set-up (which as far as I know is done by blindly following
instructions from google), the browser is executed by the user as
"google-chrome". "chrome" by itself is not in my PATH, through
google-chrome is a shell script which seems to eventually execute
something called "chrome" internally, after setting some paths.
