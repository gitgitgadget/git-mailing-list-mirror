From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] diff_tree_sha1: skip diff_tree if old == new
Date: Tue, 3 May 2011 14:34:12 +0700
Message-ID: <BANLkTikMhUuog23TJhUT7Km7hPO7On4Apg@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 09:34:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHA8D-0002Z9-8R
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 09:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982Ab1ECHeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 03:34:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45645 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab1ECHen convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 03:34:43 -0400
Received: by bwz15 with SMTP id 15so5286247bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=tvJ+53m+gRTRXrf4KJURK5dFcn0YBMOrWRSvD0SDn94=;
        b=scL/mK76vb3IUxwlDmh42nOefxnTLN7poXEibCIVTSQJYIIeOAkqj9EbbR0gA3JWpC
         Gx7MlgsmGN5B9rqlodIqv4Ymx5y4ApbrIiJZjT3LPH0VSgkFgKqkDbOXZzXNlKM31kV9
         W3UXAy/WpbmaJWMU+D2D4FSVRyxNZS6IwrxVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lK77+VRoC1JGK2pvt6i9GXwtQbXRYjzJ4PH0Oyj7hVZqR/D4ynAsZUgiKUP9DyWuEl
         0KZOJyBjtgfFUiQMFePgboD0WQXnlwujHf2LlJKVZKQhOtynhl4X5ACstLzG3RHScOVF
         0XRqkxeuyeLGL6vL/VdcYk4jw8ZE1CIk/pLT0=
Received: by 10.205.36.65 with SMTP id sz1mr4852984bkb.74.1304408082242; Tue,
 03 May 2011 00:34:42 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Tue, 3 May 2011 00:34:12 -0700 (PDT)
In-Reply-To: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172649>

On Thu, Mar 31, 2011 at 8:37 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> These next few patches are all derived from trying to make operations=
 on this
> repository a bit faster:
> =C2=A0 =C2=A0http://projects.archlinux.org/svntogit/packages.git/
>
> As far as a different shape of repository, this one qualifies. Some s=
tats from
> after running `git gc --prune` and looking at things from count-objec=
ts among
> others:

Does this series need any work to get (at least part of) it in?
--=20
Duy
