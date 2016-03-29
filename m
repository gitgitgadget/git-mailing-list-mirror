From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/19] index-helper, watchman
Date: Tue, 29 Mar 2016 17:51:20 -0400
Organization: Twitter
Message-ID: <1459288280.2976.15.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <56FAB6B2.5000200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 29 23:51:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al1Xu-0005zH-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 23:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbcC2VvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 17:51:24 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:32772 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbcC2VvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 17:51:24 -0400
Received: by mail-qg0-f44.google.com with SMTP id j35so24260344qge.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :mime-version:content-transfer-encoding;
        bh=u0oQ8fMH5mgp3rredu8CKfXQrHKueody08YixolhV4w=;
        b=AzsVRN97oSgMWgCOaQVfPY1S5QhWEr/OdeTet3/u1A9R6L9pIx1w7tsPOB4nX+wfUD
         asH7UD28pP1GSqc6fHdDXXrvY3N1Zzn6Rx6nYImgSmPYX/wVe5AP2pcKYpawuSG6EKtM
         JRm3rujM6xgY3GOVPOgrfko7zgWe0wg7OGN4PDXPhbLBaW8mAaoWa9l3rCjelvFMFrEr
         PY/kBAm41DHICwP0Cm7e5oFJ6lR57MMkaxFJgWYarou48wRxSjDDnZLtttm8zNg7Ega0
         aOIcao/GbahyDrYqEK13sRKE8LWRYDpk7sJbdm6vcx8wibt46dDhzS9xZCeX8BiF2wkL
         1RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=u0oQ8fMH5mgp3rredu8CKfXQrHKueody08YixolhV4w=;
        b=ShU8oWk/OPm0w+0d0A+sQA0m967xCNut23K/B/FiGKkV5g7xQFcQz664fgugSmwdMs
         7h3Fqo89lHV3VigWwcscGS9rrR1QxE1s0vmsLY8N4u8gGXPi8vXKeCHTqa4e50t6WKvo
         fWUVOGhLOcIiSJ9EhZvf8xEE+AOMRxMszLQFrZliGMgkAG5I0onPWcYa5eFVHnhaDlc9
         RhEbxzpd7UcyMfwQhTdSUOcT58Qj82xKRQ+C/hAF3Qx3wsLb/A9JfAKItBY7Fx7O95Pt
         f2I3Zrq0M0VFL6FmGE9lnOpVOtoiKAyIfoO8ajZtOmURyy1+kT4RYMXi1pAZbPgGkV5P
         cbiQ==
X-Gm-Message-State: AD7BkJLAcByVNBiKhhCmCBKF3m2w37P9VZ8P2ZRIMORRcwB61tCCSNsLnB10k+D3S2T6GA==
X-Received: by 10.140.30.8 with SMTP id c8mr5721645qgc.67.1459288282886;
        Tue, 29 Mar 2016 14:51:22 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s188sm353681qhc.35.2016.03.29.14.51.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2016 14:51:21 -0700 (PDT)
In-Reply-To: <56FAB6B2.5000200@web.de>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290199>

On Tue, 2016-03-29 at 19:09 +0200, Torsten B=C3=B6gershausen wrote:
> On 2016-03-09 19.36, David Turner wrote:
> > This is a rebase and extension of Duy's work on git index-helper
> > and
> > watchman support.
> >=20
> Somewhere we need to tweak something:
> t7900 do all fail under Mac OS, because the index-helper is not
> build.
>=20
> The best would be to have a precondition when running the tests ?
>=20
> t7900-index-helper.sh   not ok 1 - index-helper smoke test
> t7900-index-helper.sh   not ok 2 - index-helper creates usable pipe
> file and can
> be killed
> t7900-index-helper.sh   not ok 3 - index-helper will not start if
> already running
> t7900-index-helper.sh   not ok 4 - index-helper is quiet with -
> -autorun
> t7900-index-helper.sh   not ok 5 - index-helper autorun works
>=20
>=20
> The other thing is to enable SHM on other platforms, but first things
> first.

Will fix, thanks.
