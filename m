From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Automatically remote prune
Date: Thu, 5 Nov 2009 18:09:03 -0500
Message-ID: <76718490911051509r65af2dd2k2574e2e521fed6f2@mail.gmail.com>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
	 <7v639qi2un.fsf@alter.siamese.dyndns.org>
	 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
	 <7viqdpemki.fsf@alter.siamese.dyndns.org>
	 <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
	 <7v3a4sagau.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 00:09:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6BS3-0001cJ-OX
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 00:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbZKEXI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 18:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbZKEXI7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 18:08:59 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:43145 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbZKEXI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 18:08:58 -0500
Received: by iwn10 with SMTP id 10so436843iwn.4
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 15:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=B4to9bH0MJYsKTjY70il7J48HDDxsq8GWZNjB7etAug=;
        b=pPPqGenlsNP8K+4tkQyntvn02QnQu2FHmaEedJNUA527smbkiMahrYao/H2Q2TMvS0
         yoORORwWjh6fADzHxWg3pIHVHEI8OokeAZI1pprYnaBgm2n2zFlrKKT3iwTBMPBP+K2R
         L3WduOdhsn9eHuWHE9/RvlI9kqcw+pxL7V1R4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=u52Ui+VuyV45HfkYS6u6grhKOAbJpbHsjnr4Zza6rq2zQoC7v05UirHsiu2QMsVcPq
         W+nQUwZjyoRdpxeEuEJO29ch9rPfgyD8VJcnqOC9znziBm7HfCT5G4cAo2G6gU2I16JT
         1VZ8qpS7dTpTokSiJIPVESprrb5WUfsvdbnmE=
Received: by 10.231.170.201 with SMTP id e9mr3016237ibz.17.1257462543210; Thu, 
	05 Nov 2009 15:09:03 -0800 (PST)
In-Reply-To: <7v3a4sagau.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132251>

On Thu, Nov 5, 2009 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The necessary change to "git fetch" shouldn't be too hard to code, as we
> are already doing this in mirror mode.

Actually, mirror mode applies to push only. Unless I'm missing
something obvious.

Thus, adding prune to builtin-fetch duplicates the logic from
builtin-remote, unless I do some refactoring. Hmph, I was hoping for a
15 minute patch. :-(

j.
