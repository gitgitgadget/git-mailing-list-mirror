From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/18] git notes merge
Date: Wed, 29 Sep 2010 16:56:28 +0200
Message-ID: <AANLkTi=gL_6ueBvO7URth-rbbHyZLpwYEAMwErh1ciba@mail.gmail.com>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 16:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0y5W-0000sl-EE
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 16:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab0I2O4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 10:56:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44728 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab0I2O4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 10:56:50 -0400
Received: by iwn5 with SMTP id 5so1122593iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MzhmySIfl2I2TrtgRljx+qIVhBZspNVqjHvmwFZzABA=;
        b=m90TNWRD2KiVQg6ZkZv2Y2ttCP5mUF2wC+HP6EGN7pgMlrBeWPX9rbgiths7f5kzK/
         dr1ApN05Z1T7endwqbCpWAS+JRsw3fDX+tM6vabciAIKg2qPAPzigcyZj6qzvFhW+Uxc
         cCTkomkYEBvK27bkAatiwJGUl1QfmLHYckWqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dKqjsPlZV3QAHoBjHmDZMcoWhr018EGO643oTQ5Y2/gy1mUkg1UiPhvKXN3WXRqsSm
         v7sD37wmbz0CmENXDKBWa6q/UbOZCm7hpMLGIbKVVcQNuBkhjCUxN7lmYmfwkjlsYC9Q
         m9/fkyA7gWLZrf8y9/nvIphHMVZT+XPMHM614=
Received: by 10.231.30.76 with SMTP id t12mr1844424ibc.161.1285772209142; Wed,
 29 Sep 2010 07:56:49 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Wed, 29 Sep 2010 07:56:28 -0700 (PDT)
In-Reply-To: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157574>

Heya,

On Wed, Sep 29, 2010 at 02:23, Johan Herland <johan@herland.net> wrote:
> =C2=A0Alternatively, the user can call 'git notes merge --reset' to a=
bort
> =C2=A0the notes merge.

I'm torn, but I think that since we actually can here, we should call
it 'git notes merge --abort'. I know that there's no 'git merge
--abort', but IIRC that's for technical reasons only.

--=20
Cheers,

Sverre Rabbelier
