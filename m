From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 09:40:40 +0000
Message-ID: <AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>
	<AANLkTikGSj-x4hk7NFysWETuR80=REZ81Qy8Zu3Pks-L@mail.gmail.com>
	<201010111039.59779.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 11:46:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ExS-0004cd-UR
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 11:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab0JKJqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 05:46:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45086 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0JKJqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 05:46:05 -0400
Received: by iwn6 with SMTP id 6so3128573iwn.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=uBU8wnZ3WuYFTtOuMDNLtVN3cUFChBpMVtATsVAyzpk=;
        b=H4KdXnBnzK7gyjs9jIiCalf80yXB6QD9PIhanHNUytiB420uGQ+vvBtKPHOWsUIPip
         4NUycpKhVpKkJJL/BSJhRJt69tn94rRpxjktp77hcaJ8lKiZwDHM/HCRIC46tTYu1ngQ
         X2J+IgB8qHTBQm7bqTgvOmv4nkgsGtg62bHRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XYdB9mIS/c4mQGmlcAXQuqDqmPBIhCPD+HIN7zzEWCWOWKAu8y301VFb2FmzyKcGEp
         HNWk6ND0RnWN2R7O+e/FC0X3qsFuKBIqv7jktPNYxlzJLuqhr3ysRCqtv61JL4fSSZMq
         klJ1yM5o328PLxlyYWdg5tsAHR5QEFiY8317o=
Received: by 10.42.179.136 with SMTP id bq8mr350663icb.93.1286790040137; Mon,
 11 Oct 2010 02:40:40 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 11 Oct 2010 02:40:40 -0700 (PDT)
In-Reply-To: <201010111039.59779.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158755>

On Mon, Oct 11, 2010 at 08:39, Jakub Narebski <jnareb@gmail.com> wrote:

> But thanks to having ./configure optional step, we can build git also
> on platforms that doesn't have autoconf installed (though the same could
> be achieved by bundling ./configure script with release tarballs).

It already is built as part of the tarballs, at least for
http://kernel.org/pub/software/scm/git/git-1.7.3.1.tar.bz2
