From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: add config option for custom instruction format
Date: Mon, 08 Jun 2015 15:17:58 -0700
Message-ID: <xmqq38219755.fsf@gitster.dls.corp.google.com>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:18:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z25Mt-0003bJ-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 00:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbbFHWSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 18:18:03 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36055 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbFHWSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 18:18:01 -0400
Received: by ieclw1 with SMTP id lw1so2912348iec.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=U0i+taPznSz/7FSFHRWKbygZB8t6IlORqZ0qG4FiC/8=;
        b=Jj0jFbRLHfOWfIXyQieImG6+kFVtcfHOpNOFJuB3ODGhVA2U6bwFbEv1x7kcbjwa71
         lTGqTGIfy9ImkGkUyx4AtE1tr/ZjKrjpWgj3au4hf991hYRN7Y4MTDyQKYWrVrRsCXC6
         xayuuTGFMg1G/aAcKj+ND4PTKTJWvPL1MajE1irnyKsxuQnhgZiPiDT7zwXqFPnycyIJ
         nalM1T/O5QGo7Ku9flw2n6xbO59L2s0R1Q+L+SOW8gwbS8VDfC+E5qz80ygRiMt5fpqw
         8JnsvF+muR/4uJN+Pbh6VAwea1CPux40wF/Y0o2bUtS34I6CF5ZJYvXjo75srk1sv5Fd
         Rsgw==
X-Received: by 10.107.159.77 with SMTP id i74mr23675722ioe.9.1433801880413;
        Mon, 08 Jun 2015 15:18:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id qt1sm1283647igb.5.2015.06.08.15.17.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 15:17:59 -0700 (PDT)
In-Reply-To: <1433797202-97425-1-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Mon, 8 Jun 2015 17:00:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271141>

Michael Rappazzo <rappazzo@gmail.com> writes:

> Difference between v1 and v2 of this patch:
>
>     - Fixed indentation from spaces to match the existing style
>     - Changed the prepended sha1 from short (%h) to long (%H)
>     - Used bash variable default when the config option is not present
>
> Michael Rappazzo (1):
>   git-rebase--interactive.sh: add config option for custom instruction
>     format
>
>  git-rebase--interactive.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Does this pass tests?  I see many failures including t3415.
