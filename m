From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull with "no common commits" : danger?
Date: Thu, 8 Apr 2010 15:46:30 -0400
Message-ID: <r2m3abd05a91004081246x35f9c674m6f4e379255513c80@mail.gmail.com>
References: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com> 
	<7v1veq8nyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 21:47:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzxgy-0006up-TQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 21:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238Ab0DHTqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 15:46:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58617 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821Ab0DHTqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 15:46:52 -0400
Received: by wyb39 with SMTP id 39so157723wyb.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=MYKnPZ1ZGuy5molDKhoELrvXk+Rp1rL91asCxOq6bzY=;
        b=ZwJgQTFrXJsSpmdSQwB7UyQ5tN7mdt/GqliFLncY37hCq+M/MslvUnh7Tk8t85ST/j
         We6g1iZlCKwiXtIphaTz+HOXh3zZIKkH+K3QmBt7D1RjpplVdu8cef98I47he5NeUfbW
         XuzusDI3a1KREy3amTmU9v9YBk5/8iILEefNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dYIpGV4NptU7HH3W0PvP422XqyRustfMMIBRZVlUN/65Y42MITnAYwCkuBKBZFoPvC
         qwzhuVe2stut2UKFvc/8lnSrNNF/VnVoe3oga/TAtYUzgHhQOJ5gmn7yH77SBYonbDx6
         ekXX381jsXdo37TLDD93rD0IxqvFMVbWmNhcM=
Received: by 10.216.170.8 with HTTP; Thu, 8 Apr 2010 12:46:30 -0700 (PDT)
In-Reply-To: <7v1veq8nyf.fsf@alter.siamese.dyndns.org>
Received: by 10.216.188.14 with SMTP id z14mr311648wem.38.1270756010266; Thu, 
	08 Apr 2010 12:46:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144375>

Junio C Hamano <gitster@pobox.com> writes:

>
> ...
>
> But I would be unhappy if I have to be the one to hear complaints from
> newbies who are now forced to add an obscure option to his "git pull" in
> the second case.
>
> So this is not so cut-and-dried from the usability point of view as you
> seem to think.

I understand your reasoning for the second case, and the init/pull sequence
is something I used to do too. Thanks for the explanations.

Regarding this init/pull sequence: it might be nice to print something like:

  Merging with an empty tree,  'git clone' intended ?

I see more and more such messages when using various git commands, it
helps a lot.

  -- aghiles
