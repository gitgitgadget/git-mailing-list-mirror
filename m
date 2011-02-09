From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Column output
Date: Wed, 9 Feb 2011 12:59:22 +0700
Message-ID: <AANLkTik+siMEgLu9NnhjPttwqsexMwHnHLBJGoCfVxHW@mail.gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <20110208224745.GA14190@sigill.intra.peff.net> <AANLkTi=WKnj8M2Uh+ACSay1STgOhWAjQbmspYSja3y0+@mail.gmail.com>
 <20110209054210.GA2019@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 07:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn35s-0006yL-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 07:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab1BIF7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 00:59:54 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40581 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1BIF7y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 00:59:54 -0500
Received: by wyb28 with SMTP id 28so6551826wyb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 21:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=iU0jFZq3+Sly6L7A1zWSrpCiuJ8xSkLBDnaHmM1TbVg=;
        b=Xkik4o1EYZ8k8U8I2qVgGsy432jHenuGTbyd7TVCpc0q409X2CCiYWm/2gVHGpU6Wb
         JWyc9VfKXvqX/0NkEL3NWyERcKoT39uUpV8NoadRt64DEvw4SsLOoEK1r1g9dhttakr3
         K84j4yVeLwtQWyjzSDFchRUzGVxzrKUw062hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Yn957EaOruth/STtN60rCtZsk61TCdm8xluAVFKKI/CKBBDqy3BH638qLVbP2/faA1
         zwTjRSIdykre8WBh6qp9Ghu5xOqJ4oYKvMDhQjK+7uPqykBW5QrmY+WGpEntvd/2RUKG
         zAuJkoifaUkOV5QvC4bWUo9nfjEu3TMIg6lbs=
Received: by 10.216.87.130 with SMTP id y2mr16618283wee.58.1297231192690; Tue,
 08 Feb 2011 21:59:52 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Tue, 8 Feb 2011 21:59:22 -0800 (PST)
In-Reply-To: <20110209054210.GA2019@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166393>

On Wed, Feb 9, 2011 at 12:42 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Some general reflections.
>
> Nguyen Thai Ngoc Duy wrote:
>> 2011/2/9 Jeff King <peff@peff.net>:
>
>>> I don't really care for column output myself,
>
> Me neither. =C2=A0I tricked myself into reading with a vague hope tha=
t it
> might lead to a porcelain-level "git ls" command.

Wait for it. I have something hackish but usable. Non-recursive,
colorized column output. Not full of feature as GNU ls though (for
example, sorting by date can't be implemented).
--=20
Duy
