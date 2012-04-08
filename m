From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 09:39:12 -0500
Message-ID: <20120408143912.GB2631@burratino>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
 <20120408124652.GN2289@goldbirke>
 <CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
 <20120408132704.GB4103@burratino>
 <CAMP44s2vdEzn8_N=sauq-6OvqA+4tDtM9+yYYWuiQHgkZ2DyYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 16:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGtGy-00015E-IC
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 16:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab2DHOjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 10:39:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab2DHOjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 10:39:15 -0400
Received: by iagz16 with SMTP id z16so4930314iag.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Xf904mSo07VhisIbCTKYAHQ91jzb9ILyy7s4WkYnG2M=;
        b=QSLGfZKou1Ih8fu2bp/KhxafkG5/Z2I2xGyic5c+aqvt9EWrSrdcElf7GqRyPWkYKK
         mQOItouf1Y2CwYP6Y0wNvRYXd7mzbot5ByJ1kYLctP/AA3M18v061LCaot6caYF8rEVd
         InvDk7NQx2P5uD8LLYe88gHSAQXKG3gseqg//E6MCFMvOZ6GCpTcfvDiEn0vtYHeUIR4
         Huc3tH6etMnQRY8Jw9q7W3eFRlFNRGHyHPn7GY+Y8r6rWRRXA46lYXTY1mZHFk9A6Ext
         zkrMsxEH2ZbrXJ4JBZBTT1Np8b0tTrYYh5zMSFTplxR7cjtzu/+piTUB/t7AVN2DkFJ9
         17GA==
Received: by 10.42.18.71 with SMTP id w7mr2383135ica.4.1333895955479;
        Sun, 08 Apr 2012 07:39:15 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id dl10sm11785960igb.5.2012.04.08.07.39.14
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Apr 2012 07:39:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2vdEzn8_N=sauq-6OvqA+4tDtM9+yYYWuiQHgkZ2DyYA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195002>

(-cc: Shawn)
Felipe Contreras wrote:

> I've looked at the history of __gitcomp and __gitcomp_nl, now I think
> it makes sense to keep their arguments similar, at least for the time
> being.
>
> So I suggest this patch to be dropped.

Thanks for looking into it, and sorry I responded to a heated response
instead of waiting for a calmer one.

I do encourage you to examine your communication style.

Cheers,
Jonathan
