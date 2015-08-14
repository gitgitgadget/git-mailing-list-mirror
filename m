From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Fri, 14 Aug 2015 23:47:16 +1200
Message-ID: <CAFOYHZAjvhOJQ1jLvVgOtbWLXfhn-XfKsFuKGR-68_E2D=ASRA@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 13:47:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQDSW-0002nX-Da
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 13:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbbHNLrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 07:47:17 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36553 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbHNLrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 07:47:17 -0400
Received: by igxp17 with SMTP id p17so10134230igx.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FqexqkH7WTtammiiQpdofxd8c98lauv1vbaBDtYmLHU=;
        b=BVDqgvMbBO1RG8kOdrNEYGNDCmLy9zHb10YSPGkhbzp8SSfb3T4S8VHV/2h4sSE2G9
         r33BJg1bHsawkIzgsMgUlpuIQru6Hm3NnvAxkGQeISwqPwDQ1ffkc0q1uzhwWtULkatH
         7akK6jUGQHwRofiHurdIvW4rcRoTSGRiMelDxbnFv8KO5oxBhVcvzzGLmdBcZj9mFVLp
         f1oqJSMFbYNX/SSbyX2eByNSKam1oQ49YmTw7fwGkA7JNOl+8uUVsh9qAmH0NBwNn5O4
         FL5wkTPGtLg9dYzbKMayLXTI5w++XF6fyXDR216dNDAuPSkCp9/6Q2lNqfGyVkPUksil
         crhg==
X-Received: by 10.50.102.68 with SMTP id fm4mr2098523igb.25.1439552836570;
 Fri, 14 Aug 2015 04:47:16 -0700 (PDT)
Received: by 10.79.116.215 with HTTP; Fri, 14 Aug 2015 04:47:16 -0700 (PDT)
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275900>

Bike shedding a little (I've never used the signed push functionality)

On Fri, Aug 14, 2015 at 7:00 AM, Dave Borowitz <dborowitz@google.com> wrote:
> The "if-possible" name and weird tri-state boolean is basically a straw man,
> and I am happy to change if someone has a clearer suggestion.

what about git push --signed={always|if-possible} defaulting to
"always" to be backwards compatible. You might also want to add
--no-signed or --signed=no to override your new config option
