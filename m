From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 0/2] Add submodule-support to git archive
Date: Sun, 25 Jan 2009 09:18:06 +0100
Message-ID: <8c5c35580901250018x6827291cj36e6bcb10afa9b27@mail.gmail.com>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
	 <20090125135340.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 09:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR0DN-0001BF-Fi
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 09:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbZAYISJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 03:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbZAYISI
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 03:18:08 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:24205 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZAYISH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 03:18:07 -0500
Received: by wa-out-1112.google.com with SMTP id v33so311334wah.21
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 00:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2322j2LtkfZeo0uEMnm0hzVmeDC72Y4/xWFykesLUUA=;
        b=OmStgrF7YY8DQCxeE05540nOMz/4xGfjabNvm78wP+sWCqi7dbjkyDiVHa2Aor3uHj
         H/dImJnVxFA8+K/bSg5YiHb5S2M/rtS5SDsnpdFMIHWv+DEVU4XBaWf+ldRyy2M6Z7u7
         6IIDFx/jBQpm+awwlbdCdEY8ACkJqL8AGirJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kjXmjflDrk15V/wpGrHmVFKq6JoL0W6zf3NwB47dR/wlYf+zlyjdqmR9gXUuScHxWU
         qrZHKG6j5nq2+QDAgSZhVnVZUzINYBZcxNhULi7Jbgj/CvM4pQLlpdMgGtEA3pV9He8d
         C26kQhglPsZpU8j8qHpjOT8gmyZXMqip6JqGg=
Received: by 10.114.124.1 with SMTP id w1mr6370240wac.135.1232871486236; Sun, 
	25 Jan 2009 00:18:06 -0800 (PST)
In-Reply-To: <20090125135340.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107047>

On Sun, Jan 25, 2009 at 05:53, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> What would I do to try this new series? Fork a branch from Junio's master branch,
> apply your new patches, and merge the result to Junio's next?

Yes, that sounds right (btw: the series is buildt on top of 5dc1308562
(Merge branch 'js/patience-diff') and can be pulled from
git://hjemli.net/pub/git/git lh/traverse-gitlinks).

But before merging with 'next', you'll need to `git revert -m 1 bdf31cbc00`.

--
larsh
