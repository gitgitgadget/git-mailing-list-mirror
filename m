From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Detect merge/rebase conflicts without changing the worktree?
Date: Thu, 28 Oct 2010 12:01:34 +0200
Message-ID: <AANLkTim8X1nwgMPLWme6s0KRUCZVDzUPYhgSbkrChN6D@mail.gmail.com>
References: <AANLkTikuyGcK-j_hT2WxJiYVX784nPehZS8=F05N_eGQ@mail.gmail.com>
	<20101028000115.GC30490@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 12:01:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBPIm-0005zY-AY
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 12:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0J1KBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 06:01:37 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35705 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab0J1KBf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 06:01:35 -0400
Received: by qyk12 with SMTP id 12so5271797qyk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+m5XtUC2uEtNwjyOtwfsLiK3Z4tEYuWw5YeidYrTpTI=;
        b=sN6pxoOHgFGHQ6sWCno8Bu9TxeP+MkfjNXs/E/v8dfCP1qvi6jpu/OmWHMGGO+8MPr
         1qcmOtE3X2fV1bFYYY4C+BG+FkQHweDKWZ4xcPJuOXaV6fgy6lOUC+VZxt+JsnEwauLX
         c9MWA7FxgIbd60SoDNdXuNy7sTfY7hW09ZTjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=suSd8bOoOxqqtIsFLhuisErPXkNFbWL4Ea/1XbqPMLHgIV8FZiuowtkE3WKSO9HPdh
         rtP5H9F6grCKpVetBZg+EkEfhbbRfqwkPMCTp0ymXHZhFH0F5jKVbqtV6Hxyi7E3dLUw
         pXN6agfn/Ls8p9/mCDzHUf1FZkgbzCK9PqMcw=
Received: by 10.229.233.19 with SMTP id jw19mr5295311qcb.7.1288260094733; Thu,
 28 Oct 2010 03:01:34 -0700 (PDT)
Received: by 10.229.182.209 with HTTP; Thu, 28 Oct 2010 03:01:34 -0700 (PDT)
In-Reply-To: <20101028000115.GC30490@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160167>

Thank you. I don't know how I missed that one  :-~

On Thu, Oct 28, 2010 at 2:01 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Klas,
>
> Klas Lindberg wrote:
>
>> What is the recommended way to detect merge/rebase conflicts without
>> actually modifying the worktree?
>
> You might like "git merge-tree".
>
