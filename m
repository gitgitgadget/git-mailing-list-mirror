From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Fri, 19 Feb 2010 14:38:33 +0100
Message-ID: <fabb9a1e1002190538q4600f8c7kb8b2a6345ef3cc33@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com> 
	<4B7E3856.3080609@gmail.com> <fabb9a1e1002182349h923d4acv55d9a41a249d4f51@mail.gmail.com> 
	<loom.20100219T134421-90@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Gabriel <g2p.code@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 14:39:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiT4P-0003s3-V5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 14:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab0BSNiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 08:38:54 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55334 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0BSNix (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 08:38:53 -0500
Received: by pwj8 with SMTP id 8so68514pwj.19
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=WwSxgTjSeBPZLDcjBN590tXFEqaaA9zgRVliUSikHbs=;
        b=YzUlbWIXMz8QmxNnSbBZNNBXCOFz2e4fhBnqxUxb4GJNyavHUVYcSmj9YhFsNrMZeT
         LoaT8ebKtir22qB/HqyWaliTzXJBHw5A0RLsHreg2Q2OZFGKN4ey8DdTj5c8MQe8lg7Q
         Xhu7a5D3qRWLUhjWXOZsHvZuk2yENV1Tj6bsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TbYKqnEe2LsVjuIOC5b2E4eCLzO7tl78eODvmQgjE2TIZdWzKoGxpQN+BT/K05p7jj
         vsmR78VicNXNsFAqIl/UxPg5OnCbpfDUcCccWsrj4sD7mULA07vv1uKdKqTF6rFFK+ci
         YfQf5v8SkKuRn1YNAtMmPte1/je820l1tQudo=
Received: by 10.142.6.11 with SMTP id 11mr7432316wff.88.1266586733130; Fri, 19 
	Feb 2010 05:38:53 -0800 (PST)
In-Reply-To: <loom.20100219T134421-90@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140449>

Heya,

On Fri, Feb 19, 2010 at 13:52, Gabriel <g2p.code@gmail.com> wrote:
> FWIW, I'm interested in that remote-vcs code, but never figured out where it
> was published. TIA for pushing it.

The remote-helpers code is already in git.git, and has been since git
1.6.6 with some improvements now in 1.7.0.

> I'll be using it to better integrate fast-import based backup scripts.

Do you mean that you'll write a remote helper to import your backups?
If so then my code could be useful as a demonstration on how to hook
up a fast-import stream.

-- 
Cheers,

Sverre Rabbelier
