From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 8/8] git-stash: use update-ref --create-reflog instead of creating files
Date: Wed, 08 Jul 2015 00:33:18 -0700
Message-ID: <xmqqio9vyugx.fsf@gitster.dls.corp.google.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	<1436316963-25520-8-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:34:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjrk-00055Y-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291AbbGHHd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:33:56 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34038 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932856AbbGHHdU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:33:20 -0400
Received: by iebmu5 with SMTP id mu5so149770605ieb.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=p6Tg3RPiOuLugXvSbdvJRTbuLDCAk2eSt0mxlirVUKg=;
        b=SOsODlkUdsP4qK3nABPNPeWTzCkMtpzPHMm3Hjkx1ykwCgkWdt+Z46ofunFSKlBkbc
         /A+PF0ZjzkGiKGkEcrXU4W7cArzLy3QVAjM6v372Nj5bfPWaAHL5scDG02PzOywKvoY4
         UXWo8y02x0fWKRrpZyOUqyGYP0A4t8Fnt4lu1jxxSow0F4Q56Fzye9twsXXMWuxsPNzz
         uTJw4yLk0//9gC3MN1Ifhsx/9yoV/ZGd2vSFm73rC7wOllwDBjYGPwfbyb7mY4BWZkbo
         4eEAFu8hM7wmbjZ/xhwg88sq2vMk41S+dBCW7rMIPBLYyt8vAcP3tsz9NfVcbG/A6eTM
         iINQ==
X-Received: by 10.50.143.101 with SMTP id sd5mr41620145igb.44.1436340799583;
        Wed, 08 Jul 2015 00:33:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id c12sm1276013ioj.39.2015.07.08.00.33.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 00:33:19 -0700 (PDT)
In-Reply-To: <1436316963-25520-8-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 7 Jul 2015 20:56:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273646>

By the way, a series with 8 patches, especially that needed more
than a couple of rerolls, deserve a separate cover-letter, if only
to describe what was changed since the previous rounds and pointers
to them to help reviewers.

Thanks.
