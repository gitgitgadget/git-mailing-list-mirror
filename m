From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Smart-http documentation: add example of how to 
	execute from userdir
Date: Thu, 31 Dec 2009 10:18:09 +0800
Message-ID: <be6fef0d0912301818o678976ebqa3e339dc1ff1f2e8@mail.gmail.com>
References: <905315640912272018r1282394fh62d37b5c9e91a234@mail.gmail.com>
	 <1261975612-67101-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 03:19:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQAd1-0004wN-EI
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 03:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZLaCSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 21:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbZLaCSL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 21:18:11 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:48568 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZLaCSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 21:18:10 -0500
Received: by iwn1 with SMTP id 1so8827307iwn.33
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 18:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KYt7rUN+jf0oujG0ComnZam7i2frndMJpYxrVymrtgk=;
        b=U61Af1W1boV/PMXe2wBdEyRlCuACF7H+uw22cac1KZR+yezFbNtHwyAigC8b7Kdp5s
         0ffLFUn+d+uXJ9hwDQAdLgrwHi5T1084GkZO6rlh6LU+63SbOplUj7Pn3jpD66hW2n3G
         KPEEbHPVPEnicf+qsYg7e1kcdGRFvuBm1BrBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R7K74JiMwV6QEnRgK0t0rinhVR7hchh4cmRV+buGysBrPrdX9X3KU/vvmEk4SX2MIE
         /+1JR6AHQp6M+Cqg7zeiRC1pn23g+1As0Js4NW6eS8ywUo5Wvm1Ayx2p1k4RiNQiCaNV
         v+5QdIZ1lvFJZxTs1N6jKKuNfp/6g+JE/X4EM=
Received: by 10.231.9.218 with SMTP id m26mr2602763ibm.29.1262225889526; Wed, 
	30 Dec 2009 18:18:09 -0800 (PST)
In-Reply-To: <1261975612-67101-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135929>

Hi,

On Mon, Dec 28, 2009 at 12:46 PM, Tarmigan Casebolt
<tarmigan+git@gmail.com> wrote:
> Looking at the
> =A0 =A0 =A0 =A0s/update/updates/
> suggestion again, I decided not to make that change because I think
> the original is grammical even if a little bit awkward. =A0The first
> 'updates' is the noun, so the verb should be 'update' without an 's'.

Indeed.

> I also tried rephrasing that sentence completely, but did not end up
> with something better. ?Suggestions welcome.

My attempt is found below.

> +In the following example, a repository at

I was thinking s/a repository at/the repository/.

> +'/home/$username/devel/foo/bar.git' will be accessible at
> +'http://$hostname/\~$username/cgi-bin/git/foo/bar.git'

You left out a full-stop for this sentence.

> +From UserDir on Apache 2.x::
> + =A0 =A0 =A0 One way to configure 'git-http-backend' to execute and =
serve
> + =A0 =A0 =A0 from a user directory (for example, on a shared hosting
> + =A0 =A0 =A0 provider), is to have a symbolic link named 'git' that =
points
> + =A0 =A0 =A0 from the cgi directory to the 'git-http-backend' execut=
able in
> + =A0 =A0 =A0 libexec. =A0The advantage of the symbolic link is that =
any updates
> + =A0 =A0 =A0 to the installed version of 'git-http-backend' also upd=
ate the
> + =A0 =A0 =A0 version that is run in the userdir.

We could try

  The advantage is that this symbolic link always points to the latest
  installed version; one does not have to make any changes to the
  symbolic link when the installed 'git-http-backend' is updated.

I thought the corollary (after the ';') was a bit long-winded, but it
explains the advantage more clearly.

--=20
Cheers,
Ray Chuan
