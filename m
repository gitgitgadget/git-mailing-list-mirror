From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 20:16:21 +0200
Message-ID: <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0JFz-0003z5-F3
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 20:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbZJTSQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 14:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbZJTSQR
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 14:16:17 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35977 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbZJTSQR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 14:16:17 -0400
Received: by fxm18 with SMTP id 18so6740676fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z2iCj4UZPUAPO9fxZDjZavCnjGcd+WfJ+hN+9eeJS/o=;
        b=fYxjJyyQlKfs9Gir8yFpffDkpApvrd5F0OyhJ0uCZPGclUI7pbN+ml5Xn3yDbxA2c/
         NmRtqi9wCWosZKV+7rTfI4OeSHoBsOULyePDHt0WZ1BEqK9WpQCfVuJqgl1cD+Vq3htp
         xkAMcmt6cKCE8cIMTcCqLWZWfmrtE9qoBDPc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PoQ42C0ND8A0llPNeVSG7bFQFJtfcGnd6ymxYCYgJQx+zweh9K1wgaP7wriEBof7DD
         mekbq560f00RvV/s4a7wOSfCQwdCvgUVhpxSAjdNctyTq0wVNSdTikySjiqCeawrAJRT
         FJ1TL6mhbteDd3UozOsM1BUQeA44uyNSpKwrA=
Received: by 10.204.25.72 with SMTP id y8mr3062531bkb.129.1256062581151; Tue, 
	20 Oct 2009 11:16:21 -0700 (PDT)
In-Reply-To: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130820>

On Tue, Oct 20, 2009 at 19:24, Eugene Sajine <euguess@gmail.com> wrote:
> I was able to get the $Id$ keyword to show the SHA-1 hash of the file
> content, which is done using ident in gitattributes. Now I=E2=80=99m =
trying to
> find a way to get more info about the file using only this hash.
>
> Could you , please, advise if there is a way to get file name and pat=
h
> inside the repo by having only this Blob hash?

It is not possible.

But you can save the commits hash in your blob. Then you'll have everyt=
hing.
That how git knows it's version.
