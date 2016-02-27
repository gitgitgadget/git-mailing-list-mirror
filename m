From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: GSoC 2016 Microproject
Date: Sat, 27 Feb 2016 18:34:57 +0530
Message-ID: <56D19EF9.3070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 14:05:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZeYY-0005h6-VG
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 14:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571AbcB0NFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 08:05:03 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33128 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282AbcB0NFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 08:05:02 -0500
Received: by mail-pf0-f196.google.com with SMTP id t66so1909747pfb.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 05:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=bPMgrQEG5OejPBv66K4UCv0b1k1om4d6ywXTCIIHcJg=;
        b=BvXqRrF0BNfn9Gr4V0SBhfaXHr+dlK721yq9tyjttdxBZdh/FvL2rcckBQe/x6iloa
         QCg29FyMS12hb7KFbmyHOaKUGEVWGWtFV5wb4TQsdQ0pYbYHTRaffjJT8Mue71n+bWL8
         KFeUC0R7dbYJSeSsWsVsdKQXOyArPcOV21dyqMF5avboJDMzUg2QYvAdtUvC3jmnAe5y
         ZS68m+d3zQ8xIHtZQdEo0gcvMuifS+GLPCg+Grz388vx0uGKJoHLol/oIK7ifSlutfqh
         zNoaycU01WKNvLV/diTLbba0FA3Is+lvn1G/hxFNEov3UAPHkO1+tIxyAQs4RDz2gIs7
         uR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=bPMgrQEG5OejPBv66K4UCv0b1k1om4d6ywXTCIIHcJg=;
        b=fV8PFafS4uyGHIzKiKVyi8BDIrcf1XF1Jd+yMbNf/daoYd5EKXykzynHwk7vd4DwXL
         ynydCsIHwZWcnbkojo41EaCTWgbgfSdqDjr/w9oceO2KyZHqz2yH8WuUJyyC6+vVg7Ym
         XkkaX605AuLjqrf0rSc/qDPXmzzpRBTZOZzpeMHwFiGS1IKGs3xb3YJBbbaEhP2OKoqH
         Bd6F0FcWfOBXGqnRhfDMG0aNhwxjok2goU62Tr6vSo5aOA+0sHr1+XUOc6psLej6toUg
         fZnR8LGRcT+gapnaP0tkaXITSlx8o5iAzwIPOx7SZHXRFDooL3HJVmQHh59EvR+MXmmR
         z4mw==
X-Gm-Message-State: AD7BkJLPE9LfnMoQsDQzXur7qq1x11XXqZJP4Yuy4WEIlCFWYkerfGZn/yjVfMIsdU1sxA==
X-Received: by 10.98.33.199 with SMTP id o68mr8986666pfj.125.1456578300696;
        Sat, 27 Feb 2016 05:05:00 -0800 (PST)
Received: from [192.168.1.10] ([182.68.63.13])
        by smtp.gmail.com with ESMTPSA id ko9sm26181844pab.37.2016.02.27.05.04.59
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Feb 2016 05:05:00 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287697>

Hi everyone,


I'm Sidhant Sharma. I'm looking to participate in GSoC 2016 (and contribute  
to Git in general as well). I read up the pages relating to participation  
in GSoC and selected the microproject "Add configuration options for some  
commonly used command-line options". I have some queries regarding this  
though:

1. I believe the option can be added by a reassignment of the `verbose`  
variable in `parse_and_validate_options` function inside the  
`builtin/commit.c`. It can be a logical OR between the `verbose` (which was  
parsed by the argument parser) and the value obtained by using  
`git_config_get_bool("command.verbose", &opt_verbose)`. Am I thinking on  
the right lines?

2. Should I also add an option to override the configuration for verbose?

3. The microproject title suggests there can more such options, so are  
there more to be added?


Thanks in advance.



Regards

Sidhant Sharma [:tk]
