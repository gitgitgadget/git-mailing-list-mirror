From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: hg2git error
Date: Sun, 24 May 2009 20:20:04 +0200
Message-ID: <fabb9a1e0905241120v65adf9f9u7b8d212e99d7f6cd@mail.gmail.com>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de> 
	<fabb9a1e0905241038x7ea22622k930f50b9c7598c6e@mail.gmail.com> 
	<alpine.DEB.1.00.0905242013080.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rocco Rutte <pdmef@gmx.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 24 20:21:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8IJb-0001iS-4J
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 20:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbZEXSUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 14:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754637AbZEXSUY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 14:20:24 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:57566 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZEXSUX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 14:20:23 -0400
Received: by ewy24 with SMTP id 24so2713583ewy.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WFmPJSWARQPxyzNZ13H20k02hcs814Bo+7wTDs5nZp4=;
        b=C86QyK/lTYkCnj87L3D3dRYSIauQSyY7JvwwHuN5jl64PnTKuyXvDtLJ52HMq7YCMo
         tmImameNRs3HBCeepF+VD5h2SZgS3A9+loIlONKzX/N7a6T4f7OY+/iH1aei0DDZgOop
         EMwKifJ15Yo32tZb3zTawYmD1siMIakYqfGb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AuAdcCYosbQ7hw7CfL2Iavv2jq47H2jhUkBCDUqmIiD5oFKJxCDYlEveDmRnbWI2la
         isT2yi6wpFrXqF9YFadJs1H6Jz8TrR587NvTuF/QVJC6xF40F7Kdto1YrW7u/v69mMZZ
         Qv3ggxLWtDdzSVwyvK+uqlrl9SJsa+fBj5H9s=
Received: by 10.216.52.194 with SMTP id e44mr1201588wec.34.1243189224085; Sun, 
	24 May 2009 11:20:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905242013080.26154@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119850>

Heya,

On Sun, May 24, 2009 at 20:16, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> It says "Achtung! Alpha!". =A0How alpha is it?

I'm using it to work on Melange, the problems I've had with it so far
have all been fixed :).

> Also, there is the issue that it is a Hg extension. =A0My experience =
with
> such extensions and their dependency on certain Hg versions make me a=
sk:
> what version of Hg must I install before I can use Hg-git?

Right, you will need to have hg installed to bridge between git and
hg, I think the current requirements are 'python 2.5' and 'hg 1.2' but
that's mostly because that's what we're testing, not because we depend
on specific features.

--=20
Cheers,

Sverre Rabbelier
