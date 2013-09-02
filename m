From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] revision: add --except option
Date: Mon, 2 Sep 2013 01:52:36 -0500
Message-ID: <CAMP44s0UMb9OOqoLnf219UuH9On0O8hvT5oufSSqO_qnPFb_Mg@mail.gmail.com>
References: <1377984383-15770-1-git-send-email-felipe.contreras@gmail.com>
	<52243086.6030102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 02 08:52:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGO0A-0000xe-DQ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab3IBGwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:52:38 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34354 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3IBGwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:52:37 -0400
Received: by mail-la0-f50.google.com with SMTP id es20so3336538lab.9
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i5CG0j83GfPhybIje7Ik9aXsfgxtMVBwoic2M+j094w=;
        b=R7D1FItPivsMjYV8es5zTPAUtJVhZRSClvQGDw6AJHZhe9ZqUtac1rOQjmxoWWa6O5
         Tu0V3dpMXqW7wuAn3AqmV+zkfTrbCibxNB4nS/I44WMYZkD18Zue70f0eSCQjhHj/qBc
         9l3b3xmN2D/Z9PCPQT+oeDNhuJuP9znoA4UdDfj5y+oVLthwxcvxPHaoLkZQmIMQ3Hau
         J1DvkRU3U8dWiNeFUyYD8i7qAui9bv82X7+YTm1tCxYTebadsVCzCjoq4UPZ3Lf/guo5
         tAJfoo6p8wYa/+IT5KLUjwtUkeABtyWOnLw6zYugDYfEPgxkuhfldhbdZ/MFEQ2wzVJY
         ai9A==
X-Received: by 10.152.21.225 with SMTP id y1mr20390608lae.18.1378104756260;
 Sun, 01 Sep 2013 23:52:36 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 1 Sep 2013 23:52:36 -0700 (PDT)
In-Reply-To: <52243086.6030102@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233620>

On Mon, Sep 2, 2013 at 1:30 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:

> It would be better to settle on the meaning of --except before throwing
> back and forth implementations.

I've lost the count of features that get discussed endlessly, and
nobody implements them ever. The implementation should dictate the
behavior, because it doesn't matter if you have described perfect
behavior, and the implementation is nearly impossible. If you
disagree, feel free to write the code.

Talk is cheap, show me the code. -- Linus Torvalds

-- 
Felipe Contreras
