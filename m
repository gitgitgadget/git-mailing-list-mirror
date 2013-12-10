From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] pull: use merge-base --fork-point when appropriate
Date: Mon, 9 Dec 2013 17:58:51 -0800
Message-ID: <20131210015851.GA2311@google.com>
References: <b208a2edcaf47bf1a97ec19718854dc1b3646828.1386506845.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Dec 10 02:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqCbM-0006fS-B7
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 02:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab3LJB7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 20:59:02 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:33840 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3LJB67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 20:58:59 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so3458509yhz.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 17:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dzejhaMJY30Um3ev9aPyO0olj1AeZB+viuDPa8rXH94=;
        b=B18zwj4jYm7XigWn7MfMxU4NJrFItIEx7ssYWic7GgK76iKTgY3ZlFP6bA9+4UBDa2
         3QtylktQdUc4dN3lelkualsfL6MZgpbkTIPNIqhyrCUVcl+PVcOykt8txpZSoFowfl6Y
         LoSWDxv615MOwATbGKWWODjVhdwkqFFDe1FfRj+2NzuDlG0P9aystrBJXf9yzd8Gl763
         0+pXgxMIHiC7hwqkQBWH143RLfXe+sPqxRxoSUQv+yfkVcOVu3Odxo+tfb5b98B6i9My
         VmkPotOYK9g0Pm6o43/ssRmsx9M5A5/bIcicrp52i4bWyI7lOSmS9nHb1BELE8CeyP3K
         GgoA==
X-Received: by 10.236.125.230 with SMTP id z66mr5442354yhh.104.1386640738450;
        Mon, 09 Dec 2013 17:58:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h66sm20095496yhb.7.2013.12.09.17.58.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 17:58:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b208a2edcaf47bf1a97ec19718854dc1b3646828.1386506845.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239125>

John Keeping wrote:

> Since commit d96855f (merge-base: teach "--fork-point" mode, 2013-10-23)
> we can replace a shell loop in git-pull with a single call to
> git-merge-base.  So let's do so.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-pull.sh | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Yay!  Looks good.
