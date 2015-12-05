From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new repos
Date: Sat, 5 Dec 2015 07:30:13 +0100
Message-ID: <CACsJy8DDKW4np7N+KA=dpz9uNke0+cyQD-J3U74VM=4WbsjrKQ@mail.gmail.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com> <1449102921-7707-14-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 07:31:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a56NE-0006OV-MM
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 07:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbbLEGaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 01:30:52 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35167 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbLEGaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 01:30:46 -0500
Received: by lbbed20 with SMTP id ed20so17386360lbb.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 22:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DraIc9iTY9LJD5iFDMbWq8CI5E2L/qTMH3x1VJHzGTs=;
        b=PaJaQmwIKqSDjWJjeDxD8uYj5xZ47lowTsQXWtkLqlBgJT4mOWi/IvByl/Gy5xJXxl
         7m0zlHinOhXkCSs4lm4Ty4900WrtORlrTGHT4QuHs0oauG5b7LNfaMYTugPPq5HUlIN5
         HpZz0dRG71ToF9fnTUl//p2xZ1BJD9uiIBPggFF3g55QDmAFG+Qnix4l4i4lFdXQxtfE
         aizuNC2Dl6vXqmsfRah+SoPGxsilPwAATSy1McIDAR/l66taiCmH70gHlMS7JGU1UuRW
         x/AznbToFwqyCFIyhpO1YWz5V02IRXB0e6uB/HZo7tbOU96CYXQV6dt9XGidgvjAH0Ga
         tmbg==
X-Received: by 10.112.16.135 with SMTP id g7mr10093536lbd.80.1449297043531;
 Fri, 04 Dec 2015 22:30:43 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Fri, 4 Dec 2015 22:30:13 -0800 (PST)
In-Reply-To: <1449102921-7707-14-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282027>

On Thu, Dec 3, 2015 at 1:35 AM, David Turner <dturner@twopensource.com> wrote:
> git init learns a new argument --refs-backend-type.  Presently, only
> "files" is supported, but later we will add other backends.
>
> When this argument is used, the repository's core.refsBackendType
> configuration value is set, and the refs backend's initdb function is
> used to set up the ref database.

git-init can also be used on existing repos. What happens in that case
if we use --refs-backend-type. Will existing  refs be migrated to the
new backend or hidden away?
-- 
Duy
