From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 14/15] git-am.sh: replace using expr for arithmetic
 operations with the equivalent shell builtin
Date: Thu, 4 Feb 2016 11:46:44 -0800
Message-ID: <CAGZ79kYYYwkX2NWN6SsW-CWWxOd-C87VqfzSFAhFfgmMf4795w@mail.gmail.com>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:46:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPre-0004TR-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966363AbcBDTqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:46:46 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37991 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966331AbcBDTqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:46:45 -0500
Received: by mail-ig0-f182.google.com with SMTP id mw1so66951926igb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kJqdu0eQ1stWU5I5GkZ+MJkfN30H5J/FkDBs0PTIHu4=;
        b=j/MlH8BmMUaET5DXs3w07S8CHJ00bl8ANQW8AgG2sUp8MZ60mKsbbxFJ/G+ZGMuXUd
         4Mj9DPlW9Kz3hBx1GGjDL07XXq1cWzROVuIS3CksSyVD5IFDl8QECRNDpZB7KOL02OK/
         UnE3dNuQCF76Ce1Kdzs7y7plS8GiRNXzOvMSIurUzh8zU5BF7TPfD/zI+JIlB5aPOhyh
         Qb7d5liY0+BZv5+m3ms8+Y+L02tViZ2T/gHEVO5b6JUIAD75I4l0f8bW/aGJdmUtVCIM
         CGIuEDw3aDpqe1FDmiehuFvkbnt64laKjfBBT6og8j+zoJM5e+/WldHWVrieIl/G8ByT
         MudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kJqdu0eQ1stWU5I5GkZ+MJkfN30H5J/FkDBs0PTIHu4=;
        b=NrvxFckInznOIGgJ+xjFPRVumLSTmYUYUZITQzdIcTfvB+BcUDOomlDLk9//KH4MZ8
         Lj09uwcdDXR5cShBfEMclUqNmqtzuBLod8cHqq6/CAI5lzC0p0ANal+hhKoDYnCJMz2g
         7IQmDwFZnATjRCRSwUAii9ddpoCPrSFzcoqST1PQgMPJziGP/q13bK9WKpAkqlnm7QD2
         2K0y/51E/1ViuKxLWIpk99560yjD7A6q86ZyXB0Gpg75f5ItLI0xviadzZfFJ+a01910
         FC1wru4XgUKasfMTzzb13hRxjFNWh8I/sfhQ+YtTfzNFSXatop29jd0DVaKUWlH35N7d
         EVaw==
X-Gm-Message-State: AG10YORHBnyVeMkYtENW6jHHt71WMVt5g3ehMpUnjaSLombqF3NCKrkRmUvBZYxmBWdHOH2BR4ntLO68HI8kdMHG
X-Received: by 10.50.43.168 with SMTP id x8mr11263008igl.93.1454615204351;
 Thu, 04 Feb 2016 11:46:44 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 4 Feb 2016 11:46:44 -0800 (PST)
In-Reply-To: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285486>

On which version did you base your patches?

git-am.sh is no more since 2015-08-04,
(it was moved to contrib/examples/git-am.sh as part of the rewrite of am in C)
