From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Update documentation: git-commit is not a shell command
Date: Sat, 16 Jan 2010 23:37:54 +0530
Message-ID: <f3271551001161007u33aa6bbfu7ad85ed8241695bc@mail.gmail.com>
References: <f3271551001160135k569e2692i5e2ab893701e1738@mail.gmail.com> 
	<7v8wbyc5yb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 19:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWD4O-0002Ei-K8
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab0APSIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 13:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500Ab0APSIP
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:08:15 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55913 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab0APSIO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 13:08:14 -0500
Received: by ywh6 with SMTP id 6so1401142ywh.4
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BfDKgNZNlEH9MPftK+hels7+VqWaB/BaH9TDmQQIYKo=;
        b=H2UVgWMvbaPyfw4Jcaizgnf0EZ40H2Ai74KRfM7zqX6/5aq/Szt7eYHcvlIPurbQg7
         TEShPdQ+bbHLPWI4Bz58+HseFvQeX6q+5fTIoRjmMihWCnR4qSuKh0/VT2rt3TnFge0W
         8xl2i98BSlcCGBMkVsvt9DuuLCZ6eWw3nbzMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qIo3u9LNQC4OtAq3SjRCDh1PnFIN6xxAtzCUfgMFwlawojbMA8z44NjGddo0wEBwn6
         RIFc+oNheFTYQTXo5nZ5IDHSsfNSVLnnBEuhGYW6FL6LXblx/fRVZLqX86DLfN82sFl+
         05G5vhXxLYnUPWJArOJTqYQ42daNciCrkT2Rs=
Received: by 10.90.16.12 with SMTP id 12mr3839766agp.46.1263665294105; Sat, 16 
	Jan 2010 10:08:14 -0800 (PST)
In-Reply-To: <7v8wbyc5yb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137243>

> Actually, I changed my mind. =A0There are many other Porcelain comman=
ds in
> the core tutorial that are no longer scripted. =A0It is better to lea=
ve the
> main text of the tutorial as-is. =A0In the initial part of the docume=
nt,
> mention that many Porcelain commands were scripts back when the docum=
ent
> was written, that the document uses them as examples of how plumbing =
are
> fit together to form them, that some scripted Porcelain implementatio=
ns
> are found in contrib/examples/ directory of the source tree for refer=
ence
> purposes, and that the description of what the plumbing layer command=
s do
> in the document is still valid even though the Porcelain commands men=
tined
> in the document are not implemented in terms of the plumbing commands=
 in
> shell scripts anymore.

Right. Thanks for pointing that out. Here's the patch fixing it:
http://permalink.gmane.org/gmane.comp.version-control.git/137242

-- Ram
