From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Bug: "git svn clone" does not honor svn.authorsfile setting
Date: Tue, 10 Nov 2009 14:24:35 +0100
Message-ID: <fabb9a1e0911100524p2cf3f2ebp698ecb50fc53f8e9@mail.gmail.com>
References: <20091110130913.GR19475@poetic.cynic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Curt Sampson <cjs@cynic.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 14:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7qiz-0001Fj-CV
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 14:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZKJNYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 08:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZKJNYv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 08:24:51 -0500
Received: from mail-ew0-f217.google.com ([209.85.219.217]:36033 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZKJNYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 08:24:50 -0500
Received: by ewy17 with SMTP id 17so8001ewy.17
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type;
        bh=RmjBm8+aOrxwDICNegJsd8bPk2aXWk9Kzj+zRB/QXgU=;
        b=Al314QlLzef+YozHrhL16WAR/H+LtyCA+Nz5VnvCfs7ng08XtB19yenQn6KD6N3TpJ
         d9cYdFKA8Ss86eMKFKW2RovRwZw7QSKWYO0SRwBRVNttXot7JwdgtyV40pcGy14JK7Ne
         jvp8v01Ke9mEi5J0Z4UeJkDUDrli4tYpsTjuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=vVgSi8T2upR7rGRu0pgpZ5rY5EpGbNUKgyt8glii3uEL3jWPvwFiSCinjLNbybUA2Q
         P4Zx5a0jFyHyFKupBrwIh6/T6ckqbVXaMMnN9y9ImPUOgF76FWKTcHreVT1nX9X0mrZ6
         6HZkmdvca4aG89bJRFD2oMf2NuXlLxlR4gw+g=
Received: by 10.216.87.209 with SMTP id y59mr26435wee.21.1257859495135; Tue, 
	10 Nov 2009 05:24:55 -0800 (PST)
In-Reply-To: <20091110130913.GR19475@poetic.cynic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132564>

Heya,

On Tue, Nov 10, 2009 at 14:09, Curt Sampson <cjs@cynic.net> wrote:
> [Note that I've set Reply-to to both myself and this list, as I am not
> subscribed to the list. Broken list software and MUAs sometimes don't
> honor this. Check to whom you're replying!]

Please don't. It is custom on the git list to always keep those who
are involved in the conversation cc-ed, adding a Reply-to makes this
difficult.

-- 
Cheers,

Sverre Rabbelier
