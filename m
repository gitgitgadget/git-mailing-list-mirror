From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/2] Setting git tree of a patch (improved version)
Date: Tue, 25 May 2010 13:26:36 +0100
Message-ID: <AANLkTimgpjn5KZpujtmXfd7UtEfJTg-3UcmIjvFor0bX@mail.gmail.com>
References: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
	 <20100524184908.30884.65042.stgit@sambuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 14:26:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGtDX-0007x7-K9
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 14:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab0EYM0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 08:26:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46405 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab0EYM0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 08:26:38 -0400
Received: by fxm5 with SMTP id 5so3261194fxm.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nF+ZhjoF+TVOZlmsAdnsoToBkoxV8OyC8Xe/v1/nuE8=;
        b=su4VG5+juWUkOzYWusohbxnjd81aUM1KqG+ao+7QWFcbEMQhr+8W38FIhfm7OYkqaf
         5QGNQ44UGyHwjAYqWf7anrvPT6UcL6ASOEafn3B/D6yi+SpQ1z+/0Icm7d11X091TtLn
         UPvbCes8QIyO1JiPT35bqHEkmCwX1f7XQeFRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QwmUqnO8xd7YpnipcpEgvdzajIL1Vhz0uR/M+Np0Y/1zaYBq/tTHJ+LIjUauCor9UL
         Q5dtLPZZ2H1SAL7xJyCWI6yJhkLMcgOnZV1toMnrCCmfUqgSNLcCo5y61XPgmgpXK282
         n6ROiJWPPQJHFBXLnPkjRQT0Iclcktpn/Di5I=
Received: by 10.223.99.78 with SMTP id t14mr2397179fan.85.1274790396712; Tue, 
	25 May 2010 05:26:36 -0700 (PDT)
Received: by 10.223.117.204 with HTTP; Tue, 25 May 2010 05:26:36 -0700 (PDT)
In-Reply-To: <20100524184908.30884.65042.stgit@sambuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147709>

On 24 May 2010 19:52, Gustav H=E5llberg <gustav@gmail.com> wrote:
> I solved (I think) how to accept (and verify the correctness of) a
> tree-ish as argument for 'edit --set-tree'. The first patch in the
> series adds support to Repository.rev_parse() for doing that.
>
> The main (the second) is essentially the same as before.
>
> I moved the --set-tree option to be last in the list of options,
> making it even more obscure-looking.

The patches look fine to me.

Do you want me to merge them directly or I grab them via some git tree
(or Karl's).

Thanks.

--=20
Catalin
