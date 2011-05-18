From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Is there a debug mode for git-clone https traffic?
Date: Wed, 18 May 2011 13:29:27 +0800
Message-ID: <BANLkTinmoJA6tZDaGD9K9cBm_dbmti=P=w@mail.gmail.com>
References: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 07:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMZK9-0002OO-8D
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 07:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab1ERF32 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 01:29:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40701 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1ERF31 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 01:29:27 -0400
Received: by iyb14 with SMTP id 14so1017278iyb.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2KXGQYcCAoyv6mXnO0yhu3x/J8UOtnlrybYTb6WiEjA=;
        b=tid047Tw2qRDe1I8ccyzOWy6ISC0YS2C0yQ8xs2L5VsMNnA1a7a+O6Lb7jtPMS2p/4
         3l3ccC59rcOsVUYWOD4jj03SLCupQ9R567z2yHI5j7MZYCn/A2irJvD8jMF6oXVRNjwm
         TdEH6bZKNzOe9kK15F9SAqpYhQrMnh7lr8MXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TPXryONgx2uXlay0mZoJtMP1YJkAZ2BxSSEGpk/eLDiyzNdJ7QRkDsIETaWkjaLGkg
         FlVAPbAkKizEVQTVptuekHpLgjzNPuQ6RZ9uISidR+1qy/rpnof1i0KokZs47gNoB28v
         fM5++Wk7B7VfYm4W1J+wM48jYcN29Ajh4gJ+k=
Received: by 10.42.219.65 with SMTP id ht1mr1855807icb.14.1305696567258; Tue,
 17 May 2011 22:29:27 -0700 (PDT)
Received: by 10.42.5.17 with HTTP; Tue, 17 May 2011 22:29:27 -0700 (PDT)
In-Reply-To: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173846>

On Wed, May 18, 2011 at 7:08 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
>
> I''m trying to debug a problem where over a https proxy I have
> "warning: remote HEAD refers to nonexistent ref, unable to checkout."
> when doing git-clone.
>
> I suspect that it might be an overzealous security scanner sitting in
> the middle.
>
> Is there some debugging mode for git-clone where it'll dump the
> traffic being sent over the wire that I could use to confirm this?

Run the process with GIT_CURL_VERBOSE=3D1. There's also another option
to debug communication between transport helpers but I forget what it
is.

--
Cheers,
Ray Chuan
