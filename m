From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: introduce "feature notes" command
Date: Wed, 2 Feb 2011 20:57:02 +0100
Message-ID: <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
References: <20110202045826.GC15285@elie> <20110202050735.GE15285@elie> <201102022047.55152.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 02 20:57:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkipq-00076X-GS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 20:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab1BBT5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 14:57:43 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40434 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab1BBT5n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 14:57:43 -0500
Received: by ywe10 with SMTP id 10so167866ywe.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=iov/i8JVdcMGh1uO6w1szZnDkB86jJcJn4OMtVeTKT0=;
        b=KiA7Vi2xK4W1lFR+HQHOW5zZRzPP355JPwb+ncgu2gQeicIPTEYJwfgx2AAZWeT/SL
         WjN6cnHUUUVSjI4rB8WRHd36Xrl2ZXsla7Wcy8Y33GNsy/rSZ0k2ZPGL2XZK5BhinHTo
         r38B7ndo1gOsXn3aopJXK0pY0zMIylUMzI3p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TQQ9xZxEARx5ia8S/q4HX45ZNsMo7K5Wlx+1VTgf5QW93nAibmAtP5i1IgwyKQ7fSX
         T5hQdXHFZu/x93JOAej56+KDn8Cc1RRoOk/cjnB2n7uReJmdW5+YVA2PvvsrYq21KZPD
         1S/gbE2t2jvalDY0ylb08GkL8KP70LQsA/D/s=
Received: by 10.150.138.16 with SMTP id l16mr2285683ybd.283.1296676662339;
 Wed, 02 Feb 2011 11:57:42 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Wed, 2 Feb 2011 11:57:02 -0800 (PST)
In-Reply-To: <201102022047.55152.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165930>

Heya,

On Wed, Feb 2, 2011 at 20:47, Thomas Rast <trast@student.ethz.ch> wrote=
:
> to test, and use notes depending on success. =C2=A0In both cases old =
gits
> will be regarded as incompatible. =C2=A0Or am I missing something?

I agree, old gits breaking on "feature notes", is/should be intended
behavior. Perhaps we can submit a patch to maint to have it (the
oldest git that supports the 'feature' command) recognize 'feature
notes' though?

--=20
Cheers,

Sverre Rabbelier
