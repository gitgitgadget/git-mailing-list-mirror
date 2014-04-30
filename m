From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] git-completion.zsh: do not clobber complete()
Date: Wed, 30 Apr 2014 00:58:53 -0500
Message-ID: <5360911d8fb6e_597a125b30828@nysa.notmuch>
References: <1392413040-28436-1-git-send-email-lodato@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Lodato <lodato@google.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Mark Lodato <lodato@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 08:09:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfNi2-0001vL-4u
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 08:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbaD3GJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 02:09:31 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:58926 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbaD3GJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 02:09:30 -0400
Received: by mail-yk0-f175.google.com with SMTP id q200so1109491ykb.34
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=w7F4iqCskfs6ZnPovbqRd2bS0ocOnkmIwdn26fBhTWo=;
        b=MzGhOZhPSfAXayGYF0GGEUINJq73sg1S/CZBofR4ovmaSgm0P1iR54o9WuVOVQCAQS
         NwzbQpEO2OoVtn3X/ALyBZm9tFTbq4PCTL9dWMWW4HxJeagp6O8WWg7k1bZvK0yFT9YV
         /lT7e/sj39cFgUjQ7LJE0kiGBB3b1XbB2FYdpz5gt7jPmgN/32q26ObrxZ7eNHeOKZIH
         aLy5lPhzPvMQH8RhW6Wl279rQRU964wOiqU6C/XrS89ZHK2SBpGudKztlnDVkDbdpfw+
         VKxg9y4pcCyHWNX8t1lfOQCCEP7PF3XPCbBn5FWKUrHfCikEGbA/XDLw8C2MYVjItnkP
         YDsA==
X-Received: by 10.236.131.42 with SMTP id l30mr3043352yhi.130.1398838169701;
        Tue, 29 Apr 2014 23:09:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b45sm41148100yhl.31.2014.04.29.23.09.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 23:09:28 -0700 (PDT)
In-Reply-To: <1392413040-28436-1-git-send-email-lodato@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247677>

Mark Lodato wrote:
> Previously, git-completion.zsh redefined complete() to make
> __git_complete() a no-op. This broke zsh's built-in bash completion
> compatibility layer (bashcompinit), which defines its own complete().

How exactly? I'm testing this and I don't see any problems. I run
'type -f _complete' and I get bashcompinit's complete, and the internal
_complete() function is used only by the _git completion.

How have you configured this completion? Are you using the recommended
instructions?

-- 
Felipe Contreras
