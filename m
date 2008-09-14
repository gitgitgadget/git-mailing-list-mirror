From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 16/16] ls-files: add --overlay option
Date: Sun, 14 Sep 2008 14:10:22 -0700 (PDT)
Message-ID: <m3ljxumo1w.fsf@localhost.localdomain>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	<1221397685-27715-2-git-send-email-pclouds@gmail.com>
	<1221397685-27715-3-git-send-email-pclouds@gmail.com>
	<1221397685-27715-4-git-send-email-pclouds@gmail.com>
	<1221397685-27715-5-git-send-email-pclouds@gmail.com>
	<1221397685-27715-6-git-send-email-pclouds@gmail.com>
	<1221397685-27715-7-git-send-email-pclouds@gmail.com>
	<1221397685-27715-8-git-send-email-pclouds@gmail.com>
	<1221397685-27715-9-git-send-email-pclouds@gmail.com>
	<1221397685-27715-10-git-send-email-pclouds@gmail.com>
	<1221397685-27715-11-git-send-email-pclouds@gmail.com>
	<1221397685-27715-12-git-send-email-pclouds@gmail.com>
	<1221397685-27715-13-git-send-email-pclouds@gmail.com>
	<1221397685-27715-14-git-send-email-pclouds@gmail.com>
	<1221397685-27715-15-git-send-email-pclouds@gmail.com>
	<1221397685-27715-16-git-send-email-pclouds@gmail.com>
	<1221397685-27715-17-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:11:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeysX-0005N5-N8
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbYINVK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 17:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbYINVK0
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:10:26 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:52160 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbYINVKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 17:10:25 -0400
Received: by yx-out-2324.google.com with SMTP id 8so531830yxm.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=bV+KsK36b2yfa0bw4mGii4YYGsJSumAV1eeVjTNRs+U=;
        b=kEo9wxkRGeM0EqhgRvlxhEYGV+2u4MoG7YIOUrmqP8Z39obVghPgvpgzL+ba/IJcII
         UPm0QHZHtliqNy0v+rYRwzyr0224FI2eg7uY8TrfqUPilmx80q51rCBxEnE+syBwmvGh
         eGON9fziPjZuEJI57THl1POaraZVHZjyVE7HM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=EhRNqYMPEwgZ3AA+4gyQIND9XxQywi3rpzjumGBegvfRPowZfzUPTonEZ1zXRsn8s/
         Oqbet/0Zr61DnGzzAkV4CaAi4DAeOGE5W67Ys3lxlOe9RXGeetikiFMjXqedX8veTuD0
         tEQZ1ID4c9wRaKPoLJ4n3ouA5nTUYuOdEDAdw=
Received: by 10.86.98.10 with SMTP id v10mr5293993fgb.46.1221426623403;
        Sun, 14 Sep 2008 14:10:23 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.193])
        by mx.google.com with ESMTPS id 4sm16343546fge.8.2008.09.14.14.10.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 14:10:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8ELALqh014958;
	Sun, 14 Sep 2008 23:10:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8ELAKmS014955;
	Sun, 14 Sep 2008 23:10:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221397685-27715-17-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95863>

I will comment only on the Documentation part...

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy    <pclouds@gmail.com> writes=
:

> Narrow checkout mode introduces an interesting case: some files
> are not to be checked out (marked CE_NO_CHECKOUT in index) but still
> exist in working directory. Those files will be ignored by Git unless
> explicitly specified. In ClearCase, these files are called "eclipsed"=
=2E
> I would call them "overlay" for now. Any better term is welcome.

"un-un-checked-out"? Just kidding.  "not needed", "unneeded",...
ah, I know, perhaps "unwanted"? Or "orphaned" ("abandoned")?

[...]
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
[...]
> +--overlay::
> +	Show files that are marked no-checkout but exist in working directo=
ry.
> +

Shouldn't this be another letter in status mode? What about files
which should be not checked-out, but are modified? Or for simplicity
it is just list of files which have "no checkout" bit set, but are
present in working directory (and are not unmerged?)?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
