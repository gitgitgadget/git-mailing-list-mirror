From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git sparse checkout repo size
Date: Mon, 18 Jul 2011 18:35:08 +0700
Message-ID: <CACsJy8C=LdcaQbc46ssc5=tTXyA-U4N4FAsqjnPyEqwYZuO4LA@mail.gmail.com>
References: <CALf5Ac223mASO+KGYa3nqB+3eajvRS4QueGT5on6G5kYqhODQQ@mail.gmail.com>
 <CALf5Ac2A4XTfkZraVra2sSGJZJ31bTyfmgHZWjptJNgQtXyH7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: gaoyong pan <pan.gaoyong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 13:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qim73-0004Yj-HC
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 13:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab1GRLfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 07:35:40 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:47226 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab1GRLfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 07:35:39 -0400
Received: by eye22 with SMTP id 22so1233035eye.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nq2tKmVRM0Pw53AJz1wsrw/vHJsEvEQQS+RQmJU/BcE=;
        b=JhYshDcM1ih9PgPoCVk7fsU4eN0TR1hDELjOCleXLNR9mdJ9rJRfY9iIcf7F41+Iqz
         t3mu6jzTzqBpHjya37HWNai0AmHzLSTKUeUGwmY4KicuMx4DFkocK0US76ueOp/qmU3V
         B9wDg1RLWHAk595HsP51Kna3OCdXXeSLWF0E0=
Received: by 10.204.32.129 with SMTP id c1mr1761973bkd.291.1310988938129; Mon,
 18 Jul 2011 04:35:38 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Mon, 18 Jul 2011 04:35:08 -0700 (PDT)
In-Reply-To: <CALf5Ac2A4XTfkZraVra2sSGJZJ31bTyfmgHZWjptJNgQtXyH7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177369>

On Mon, Jul 18, 2011 at 6:29 PM, gaoyong pan <pan.gaoyong@gmail.com> wrote:
> I use sparse checkout to checkout out two small files(8M total) from a
> large repo (~2G), and then check the whole repo size is about 1.2G, it
> reduces about 0.8G repo size, can you tell me how to reduce it much
> more?

If history does not really matter to you, use shallow clone. Sparse
checkout is more about worktree size, not repo size. The ideal
solution would be narrow/sparse clone where you only fetch history of
your two files (plus necessary trees and commits) but that won't come
this year.
-- 
Duy
