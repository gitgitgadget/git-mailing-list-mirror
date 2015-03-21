From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Sat, 21 Mar 2015 21:21:02 +0100
Message-ID: <1426969262.3756.1.camel@kaarsemaker.net>
References: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: dwheeler@dwheeler.com
X-From: git-owner@vger.kernel.org Sat Mar 21 21:21:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZPtP-0003yg-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 21:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbbCUUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 16:21:07 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36154 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbbCUUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 16:21:05 -0400
Received: by wibg7 with SMTP id g7so15218778wib.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 13:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=SVaHwOirJ1lZc95pDQhEmcEx0kX39zpYWdFcbcsmqWk=;
        b=hpfYp7Tb9rwFf97chb1mI3ie48UpUSuon1IMegtlq4HA8wUMTVwLu1RNK3i6/yJW7+
         o2hTTZNQvHuP9QomnosUNDtRKO22/7k4kyt4bYzHcxQiZKMdrRk0w31rx8/yXWbKEsBC
         7tKRkAsjV+it1yL/BaMsb/ELzXggEY9+j2EVngQcHRqQgKmMxlDGD0Y28fMsIcophBWw
         0u/wEvXxXe//mu5ffu38MfISJS8NCXZP5gfcMaWDDbcIiglpc+WO6zS0nNXbK+VajB6+
         elVXpSx3NcEPtlGNge+u8Y8LlZdBtRroSeo10RYLL+bEKsmHeI57He57goiC3pCGLnEQ
         W7uw==
X-Gm-Message-State: ALoCoQlkPwKU8xa7E2nuqUlRqwuWy+UZuHe5Cy+WPs4WnsfcXB+1Ffd64GpRIGN+QJRTtqePUYql
X-Received: by 10.194.171.100 with SMTP id at4mr149494558wjc.122.1426969264483;
        Sat, 21 Mar 2015 13:21:04 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id cj9sm11986682wjc.42.2015.03.21.13.21.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2015 13:21:03 -0700 (PDT)
In-Reply-To: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266034>

On za, 2015-03-21 at 14:06 -0400, David A. Wheeler wrote:
> Warn cloners if there is no LICENSE* or COPYING* file that makes
> the license clear.  This is a useful warning, because if there is
> no license somewhere, then local copyright laws (which forbid many uses)
> and terms of service apply - and the cloner may not be expecting that.

Please no, especially not without an option to switch this off. Git is
not only used in open source settings, this would be highly annoying at
$work, where no repo has (or needs) such a file.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
