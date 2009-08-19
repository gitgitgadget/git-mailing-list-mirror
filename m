From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 12:53:42 -0700
Message-ID: <8c9a060908191253q2ad30056vc26227cfe7bb438@mail.gmail.com>
References: <m33a7noc3u.fsf@localhost.localdomain> <4a8c51f5@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdrEa-0006PJ-4q
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 21:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbZHSTyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 15:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbZHSTyB
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 15:54:01 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:5823 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZHSTyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 15:54:01 -0400
Received: by an-out-0708.google.com with SMTP id d40so4053640and.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cvRiTDjVb3XwtwWqvET8lhBe7p3zbFbuNhJJGYXyf/Y=;
        b=X7/hrBMAzUPSmG7GnnvbAzqu/t5gg/HzjDxFw5NFQ6ewXKGRmzL8R9yQ4YCgL0sD6K
         3PwVXErwOUCIr1rluTRD+8l8xWSO22pxz/a6z7w+xBDeIe6lAajlRhtXngFuB0IJhVaK
         ttzqzbKCE0G32I9Y30vu0TrKx7eLvmU7nirIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SiafqmblNGDlwYYo1/FwHdcAKtY+QO5ose91RRe3HVJckW4MptA9Y+QznaRpQQL32E
         SB4C25zxrfjj/1cmI8ICjAowFnrZ4I/9YetOigz6dDOSPPI0EYQKvNrxtKxsxklCmOCZ
         1YaFqqmR3Nz003HY65mGUqoomfY1oaaDT2E20=
Received: by 10.101.126.10 with SMTP id d10mr7633482ann.147.1250711642104; 
	Wed, 19 Aug 2009 12:54:02 -0700 (PDT)
In-Reply-To: <4a8c51f5@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126579>

On Wed, Aug 19, 2009 at 12:45, Ingo Brueckl<ib@wupperonline.de> wrote:
>
> But as software development often is something where you are coding on
> several issues at the same time which can't be committed immediately, it
> sounds that 'stash' is the developer's best friend.
>
> Ingo
>

There is no problem with having temporary commits on local branches,
however.

Quite frequently, I'll "git commit -a -m 'Temp commit'; git checkout
other-branch".  As long as you don't make these temporary commits
public, it's very easy to munge them (See: "git rebase --interactive
<commitish>", and "git reset --soft <commitish>").

-Jacob
