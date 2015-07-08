From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 7/8] update-ref and tag: add --create-reflog arg
Date: Wed, 08 Jul 2015 16:21:39 -0400
Organization: Twitter
Message-ID: <1436386899.4542.16.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	 <1436316963-25520-7-git-send-email-dturner@twopensource.com>
	 <559D293A.9040307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:21:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCvqs-0001re-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbbGHUVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 16:21:48 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33829 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000AbbGHUVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 16:21:43 -0400
Received: by qkeo142 with SMTP id o142so171949657qke.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 13:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=TPOiuyw7PzKAbuHgqktFcsPOxjH1fYABVyLk3P+3/Os=;
        b=lwxEcp4ToHMGf5JSk1PVsc1WoxFrHQIM0+KxkpIS4k/+1Vzg59SbPVBCnbLbvrLKr0
         8PggR6xfszKOvPXPkc7jRj6P+txwtpPQ+MshOHiFSKoiBjej5g0tE/tubyvfaMzS/gzS
         sWfqm7Upq7TcJ4W0edY3eKuM9/FJZEHHjCyBWCzJ9SRTC5HVMMeLYwU+Q39Yx4VYDG0K
         uie7qMDN3HTXGVXNtDwPNY4tx4vKHBPgsXvygQkXsvdDm9CakI9DA7HOZbmwrzg2o5l1
         GodPbTsbF/5LfJ99BNlh8RR2ZKWzbdMaMp4uBpsDjw88Y6WxAQwwQY5aF3mBESYMgKP8
         xycQ==
X-Gm-Message-State: ALoCoQlycDO7Q3gxu2CV5fCZUb5k0t1u9zKEHor84r70XKr3YFlx0UmeuokDGM0AWmLsfOergiRv
X-Received: by 10.140.108.6 with SMTP id i6mr18779765qgf.73.1436386901568;
        Wed, 08 Jul 2015 13:21:41 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id i197sm2020574qhc.36.2015.07.08.13.21.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 13:21:40 -0700 (PDT)
In-Reply-To: <559D293A.9040307@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273706>

On Wed, 2015-07-08 at 15:44 +0200, Michael Haggerty wrote:
<snip>
> Should the "verify" command also create a reflog, at least if the
> reference is not being verified to be missing?

I don't see why it should. "verify" does not sound like a command that
should change anything.
