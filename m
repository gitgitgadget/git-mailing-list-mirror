From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/24] Index-v5
Date: Sat, 24 Aug 2013 11:16:07 +0700
Message-ID: <CACsJy8AkvUiJhjYVCuMrNwZPR7AiO-CZFazvOG-mVO=+Qq9O3Q@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 06:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD5Hr-00020j-6c
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 06:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259Ab3HXEQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 00:16:38 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:51410 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3HXEQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 00:16:38 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so1656583oag.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 21:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uCCjN5v++j8vkBkZ/+0Pi/zsiezTtj9JtNHF3a9mNko=;
        b=Qfna/cdZyQQi7PpBsPmmxtSsuBemTzGk0TMXDjFC1mJxmdaEIZM9v6QFh53cHAXYec
         B4r7QeFyk5uDo+PWeyrhzlKjFD8IOI6HL0nGc69vytaahMshTSMfbvkkFTKWKBEMuMlj
         sGwdu/UIgEByfdNESwkvjyGpCYSX4oBhWhdd/FDRxmOYIc9L+GJTJSjd5TZitBjBbmT0
         ky+Q3LzJYc0sD/vpc2hre7arEDnINvglIqKTRcQdYqh/PwjnyO4J/aL4Vi6YG5KwHeWQ
         HW+9NwplFPa3pwaDIqirrD+p25y1Y/scNIPLI2fGe2S6Nu5bpVAt/qmIxSYWDy9/LHIg
         NSYg==
X-Received: by 10.182.153.200 with SMTP id vi8mr2767693obb.27.1377317797714;
 Fri, 23 Aug 2013 21:16:37 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 23 Aug 2013 21:16:07 -0700 (PDT)
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232865>

On Mon, Aug 19, 2013 at 2:41 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Hi,
>
> previous rounds (without api) are at $gmane/202752, $gmane/202923,
> $gmane/203088 and $gmane/203517, the previous rounds with api were at
> $gmane/229732 and $gmane/230210.  Thanks to Duy for reviewing the the
> last round and Junio and Ramsay for additional comments.

I'm done reviewing this version (I neglected the extension writing
patches because after spending hours on the main write patch I don't
want to look at them anymore :p). Now that rc period is over, with a
partial write proof-of-concept, I think it's enough to call Junio's
attention on the series, see if we have any chance of merging it. The
partial write POC is needed to make sure we don't overlook anything,
just support update-index is enough.
-- 
Duy
