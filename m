From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 3/7] test-bzr.sh, test-hg.sh: prepare for change to
 push.default=simple
Date: Mon, 11 Nov 2013 05:37:24 -0600
Message-ID: <5280c17489798_6841541e7877@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-4-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 12:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfpwI-0006Op-Uy
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 12:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab3KKLpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 06:45:52 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53187 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab3KKLpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 06:45:50 -0500
Received: by mail-oa0-f46.google.com with SMTP id m1so2068243oag.5
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=RoVOlpR19qIZcG2PlUMuKl6McUupgPg/KK97s9f/NKg=;
        b=S7kyARLE3ztOzF448eys46pNaq+uJ2UMyCUr2uFHTbWlBejzTHrwmMy5STO6265NMX
         y2tOa5BkKSAcXiq/vZ2gQvOaz4PPfOFk3avR6qKGCZBiOVxuHJXXTXALK38I81iwZixV
         K8xe6MVq+DOqJ1LPOgD7bWyofo0SrJP3WHV2cSMDD7KiqsYZDvCg4rJrjnwNbFpDQs/R
         Rru254pV9BGhsdVIU6L7yNL6QIYJYASitd88hcZWKjFteNQIlcuV7ZW6zWNTRfEQxfFk
         C9ewo9LcjLRYEoeZHNj8NzxVOfcSX/Umi6DSXVFdA3O3zOI/w/2uF8Y20fUhTyu4dVjE
         +BJQ==
X-Received: by 10.60.60.71 with SMTP id f7mr766681oer.82.1384170350264;
        Mon, 11 Nov 2013 03:45:50 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm25762705obo.7.2013.11.11.03.45.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 03:45:49 -0800 (PST)
In-Reply-To: <1384142712-2936-4-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237610>

Richard Hansen wrote:
> Change 'git push' to 'git push -u <remote> <branch>' in one of the
> test-bzr.sh tests to ensure that the test continues to pass when the
> default value of push.default changes to simple.

This makes sense.

> Also, explicitly set push.default to simple to silence warnings when
> using --verbose.

This doesn't. Run the tests in t/* and you would seen tons and tons of those
warnings, if they should be avoided, they should be avoided for all the tests,
why only these?

I say drop the second part. Yes it's annoying, but we have to deal with it.

-- 
Felipe Contreras
