From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] remote-helpers: add tests for testgit helper
Date: Mon, 12 Apr 2010 16:26:53 +0200
Message-ID: <h2qfabb9a1e1004120726q350e3361gcfb2b89e6b4bb18a@mail.gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com> 
	<1269881309-19690-8-git-send-email-srabbelier@gmail.com> <20100412142428.GA3839@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:27:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Kbh-0001go-NB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab0DLO1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 10:27:16 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:55524 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0DLO1P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 10:27:15 -0400
Received: by yxe1 with SMTP id 1so2574242yxe.33
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9CBGXjU7Tzs/LOBkPSit5z/evpAZbZuECgHeCLTY1YY=;
        b=Yq6PMYlyH3HixVB/5tCv0GZIiJJyvMSEEqRqfGuLiYb0M/XiIIt9zO1TpewhecB3Ze
         EUPyBQi54lscnWRyXBohTH82oEd/gs1DykdKAvm+W7N88eWfj09GYSOC3zU/CpdvIU11
         fx3B6QKELCiMzuAL525qQ3gStl6IibJ89OOKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=m0H4h7Nu9mOn1+gQi8irciMyrxDaaDWmVj7yW//Dkbo62ZlXJHWwCl/adXWkkqf0k9
         N+jIeZbxmTaW1QZ9nXz/V/cM4IdrQkqGMSa1E+HpJ3thGnAO5GsD5G68cdLE1okRTcSk
         h2NbeStit6VANv79miieiEXdGBqtPx+w4Hzv0=
Received: by 10.100.206.13 with HTTP; Mon, 12 Apr 2010 07:26:53 -0700 (PDT)
In-Reply-To: <20100412142428.GA3839@progeny.tock>
Received: by 10.101.145.4 with SMTP id x4mr7026843ann.11.1271082434541; Mon, 
	12 Apr 2010 07:27:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144733>

Heya,

On Mon, Apr 12, 2010 at 16:24, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Sorry I missed this before. =C2=A0Maybe it would make sense to squash
> something like this in.

Sorry for not thinking of this, thanks for noticing.

--=20
Cheers,

Sverre Rabbelier
