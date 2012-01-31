From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Correct singular form in diff summary line for human
 interaction
Date: Tue, 31 Jan 2012 09:20:28 -0600
Message-ID: <20120131152028.GA10717@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 16:20:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsFVr-0007Gs-0u
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 16:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab2AaPUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 10:20:45 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59787 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab2AaPUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 10:20:43 -0500
Received: by vbjk17 with SMTP id k17so81979vbj.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 07:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rtzTRYU8PbWSXM1VaL0Uqr/xPf1+mrU0jSl5l55uK9Q=;
        b=B1tUvt3C3PwAKThKJ/IfN37MSr671tnfWCK7b7TdSPvCmmHuEffi2fiiupDBD7VHaJ
         8KYGy7Vt8CBQosh7HtqGVkXMXsFSwSERnkGBCZ4OBq+5ngxBZu8bbMiPHPYDrJTUiN8s
         /AULhZU2TNq0VktykoBTvRgzsgia8abUbMuY4=
Received: by 10.52.93.77 with SMTP id cs13mr10425930vdb.71.1328023243175;
        Tue, 31 Jan 2012 07:20:43 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a19sm19348039vdh.12.2012.01.31.07.20.41
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 07:20:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189457>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Convenient function interactive_use() is added for this purpose. The
> command thinks it's in human hands when:

I admit I really dislike this, especially:

>  - GIT_SCRIPTING environment variable is not set

If my GUI app was parsing diffstats to convert them into a visual
representation, as a novice it may not be obvious to me where to find
the menu entry file to set this envvar in.

But maybe I'm not the right person to ask, since I'd be okay with
removing the "s"es (with an appropriate incubation time to discover
whether we are introducing a regression) unconditionally.

If there is an environment variable to say "I don't want to see
variations on strings intended for humans", can it be spelled as
LC_ALL=3DC?

Just my two cents,
Jonathan
