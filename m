From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Core dump on commit
Date: Mon, 15 Aug 2011 14:41:46 +0000
Message-ID: <CAMOZ1BvbNnmqyXmcfUCeJGEcqHR4UkfZhkx1CFJiPLSfnk0CQA@mail.gmail.com>
References: <loom.20110815T162144-798@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Marko Vukovic <amasniko@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 16:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsyMw-0002cR-9m
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 16:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab1HOOmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 10:42:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39036 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1HOOmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 10:42:17 -0400
Received: by gwaa12 with SMTP id a12so3190741gwa.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wbodHRu+0g+T10MZZtV3kMgVnNQZmfWY1Bhr2MooANI=;
        b=BaS0deO/VGyyOp1JA9KHKt1HBt4/Z0XAr85RJ+/uVRPm0Q9i44EVquwauV4athubaN
         z4Fvunsh66zh2HUFa/ZIHBbPbURxG4h8DaZzOI6YnY8vahs2/S9FNdeRxz9yhwf1W65x
         tmuW9PJKNnZswNaV2WfUL0WnVGEcPvEm5UCOY=
Received: by 10.43.44.195 with SMTP id uh3mr4331469icb.196.1313419336082; Mon,
 15 Aug 2011 07:42:16 -0700 (PDT)
Received: by 10.42.174.66 with HTTP; Mon, 15 Aug 2011 07:41:46 -0700 (PDT)
In-Reply-To: <loom.20110815T162144-798@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179368>

On Mon, Aug 15, 2011 at 14:30, Marko Vukovic <amasniko@yahoo.com> wrote:
> error: Object 42504431bac2e2054483c1bbc35f1b535f8d11bb is a tag, not a commit
> Segmentation fault (core dumped)

You found a SHA-1 hash collision!? :-P (but really :-/)
