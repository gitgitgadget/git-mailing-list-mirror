From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2010, #06; Tue, 23)
Date: Wed, 24 Feb 2010 10:06:33 +0800
Message-ID: <be6fef0d1002231806m4e833927o34626c6ba2a16c5c@mail.gmail.com>
References: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 03:06:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk6e7-0007Im-ME
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 03:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab0BXCGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 21:06:34 -0500
Received: from mail-iw0-f177.google.com ([209.85.223.177]:44976 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab0BXCGd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 21:06:33 -0500
Received: by iwn7 with SMTP id 7so3740172iwn.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 18:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8AHiVXIQlEAME8eFI7AWBtANZ0FxYWQRVAZmNqHyYr0=;
        b=Cg93Ikbi32XhCm1wcf4IHk/DliL8jksbzBVlA5oJ5Xth0Bx5TrHYaveKdkLq1jjVbQ
         zb3h7pqALlW02+/7yilMjqlghbILFU7cLLokQK8wCXdb0qsUvt5Mo1gpjt1/7dWKn+JO
         wYz2Ge4S32qcrE18FwJo3Zf1FEtC4PoA/eRJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jY6VcslIjYETlmMDi98dYYhKY0sCUYlBl9n3od9Ydj9oVmM87F3BHhwGE2jlj11PRd
         +VIPc7LEHO7I2E7fkZckwi2EtJCxJpMMmy9z1AGLfSG0HhdUPQGucfq9ziL827E5BAd8
         TTQp1H+fhMYUB3SZgMWMJZ3juDIdofJbQnsVY=
Received: by 10.231.154.77 with SMTP id n13mr684887ibw.11.1266977193144; Tue, 
	23 Feb 2010 18:06:33 -0800 (PST)
In-Reply-To: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140889>

Hi,

On Wed, Feb 24, 2010 at 9:20 AM, Junio C Hamano <junio@pobox.com> wrote=
:
> * tc/transport-verbosity (2010-02-18) 9 commits
> =A0- transport: update flags to be in running order
> =A0- pull: learn --progress
> =A0- fetch: learn --progress
> =A0- push: learn --progress
> =A0- transport->progress: use flag authoritatively
> =A0- clone: support multiple levels of verbosity
> =A0- push: support multiple levels of verbosity
> =A0- fetch: refactor verbosity option handling into transport.[ch]
> =A0- Documentation/git-push.txt: put --quiet before --verbose
>
> Didn't look very carefully. =A0Comments from transport people are ver=
y much
> appreciated before moving this forward.

the only issue was with documentation (how to mention verbosity
options). I'll be sending in a re-roll soon.

--=20
Cheers,
Ray Chuan
