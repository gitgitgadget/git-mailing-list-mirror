From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: mention --notes in more places
Date: Tue, 16 Oct 2012 23:25:01 -0700
Message-ID: <4a445f32-893d-4b27-b056-00b3f036bbaf@email.android.com>
References: <1350443975-19935-1-git-send-email-eblake@redhat.com> <20121017055136.GA12301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 08:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TON4N-0006PI-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 08:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2JQGZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 02:25:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42530 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab2JQGZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 02:25:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so6802975pbb.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 23:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=YVrtrbcX4HvRjK8preRqYkNUs1jkihY3vZBo3Z6+4wQ=;
        b=OEB5qQjyRx1QgEEvWhHbbOOy5GgahB2+UY4j2SQTDKFMbvVpnzpmqJBTS4JPSK4YjM
         2AE3yHelkgMnRkxCZjG0s19aGtguKAafNw/0lo+lV9KFzISsPO4z1h7DGQgGPuywpoOP
         JSo+I306TsfJRpDOkkvVGixEPxSPmp41K2XccLqyAT+64/XSNi5ec2xWfeYPdaHAvG7z
         sxSNRTxurorrxQnqGxE0LiU41lZjq83FW2NGmIwW5yNKe6vZgaBYPIFgMs5UoI5/zrOG
         ouKO/n2F6gENxZ/kBrBhyKMyARcTW3YwlnHYYCEyQy4l+uHOikYUEOZkfUGSWZhOD7qQ
         0S5A==
Received: by 10.68.238.34 with SMTP id vh2mr54273149pbc.6.1350455119202;
        Tue, 16 Oct 2012 23:25:19 -0700 (PDT)
Received: from [192.168.2.111] (c-98-234-214-94.hsd1.ca.comcast.net. [98.234.214.94])
        by mx.google.com with ESMTPS id to8sm12007473pbc.11.2012.10.16.23.25.16
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 23:25:17 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20121017055136.GA12301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207895>

Jeff King <peff@peff.net> wrote:

>It may also make sense to show notes differently when outputting the
>"email" format as format-patch does. E.g., using a triple-dash would
>keep them separate from the commit message when using "git am". Like:
>
>  your commit message
>
>  Signed-off-by: You
>  ---
>  your notes go here
>
>We've talked about it several times, but it's never happened (probably
>because most people don't actually use notes).

It is sometimes scary how we end up saying identical things independently :-) 
