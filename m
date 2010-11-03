From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] clone: Deprecate the --recursive option in favor of --recurse-submodules
Date: Wed, 3 Nov 2010 23:24:30 +0100
Message-ID: <AANLkTinLQdpPC-TYjd_8CAnbPjZFGmnvJ_8X5x-yuuwP@mail.gmail.com>
References: <4CD1ACF7.6040108@web.de> <m3aalqgion.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 23:25:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDllQ-0005Ga-OS
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 23:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab0KCWYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 18:24:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47835 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab0KCWYw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 18:24:52 -0400
Received: by gwj21 with SMTP id 21so887943gwj.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xROXfl70yFYfxvyobVud/qk+TB0ppY7VFF9IFGyYN+s=;
        b=ZwXBWZy85UTC0LeS/zdDo0bpywn8/b7x7BVvCV35uZ7BWy401GUKFHHDxrjv3I4ZYs
         ZJdFQTpd2qtilNDx+nUPDozfp4rOMRya9rD8Xbavm1ya5Oo7t8q8fB8B41ZmG4EC2OJd
         BU9gabjWwOHIV/R1I7WRJhlH+9bmXqUnxwcVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H5CX8A9KMle7G16PI1IUsuwr5AS3CUiq9WRjk5GnfR9elleaq45yY8vnMyDJ40rMvs
         52kDB4W7ttI8+b3sYKArs/lGNxr+9M3+4y+92V5rnwWsyt28LWRgxQmEu5TuUUJvf26v
         EP9mu6ZtKlws+dyPoHPKr8IBX746aUdqXMjZw=
Received: by 10.150.217.7 with SMTP id p7mr2121399ybg.312.1288823090699; Wed,
 03 Nov 2010 15:24:50 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Wed, 3 Nov 2010 15:24:30 -0700 (PDT)
In-Reply-To: <m3aalqgion.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160645>

Heya,

On Wed, Nov 3, 2010 at 23:13, Jakub Narebski <jnareb@gmail.com> wrote:
> Shouldn't we use PARSE_OPT_HIDDEN? =C2=A0Or should it be left for lat=
er?

I assumed we would add PARSE_OPT_HIDDEN in a few releases. Perhaps
that patch should also be sent.

--=20
Cheers,

Sverre Rabbelier
