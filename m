From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v15 5/7] bisect: introduce --no-checkout support into porcelain.
Date: Thu, 4 Aug 2011 01:32:09 +1000
Message-ID: <CAH3Anrrt-FPqWmDhv0ucQfGKmgVbGLFBE5Pf8ma1LWroydNWLQ@mail.gmail.com>
References: <1312383811-7130-1-git-send-email-jon.seymour@gmail.com>
	<1312383811-7130-6-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 17:32:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QodQd-0002TB-Au
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 17:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab1HCPcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 11:32:11 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60454 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab1HCPcK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 11:32:10 -0400
Received: by vxh35 with SMTP id 35so704221vxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Etwp6Y1j07TZm/Hg31nYOprJ3gtHsWy/9uRyNtJAub4=;
        b=gM/8DFDjJBHK5i0j/hrstMgbgsR+ACDV3fxe9QUs59FcXiAdbf0aRsX9hoKUSMONRy
         4VuQzBmScDgwrtHuW2VFgVfrNaFmJ2ETqG7Y5SMnFsqxk1REHKV5akSBGmSVo5T6Iktn
         gaJeAqPCKE9kzYAKs3wpcqoABdRXybHfl5YBA=
Received: by 10.52.22.19 with SMTP id z19mr1256594vde.499.1312385529116; Wed,
 03 Aug 2011 08:32:09 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 08:32:09 -0700 (PDT)
In-Reply-To: <1312383811-7130-6-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178591>

On Thu, Aug 4, 2011 at 1:03 AM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f "$GIT_DIR/head-name" &&
> -
> - =C2=A0 =C2=A0 =C2=A0 rm -f "$GIT_DIR/BISECT_START"
> + =C2=A0 =C2=A0 =C2=A0 rm -f "$GIT_DIR/BISECT_START" &&
> + =C2=A0 =C2=A0 =C2=A0 git update-ref -d BISECT_HEAD
> =C2=A0}

I'll reverse the order of the last two statements and restore the blank=
 line...

jon.
