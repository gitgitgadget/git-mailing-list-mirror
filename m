From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 0/6] Make "git show -s" easier to discover for users
Date: Tue, 16 Jul 2013 10:46:36 -0700
Message-ID: <20130716174636.GJ14690@google.com>
References: <20130715185843.GH14690@google.com>
 <1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 16 19:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz9L3-0003CW-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 19:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933625Ab3GPRqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 13:46:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:59643 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933158Ab3GPRqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 13:46:40 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so1018382pab.36
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9RpRcvcJhHmheJknttZ5lnUna0wMlPaCjikM/QyOWNA=;
        b=jqbiPh/k31cKqPG+BCfBiUp6AbZrU8YGIi+6M1qafBFEYYcAG0j5At8OEq6jrnMYHv
         bv1Gc8j87HacNcyLAms7E0GDE12o71b0DWDoRmbt1WD12Yq40nlW156Y68wJII/l288Z
         mP1sNypXne2zZiBi0SCGDF6M7lzq9f/Mtozcg9UiKKNCZp80xh0VmNU89r6rOV1W+HLL
         muIHD5iP6CZYQnpHpDjpa/AUBATxXXybEZAJbAx8rJedHhKndLleeH7ge2EQJ/gr4ld0
         wrtgrsHVedJQ+GuHNCFInbv/TIBr173LGWP8ObYFmoTDMkqg4a5llwqZXN33FAp1HtWB
         1UCQ==
X-Received: by 10.68.99.98 with SMTP id ep2mr2693817pbb.6.1373996799990;
        Tue, 16 Jul 2013 10:46:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kq2sm5494253pab.19.2013.07.16.10.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 10:46:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230566>

Matthieu Moy wrote:

> Matthieu Moy (6):
>   t4000-diff-format.sh: modernize style
>   diff: allow --no-patch as synonym for -s
>   diff: allow --patch & cie to override -s/--no-patch
>   Documentation/git-show.txt: include common diff options, like
>     git-log.txt
>   Documentation: move description of -s, --no-patch to diff-options.txt
>   Documentation/git-log.txt: capitalize section names
>
>  Documentation/diff-options.txt     |  5 ++++
>  Documentation/git-log.txt          |  8 +++----
>  Documentation/git-show.txt         |  9 +++++++
>  Documentation/rev-list-options.txt |  3 ---
>  diff.c                             | 30 ++++++++++++++----------
>  t/t4000-diff-format.sh             | 48 +++++++++++++++++++++++++++++++-------
>  6 files changed, 75 insertions(+), 28 deletions(-)

Thanks!  I think this series is ready now.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
