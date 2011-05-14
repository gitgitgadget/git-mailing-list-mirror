From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] Submodules: Don't parse .gitmodules when it
 contains, merge conflicts
Date: Sat, 14 May 2011 23:59:04 +0700
Message-ID: <BANLkTinvkxDYqNs3Pv0CniGtAHm5dJf0wg@mail.gmail.com>
References: <4DCEACF8.50503@web.de> <4DCEAD52.60707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat May 14 19:00:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLIC9-0007Du-Eg
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 19:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab1ENQ7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 12:59:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44943 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab1ENQ7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 12:59:36 -0400
Received: by bwz15 with SMTP id 15so2808372bwz.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=K/PD2CFGwVanPorUEuMrBQYl71G9WC1+fIMbjx5j5fY=;
        b=oERUcXKStgtfy3gQ1wMqtLP9bHFyb1gh0UplNQYQnglZblqPaQ3Man/xW+/ZK9rqme
         8zSLNdazAlYfHMW62u6Kf+yMATs2xK7ZLJYaGZq9QMu3XTMI8ox/i1yHyaeIDgNgUbUi
         J6IvXVTr4FcVi5yvEtmLCe2ouVzQ8+MbWd5I4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aOmtnUvlOilKhqcfHjHoVRN5AY6bV+wjfgVs6GOfouFCKTFFQJPwMF8NOycCKOEMy6
         mbooabBKx5A+yK1i/eQCAaCtlvNnURwTU9u5TN29/IB2UZA/qrjB5D/CwSdYVnL+D/pV
         QFdeLO6esAsCDrS5xWvMtR5WvTc84i2c2Y0U0=
Received: by 10.204.7.213 with SMTP id e21mr2356543bke.209.1305392375248; Sat,
 14 May 2011 09:59:35 -0700 (PDT)
Received: by 10.204.177.147 with HTTP; Sat, 14 May 2011 09:59:04 -0700 (PDT)
In-Reply-To: <4DCEAD52.60707@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173593>

On Sat, May 14, 2011 at 11:26 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Commands like "git status", "git diff" and "git fetch" would fail when the
> .gitmodules file contained merge conflicts because ...

Side note. .gitattributes and .gitignore likely suffer the same.
Perhaps the unmerged check in this patch can be generalized for reuse.
-- 
Duy
