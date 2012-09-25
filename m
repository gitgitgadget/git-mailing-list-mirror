From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] add basic lua infrastructure
Date: Tue, 25 Sep 2012 08:55:23 +0700
Message-ID: <CACsJy8ArwPq=YRAddVtC+m8X0+=tndb2-=tmiMS=m2VX3TWGYg@mail.gmail.com>
References: <20120925002325.GA19560@sigill.intra.peff.net> <20120925002511.GB19605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 03:56:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGKNY-00018N-5Q
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 03:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab2IYBzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 21:55:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54371 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab2IYBzy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 21:55:54 -0400
Received: by ieak13 with SMTP id k13so12682612iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l29mMljYUCJKQP5fWj+7AY9jlexJG6x6JMqPksUkw28=;
        b=GUFMtAmEaoMQAL5aWRSYK/g+AB5HtaXiMvi+OmvTgvzn7qqeSLQgAyTVoAHipMF7CV
         NuLNfL/aSwMyqHXBsUh6XG0niVvRukzIJDarM5ESeioUyxf1nryW0HntrOcQvTZxxs3N
         SAhqGRI0G7s9FMalzcrFBRtZpx/U5B7bz8NhtY8LBJgh4KxzfkZNdI6ftBF5TWJtaCg1
         KSXBFnYM3NEogjNyeefDf52vCEEyplTCMau5W7dg+Wg0p/GaDg3o99d2SVRxWO+jRTQ/
         aSb/LI7IyapQJQSfkq74J4uY8bnaGcrjjrfUXiIDZJNmAmj9lr5vfQqFs6aNIgOECnVB
         /xKA==
Received: by 10.50.53.199 with SMTP id d7mr6935447igp.47.1348538153989; Mon,
 24 Sep 2012 18:55:53 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 24 Sep 2012 18:55:23 -0700 (PDT)
In-Reply-To: <20120925002511.GB19605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206342>

On Tue, Sep 25, 2012 at 7:25 AM, Jeff King <peff@peff.net> wrote:
> +ifdef USE_LUA
> +       BASIC_CFLAGS += -DUSE_LUA `pkg-config --cflags lua5.2`
> +       EXTLIBS += `pkg-config --libs lua5.2`
> +endif
> +

I remember we paid noticeable penalty when linking with libcurl to
main git binary and Linus removed libcurl from main git, moving it to
git-http-*. Do we pay similar penalty linking to liblua?
-- 
Duy
