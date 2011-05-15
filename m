From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sun, 15 May 2011 08:08:56 -0500
Message-ID: <20110515130856.GB3178@elie>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
 <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
 <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
 <20110514192154.GA17271@elie>
 <BANLkTin+oceG32Xr9J+f3Kmf05P_MdDgeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Osamu OKANO <okano.osamu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 15:09:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLb4k-00008N-TQ
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 15:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab1EONJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 09:09:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54855 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1EONJB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 09:09:01 -0400
Received: by iwn34 with SMTP id 34so3287563iwn.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1oGRhQd8RAfwtzQ+61a7dCeh1hcQflkaKmQc/MTF1GA=;
        b=GSpb/biwwTvnNMqxogVSFvBt6K2hMRZE5zODEg3o6z5XfDWA5ZGnZiaEVUS5taMwVy
         Z2laR7iAHULgls91FEZpF+4G39aTmJ+oIyT1Usk8oCQvsCFClhjEIiyaGxiwApVJ5z59
         i0YnE/D8cIJx2xT0UCBZjdLQCsTddO03S4U6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SAVZeUW7dCWHEhYOrrKENHAbUapa6rEOPMyfX5C2vUe0TFlLxyE0SNsCFa9eeqQL5n
         ETq8fcYeeYw8HVEjy5SX/0W04u+KxaT3jSgr5dvPGapB8t/ZYvv9ZRKaC5FSO+Hm1b4o
         K+6i97Ih4Zh6wTjDrN1lhAoaRjYZT/7G+KiEU=
Received: by 10.42.108.137 with SMTP id h9mr4043416icp.112.1305464940743;
        Sun, 15 May 2011 06:09:00 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id kw7sm417692icb.7.2011.05.15.06.08.58
        (version=SSLv3 cipher=OTHER);
        Sun, 15 May 2011 06:08:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTin+oceG32Xr9J+f3Kmf05P_MdDgeA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173633>

Hi again,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We went over this for the main gettext series. Not commiting the line
> numbers is unworkable, because it means that users who check out
> git.git can't run msgmerge, because it completely fails without line
> numbers.

Please feel free to ignore my other reply.  You were saying something
helpful there, not just calling me out, and I completely misunderstood.

I assume you were referring to this discussion:

 http://thread.gmane.org/gmane.comp.version-control.git/147973/focus=3D=
148044

I'm confused about the msgmerge comment above.  I'll have to try it.
But anyway, of course I agree with the more important point that not
providing line numbers would make life harder for humans.

> Having a merge strategy to deal with them would be nice, but that can
> be done by using the existing gitattributes config + msgmerge(1) to d=
o
> the work.

I'm still curious about this part, of course.

Thanks,
Jonathan
