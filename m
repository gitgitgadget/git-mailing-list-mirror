From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [1.8.0] perl/Git.pm: moving away from using Error.pm module
Date: Mon, 21 Feb 2011 13:31:19 +0100
Message-ID: <AANLkTimwhYwQz9W3tAa2=Q0nJY8AoZYq=7KeX5O2Ca_G@mail.gmail.com>
References: <201102202346.36410.jnareb@gmail.com>
	<7v4o7xluph.fsf@alter.siamese.dyndns.org>
	<4D624632.80904@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Alex Riesen <raa.lkml@gmail.com>
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrUvW-0008ED-6Y
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab1BUMbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 07:31:37 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40252 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885Ab1BUMbh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 07:31:37 -0500
Received: by fxm17 with SMTP id 17so1406711fxm.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 04:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kMWAexbtLbfH+Sm34QEyQ4FlVVemDNkeIyVj/cLvSRs=;
        b=q/1zx5wpXG2UeE2bzh8u25xlNjecYzr/262N0/TOIrF9+8hsBzq3hovJcv7lqe8s3U
         Z0CaHblX3/XXI5MX85/Ug+svfqCBGkzEGLxT06MfOzBpJffkuWEvCpvSTuMDAxFW0R2q
         lYICqYqofmCNiNIEYuG7i9sKpCIEBKuaMuNsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jsm6Ew8R9usx18YNbSbIJ4Wzq5DZjLbOyn59jIx+x5fXSji4TEOsdord0hFN4TKrgx
         zYDDZYdN1fs4B5Y4q+65pxTDdoC0nt9jC/EOsF4Ia0HnXIN5ZllJcM4r0bSaLtqrga4s
         Yl0Ft4aQlTYZ+giq/GYI7OZX/DfGiMeYefC2E=
Received: by 10.223.54.132 with SMTP id q4mr1764854fag.117.1298291479264; Mon,
 21 Feb 2011 04:31:19 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 21 Feb 2011 04:31:19 -0800 (PST)
In-Reply-To: <4D624632.80904@letterboxes.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167476>

On Mon, Feb 21, 2011 at 12:02, Nick <oinksocket@letterboxes.org> wrote:
> because it is possible that $@ can be modified (say, by a DESTROY met=
hod) before
> the if clause sees it. =C2=A0The former idiom does not stop that, it =
just means your
> exception handler is executed reliably.

Note that that DESTROY clobbering has been fixed in later versions of P=
erl.
