From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] completion: add completer for status
Date: Mon, 24 Jun 2013 22:58:56 +0530
Message-ID: <CALkWK0ncEVJLQE7ZVL+0-pNF+kS9hz5QwmreYHdoFuCoTTDA5A@mail.gmail.com>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrAaD-0005fV-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab3FXR3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:29:38 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53788 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3FXR3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:29:37 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so25631552iea.31
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A94zWP86nKKILYU4tCJLzJmpqxYu/CpLzK5l0N5ubNQ=;
        b=LS/gjApa7D/U3VQQWmiegT5Tv9015K8p902WwXWXg6E46QOs589jbBU/43meHmJpGT
         C1k3RbC2i3DkoUSw8xSGr/OFtXXWMGf5ho8Gl0rK+mwEVbsIF7WdA2ecQutqQPGuZaEo
         kA0Qa199WRqjSRl3AM7Jx/yL1BFI+8AFn06bq7COQjc+GtSZxWejUsLC4Em0oXZeeVI7
         C5ecZrg9OeH4VlHDYAKXW4PcvWII1GaJjIIk/jJstoT6HZ1XJzjL+u0LtgygKfgtzVYT
         13vaDmBf9dmtwM2AcxT3zjUJtz8KL0QM98Tyk+tT5YEPjVxTxsloHeDhxVy3l/TqWzSR
         QLmQ==
X-Received: by 10.42.190.74 with SMTP id dh10mr12224787icb.35.1372094976995;
 Mon, 24 Jun 2013 10:29:36 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 10:28:56 -0700 (PDT)
In-Reply-To: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228883>

Ramkumar Ramachandra wrote:
> +       __git_complete_index_file

Um, that should be __git_complete_index_file "--cached", I think.
