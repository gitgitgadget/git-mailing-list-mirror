From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Mon, 28 Feb 2011 13:37:54 +0700
Message-ID: <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org> <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 07:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtwkY-00051J-Q5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab1B1Gi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 01:38:26 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41927 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1B1GiZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 01:38:25 -0500
Received: by wyg36 with SMTP id 36so3311620wyg.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 22:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=v+QkHtNs4Uj5woMSCy1p9uTefxASLyzTG+4Wnxp+R8A=;
        b=bLXX1dww9FD19Qk6S8+lX9LSq4JBt+0etD97jNtCmn52xiG9G5JpGIkq4CJgnHAc+g
         xTXvtSme+cQAR8wtyi8faLoXM39xV84AhA8YI24BT5hPSjKJBO/u90hxKyqbYCGG3WfJ
         KzAqXvOQ74KVUOcUBcvm51hkc0AEvMv2UlqNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lRf8nl3zRMGurlWGeuf8rqbJIrEsx0MFooOd3ddAkaf5jvmryA9u3/cMN8DO3HAH9t
         JX0sqx88oBzDzt8A6tYVRQgTZqcSC0/E9cW7Djz6I6m8Al5iYXVffmljlC1LBOiP3KHU
         VPPS6JnXE/DFJayVWPj7qkFK+R3W0jvK4TLkE=
Received: by 10.216.163.69 with SMTP id z47mr4549574wek.43.1298875104132; Sun,
 27 Feb 2011 22:38:24 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Sun, 27 Feb 2011 22:37:54 -0800 (PST)
In-Reply-To: <7vy6512rnb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168068>

On Mon, Feb 28, 2011 at 2:39 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>> There's a problem. I use git on many machines. Some will have this
>> config enabled, some will not (yet). Perhaps a third option, which
>> will print something when "git add -u" is issued as a reminder?
>
> Such a warning would not help you on a machine that does not even hav=
e git
> with Step 1 change.
>
> What you conceive as a problem is just a reminder that any incompatib=
le
> change you plan to add will have pain involved. =C2=A0On two machines=
, one with
> a new feature and the other without the new feature, you would have t=
o
> work differently _or_ you would train yourself to use both versions i=
n a
> compatible way (e.g. when you mean tree-wide, you would cdup, and whe=
n you
> mean cwd, you would explicitly say ".", from the command line). =C2=A0=
That is
> not limited to this particular feature but any incompatible change, n=
o?

No. But I hoped it would help me somehow, or at least remind me to
update git on the machines I touch.
--=20
Duy
