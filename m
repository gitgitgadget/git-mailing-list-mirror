From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 4 Dec 2009 23:19:17 +0100
Message-ID: <6672d0160912041419s2cbcb8ech49f69250b99386ae@mail.gmail.com>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 04 23:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGgV0-0005kE-EI
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 23:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbZLDWTO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2009 17:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbZLDWTO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 17:19:14 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:37353 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbZLDWTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 17:19:12 -0500
Received: by bwz27 with SMTP id 27so2317465bwz.21
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 14:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ckL+4CRhFfXfKmv6Ku2VjxbxzPTFihC9mpooQV0Irgw=;
        b=lCEleWowivUXklFD6hI/8ULNUl46JRKLus3dqrHBaFZqGmuQVDU5AACvEQp2+Hirm2
         FkbJl308oVz2CKdZD7uwQg7/PETTUAQbNNEOpwl+fLCxIJNe0XiG9/AwxubcjM5pIGwk
         CpggD/5nEdyVPlEuc00eKgBIY3m+3b7R1IX5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J+4IKsbFpnuJJJbmZjaKh6K3mG99rK8YTKYGqeq//Ru9NKhDF/6zl+tW1v7w/vA2lQ
         LWJUeWGM2hqUDRZnMjb/SM09IN1j0yxu3wsDbGNV6lbvqZUy++mKrqrQrVbcnAQBOSMO
         XPfy0qPfaV+7QJnVhFF3YXD8OQNNF6pl+WZfA=
Received: by 10.204.154.69 with SMTP id n5mr3899006bkw.43.1259965157635; Fri, 
	04 Dec 2009 14:19:17 -0800 (PST)
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134580>

On Fri, Dec 4, 2009 at 3:36 PM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:

> If the idea of a "fix" command is acceptable, then I would like to
> implement a further convenience: if a group of commits to be folded
> together includes *only* "fix" commits, then the first log message
> should be used without even opening an editor. =C2=A0But I would like=
 to
> get a reaction to the "fix" command in general before doing so.

I would really prefer that the editor is not entered at all if there
are only "fix" commands in a group of commits to be folded.

> Michael Haggerty (3):
> =C2=A0Better document the original repository layout.
> =C2=A0Set a couple more tags in the original repository.
> =C2=A0Add a command "fix" to rebase --interactive.

Nitpick: the recommended style is to leave out the full stop
at the end of the first line of the commit message.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
