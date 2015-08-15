From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/4] refs: clean up common_list
Date: Sat, 15 Aug 2015 14:44:13 +0700
Message-ID: <CACsJy8CE8OA7AvT+BTPodRokX7qxAOkbY1UmR4qbtE8rUSoTqQ@mail.gmail.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 09:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQW9E-0007Rr-UG
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 09:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbbHOHon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 03:44:43 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35980 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbHOHon (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 03:44:43 -0400
Received: by obnw1 with SMTP id w1so77543142obn.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5ANw/MjH0cckBl3gDMIT7lPyS2tUEIY/eYA2WKaw3Qk=;
        b=MKQxF2EDdEY2DFUcAyucyLifFfYoqgybtt3FBDQbrViWKB3xb7Pw1w6RSIquir5Sno
         FNiJITF9Vd6keQwihx/1ORgcD/RMhlBOB9jH9fQKpe/h0Qz+htuYzAGlwVbPTyP50dLS
         Wz29i7NZM37h3Tbryzqo3qA/CSLfRaCJXVoI7nnupe8ba7cUf2oTaMnassU2ygjfD/AQ
         kUgkfBkwRCC7P1hae3UMkbbp1wGJqzB+RIn5z2sS46YUUwVvhws4uFi2Jm4QPWMHnh8d
         ztZa+3ZllLcUskgseHNpMeKDNEL78p334wrwntBo7Pd5s5k6eUFtHVZPcF4jLfSOx3EN
         YBaQ==
X-Received: by 10.60.45.244 with SMTP id q20mr26786631oem.32.1439624682578;
 Sat, 15 Aug 2015 00:44:42 -0700 (PDT)
Received: by 10.202.52.6 with HTTP; Sat, 15 Aug 2015 00:44:13 -0700 (PDT)
In-Reply-To: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275979>

On Thu, Aug 13, 2015 at 4:57 AM, David Turner <dturner@twopensource.com> wrote:
> +struct common_dir common_list[] = {
> +       { "branches", 0, 1, 0 },
> +       { "hooks", 0, 1, 0 },
> +       { "info", 0, 1, 0 },
> +       { "info/sparse-checkout", 0, 0, 1 },
> +       { "logs", 1, 1, 0 },
> +       { "logs/HEAD", 1, 1, 1 },
> +       { "lost-found", 0, 1, 0 },
> +       { "objects", 0, 1, 0 },
> +       { "refs", 0, 1, 0 },
> +       { "remotes", 0, 1, 0 },
> +       { "worktrees", 0, 1, 0 },
> +       { "rr-cache", 0, 1, 0 },
> +       { "svn", 0, 1, 0 },
> +       { "config", 0, 0, 0 },
> +       { "gc.pid", 1, 0, 0 },
> +       { "packed-refs", 0, 0, 0 },
> +       { "shallow", 0, 0, 0 },
> +       { NULL, 0, 0, 0 }
>  };

Nit. If you make dirname the last field, we would have aligned
numbers, which might help reading.
-- 
Duy
