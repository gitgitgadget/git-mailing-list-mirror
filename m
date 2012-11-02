From: Tim Janik <timj@gnu.org>
Subject: Overlong lines with git-merge --log
Date: Fri, 02 Nov 2012 02:30:15 +0100
Message-ID: <50932227.3090401@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 02:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU65i-00062D-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 02:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534Ab2KBBaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 21:30:21 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57154 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab2KBBaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 21:30:20 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1571575eek.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 18:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=crwkijXProPOkDpE3ZoNNTNhh5yKW8PaM9P6g17NHKo=;
        b=hH1CcV79ir/AC8fQo4+vnK16W97yr/HogmcUhCwEYr/CWCzomy11gyyGnDDh9LD/Aw
         ssuxJ5pEw+a9LqzbkQ82Y0jkL9RwRlCLwwBq7hrIUEElq8pmN5a1LRyEjWWamkpeFQXg
         6Uz/DyvDvvhKLcxObEmYs3hANcWF2ohbijxBwhSXgdZ0u5LphM66Jm85R9SLLsLudTU/
         Jcg8SgtQbiFTra33IY0IQ6mDpma5ZvO43SvVbXXpueyS35mxo2eLEf3poFaYEYpK02gk
         feL1rataXNfNM2UROjlW4/JyR4l5Fc4iVco2idy0v1ULRQrsedseFOlE+6DAC1onRaMM
         am/Q==
Received: by 10.14.194.71 with SMTP id l47mr1081540een.6.1351819818022;
        Thu, 01 Nov 2012 18:30:18 -0700 (PDT)
Received: from [10.111.3.19] (e176194050.adsl.alicedsl.de. [85.176.194.50])
        by mx.google.com with ESMTPS id g5sm19036017eem.4.2012.11.01.18.30.15
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 18:30:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208895>

Hey all.

Using git-merge --log to merge commit messages that spawn multiple lines
will produce overlong summary lines.
That's because each summary line for a commit includes the entire commit
message (all lines concatenated).

According to git-fmt-merge-msg(1), --log should 'populate the log
message with one-line descriptions' instead of using the entire commit
messages.
Which would make a lot of sense, it's just not working as advertised.

Encountered with git version 1.7.9.5.

-- 
Yours sincerely,
Tim Janik

---
http://timj.testbit.eu/ - Free software Author
