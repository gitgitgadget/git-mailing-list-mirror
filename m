From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Tue, 15 Feb 2011 22:51:41 +0100
Message-ID: <AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 22:51:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpSoM-0000JK-8E
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 22:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab1BOVvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 16:51:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab1BOVvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 16:51:42 -0500
Received: by fxm20 with SMTP id 20so672326fxm.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 13:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lSuEFtGO3xTyH3cbfk4SOqBtXAsT167wKXFBLvA45LY=;
        b=gKhtndK0RIOdYnfqaxvp/TQLdm3azMpvtn3nUr3h7v6fwqjhWvuGuVWAw0me0vhP/5
         oSY9f1K8nrEU/XG1f+lVFpcp/F9BQTL7HUsid/svQx2xLVcwW3eJLTD6OeCyuHhuoSxH
         RA57i8ET0kPTN4UWZSnoZiswjUXJNGoBaUSsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kslC9z7SU33tFWeGApKcTmaHtNRrEOUoac1W4XL+T3NisZTC60Y0OW69st+Fe383bg
         e/vjss+BK+bGYYStRDz6fm8I468ymFQcYI8YcycgeZTfKOVjFOzu89FYSNYq7fMI3vKC
         xTx4qy8x/NSdwIOeek07KkMX5RKqJ94JoYfOk=
Received: by 10.223.96.12 with SMTP id f12mr2123435fan.79.1297806701216; Tue,
 15 Feb 2011 13:51:41 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Tue, 15 Feb 2011 13:51:41 -0800 (PST)
In-Reply-To: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166882>

On Tue, Feb 15, 2011 at 22:23, Jay Soffian <jaysoffian@gmail.com> wrote:
> The user-experience after a cherry-pick conflicts is suboptimal.
> The user has two choices for committing the resolved state:

I've read this over, haven't run it, but I really like the idea. It
sucks that you have to save away the commit sha1 somwhere after a
failed cherry-pick to use it again. It should just behave like `git
rebase --continue`, which this implements.

It'll need some tests as a non-RFC, but otherwise it looks good.
