From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Commit ID of a branch
Date: Mon, 16 Aug 2010 21:50:32 +0000
Message-ID: <AANLkTik0FFHCdMTa_MDpdg-df2fAkpKgyVyRUCuhZ5=c@mail.gmail.com>
References: <loom.20100816T231539-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Guillermo <guillermog@tricuspide.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 23:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol7Zo-0008PH-FF
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 23:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab0HPVuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 17:50:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60952 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab0HPVue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 17:50:34 -0400
Received: by fxm13 with SMTP id 13so3156819fxm.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 14:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tkHvtCriHsgMIuDcRnGoph35wWTmkzvcD+OIveEJDk8=;
        b=WWTqnwD+W7ZnM9vTFIE1Wvb8iD9z27pcVVPPVRoxHIBSjkIYldzXVzrPvXwKAw+CeH
         U6pIaby5RW4WPHghuDa0mN+VHNn6wlELNBicmt2M1NvLh4fGO/kcP8iXT6hXsEPidsoD
         AJq22/ZxO0zotBQG0eJxNzjGmIgxyQz4ElZAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bWiCBwnOpW6zNMnC1A07h7y6yHx6rGpvsER1TpmXU0VN/ZD2zPYhV2ZVmi8NIDd4Bs
         cNoWd2x4QOz1JqRV3vtTwhViC1UIhxqk+zM8dDbAmkw5Eg2494A7Tte4GTgkKwU/n9/B
         xE6eeIpWVWlFzOUzSERqZsrS4zVV10fzpm+ys=
Received: by 10.223.113.5 with SMTP id y5mr5646990fap.93.1281995432488; Mon,
 16 Aug 2010 14:50:32 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 16 Aug 2010 14:50:32 -0700 (PDT)
In-Reply-To: <loom.20100816T231539-211@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153679>

On Mon, Aug 16, 2010 at 21:19, Guillermo <guillermog@tricuspide.com> wrote:
> Hello,
>
> I want to write a script what checks in all my projects which is the submodule
> commit that is registered in every git repo.
>
> Lets say we have the following structure:
>
> project1
> - submodule1
> project2
> - submodule1
>
> I want to find out what file within the .git dir of every project contains the
> proper submodule Commit ID that should be checkout with git submodule update.

That ID is stored in a tree object, See e.g. git-ls-tree for how to get it.
