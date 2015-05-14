From: Jim Hill <gjthill@gmail.com>
Subject: Re: [PATCH] sha1_file: pass empty buffer to index empty file
Date: Thu, 14 May 2015 16:26:40 -0700
Message-ID: <20150514232640.GA11838@gadabout.domain.actdsltmp>
References: <1431624219-25045-1-git-send-email-gjthill@gmail.com>
 <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 01:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt2Wj-0002CG-5q
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 01:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbbENX0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 19:26:48 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33696 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbbENX0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 19:26:48 -0400
Received: by iebgx4 with SMTP id gx4so75159707ieb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 16:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J0HmgpKsWOs1vEGeiNEeScNl1HwN/8PM+7InFk4jhWQ=;
        b=uD0HZ2CPJEYfJplo8LfLCZ5elRhS4FNKupBlpVuj7U2878U1AEesCgdjxGvp1JrLge
         T6vb4hdcrRXwH//wHTpVhyECXtvoitm1zZXmSePchBGrBA9Wi+SJKjGIsftvoDaRV5lC
         M6B0HlkgbuJKRqwENxwY0kAeroQBeO4HIS8BiCjKuNRq459XsJkTZWWh81IdiNaRQMhM
         LJ5s+2GlI5TwzZ7TMT0ZxfmIBNJzbeLekM8S6f3vxBk1nCew9oI0KviKuVpdTr3A6GtQ
         1W2rKx1UBfISrJde8zLj71g4rgnREmSLcDaw8W1AMK/0pUBP1obe7a5qQK1JAH+cR1tY
         N7rg==
X-Received: by 10.50.221.98 with SMTP id qd2mr20695386igc.37.1431646007573;
        Thu, 14 May 2015 16:26:47 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id e6sm305580igy.15.2015.05.14.16.26.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 16:26:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269121>

Thanks for the corrections and improvements. The resulting test code
looks much cleaner to me.

Please do suggest any further improvements that occur to you,

Thanks,
Jim
