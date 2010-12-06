From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.3.3
Date: Mon, 6 Dec 2010 17:51:18 +0100
Message-ID: <AANLkTikqXU18wpBvB0rLB2OjUrDPyOzJh9fn4ohzLZWc@mail.gmail.com>
References: <7vk4jrppeu.fsf@alter.siamese.dyndns.org>
	<7vy682syya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 17:51:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPeHg-0005i1-DK
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 17:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab0LFQvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 11:51:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47404 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab0LFQvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 11:51:19 -0500
Received: by fxm20 with SMTP id 20so4370512fxm.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l0/R1xbpX8DlzGio5zAN59++Ih4bVMaciImbaa8CBbw=;
        b=nlbOkYjUyXRAI5OGBFLnF/M6nEPro/z8Pm2eipDW6D0iVT+NQllYd63bQXDM/AsED4
         Xpwy2iOrrH4QpwboqJW2PxOHeGvcmwQXH7HzH3aUQ0niqH8cLREk3q0nQWy4HYFHa/bv
         r49ojnot+ZVNSwdAHiCIEkVOv7Dhc5nUDr7Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e6VpBGjFbk8q2uZ3INmgMMOaDQyzOVTJtaTS9iMFP38De9LKdM7vxaTwBfa1eLM92J
         y+/TrzKGMXBsyLbhrrxirPyas2IoYWfFZTr48wriLhTLUCCzO/FcSCytQ6YHSF3RYQC4
         3OBb9ycXxLCcvuSbgbMStPVK87FP+WMEJyG/E=
Received: by 10.223.122.196 with SMTP id m4mr1329395far.123.1291654278634;
 Mon, 06 Dec 2010 08:51:18 -0800 (PST)
Received: by 10.223.74.207 with HTTP; Mon, 6 Dec 2010 08:51:18 -0800 (PST)
In-Reply-To: <7vy682syya.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162998>

On Mon, Dec 6, 2010 at 16:28, Junio C Hamano <gitster@pobox.com> wrote:
> The latest maintenance release Git 1.7.3.3 is available at the
> usual places:

\o/

> =C2=A0* "git-blame" mode (in contrib/emacs) didn't say (require 'form=
at-spec)
> =C2=A0 even though it depends on it; it didn't work with Emacs 22 or =
older
> =C2=A0 unless Gnus is used.

Was it Gnus in particular for some reason. Or just anything that
incidentally loaded format-spec.el ?

emacs.git $ git --no-pager grep "(require 'format-spec)"
lisp/erc/erc-compat.el:(require 'format-spec)
lisp/gnus/gnus-sieve.el:(require 'format-spec)
lisp/gnus/mail-source.el:(require 'format-spec)
lisp/image-dired.el:(require 'format-spec)
lisp/net/tramp-compat.el:  (require 'format-spec)
lisp/org/org-docbook.el:(require 'format-spec)
