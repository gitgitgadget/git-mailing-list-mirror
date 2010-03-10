From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [msysGit] ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 07:58:31 +0100
Message-ID: <46d6db661003092258t22f2ee5ga720f18a859db957@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 10 07:59:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpFsO-0001rm-41
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 07:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab0CJG6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 01:58:35 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:42356 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab0CJG6e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 01:58:34 -0500
Received: by bwz1 with SMTP id 1so4653403bwz.21
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 22:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IOzG2UrHQSpPnw1vcsIFysVQoJE5s2nJLHNuRXkPOpk=;
        b=KkGD/IAVLeZ5kNVh4vGciXlwT4bpGfDKTLyMeDelHHEUI9M3CQClShCIrEtXB/Aywu
         RcO6qk5QUpMtEqkCulKk9ktfW5jcdzhLba18r1u8622BGidbnCR0sAe2i4wlrhBBNYGb
         jU0uuCxSSzQvWvUWrsEEKZKZjFru2qPLrPeYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GTc806zb4Rm46k2wu9tYJjcU0xViamNialsY05TJvXzZhKWToUNFHA+DHzA6AuwrDi
         1UBYisb+056MZiXB6Q+C23PVa79jDeiK3oXz9Oz8LMz5a+K7xKSKHRvbhhNqCGK0GKx9
         jvNMcmn0XJj+WzJvYX+JRW8+xVXXreMZ/Kulk=
Received: by 10.204.33.215 with SMTP id i23mr858564bkd.86.1268204311987; Tue, 
	09 Mar 2010 22:58:31 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2010 at 7:24 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Git Release Notes (Git-1.7.0.2-preview20100309)
> Last update: 9 March 2010
>

thanks to all contributors for the hard work!

> Known issues
>
> - Some commands are not yet supported on Windows and excluded from th=
e
> =A0installation; namely: git archimport, git cvsexportcommit, git
> =A0cvsimport, git cvsserver, git instaweb, git shell.

for instaweb, I will post soon an "how to use mongoose" instead of
Apache. I managed to make it work, so we could propose it in the
installer. What I need to workout is the path with spaces "program
files" which I believe is the only hickup...

> - Substantially speeded up startup time from cmd unless NO_FSTAB_THRE=
AD is
> =A0set (thanks Johannes Sixt).

this is a really fast bash now. I'll try it again with a corporate
machine with many network disks mounted. Nice!


> - .git* files can be associated with the default text editor (issue 3=
97).
>

I was first mislead by this feature. I thought I could also edit
=2Egit/* like config and all...

This one feels weird here on Vista: .gitignore or .gitattributes end
up having no name visible at all on Explorer file view. I can only see
their real names once I fire the editor, on the title bar of the
editor. Is this expected ?

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
