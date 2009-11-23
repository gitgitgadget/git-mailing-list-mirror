From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] remote-curl.c: fix rpc_out()
Date: Mon, 23 Nov 2009 06:53:18 +0100
Message-ID: <fabb9a1e0911222153n633ade94w179513d4aa42a3d4@mail.gmail.com>
References: <20091123110338.2b230359.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 06:53:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCRrt-0002lp-9m
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 06:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbZKWFxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 00:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbZKWFxd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 00:53:33 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34135 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbZKWFxc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 00:53:32 -0500
Received: by ewy19 with SMTP id 19so1499485ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 21:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=e+0osDLPGraRYdZladhU3h2FpQE8gfySWmsXEyDeTls=;
        b=gSvXQqqJCxTPMU3zRDml6LNUAJVWqhIwu+yPaBIC0lEF5BuhzfeETNZVDbzHIH60Hm
         rNS1cJcdkJTWxcHh3V8EjUCekV4ZkrlmvE2qK/uuXvf522q8R35q4T3kDoADrhKvfOhn
         UOziC1Ydxulye+nHaigzGyJ68sN77aWElzhZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uPT1hmOHTDamHDj1yAKluJdIiLwWIsOwETPjThzsoXgihyyta8buQA1go6SV+I0exV
         eB7YOpxZ8QYcB2DfLOMxn6GrAnQ31lpCaF43A/z9Si3Mg8Q+UYYInEIYw2lPTZuDevcO
         ee35MhHT0GE+HVzDB9jTiiy0WQc3R1B7Znllg=
Received: by 10.216.93.4 with SMTP id k4mr1353387wef.155.1258955618145; Sun, 
	22 Nov 2009 21:53:38 -0800 (PST)
In-Reply-To: <20091123110338.2b230359.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133482>

Heya,

On Mon, Nov 23, 2009 at 04:03, Tay Ray Chuan <rctay89@gmail.com> wrote:
> =A0remote-curl.c | =A0 17 +++++++++++------
> =A01 files changed, 11 insertions(+), 6 deletions(-)

Seems like this type of patch would do very well with a test case or tw=
o?

--=20
Cheers,

Sverre Rabbelier
