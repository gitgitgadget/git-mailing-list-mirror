From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: [PATCH] git-svn: un-break "git svn rebase" when log.abbrevCommit=true
Date: Mon, 30 Jan 2012 15:41:16 -0500
Message-ID: <CAPBPrntdWAM056C_iZDD1XZy6KZ=5rKvH98Owgc-J8ZbBwrErg@mail.gmail.com>
References: <1327803073-7000-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:41:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rry2U-0002Fp-R5
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab2A3UlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 15:41:18 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37462 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab2A3UlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 15:41:17 -0500
Received: by vcbgb30 with SMTP id gb30so3049809vcb.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Tzo5MIOz57bLRCunO2MF7iY7u4J42V1/lLxoUkTVmDM=;
        b=DqWSfotuwJPYlo8GHqha60ALa0YgyAxSir/vX4oBLN3IgFT/sWg70dmcJeDM+SW+bQ
         AUsiHnZTYZHkK6dBKUTq4IceyxJxX4oK/JPhN2YZXjnaFVptoynXiBGzpOwwO/3qqqww
         qgFwsARbF3XG+L6Vv8CZwel/tzgvxj88HEEdc=
Received: by 10.220.115.9 with SMTP id g9mr10236730vcq.56.1327956076825; Mon,
 30 Jan 2012 12:41:16 -0800 (PST)
Received: by 10.220.75.65 with HTTP; Mon, 30 Jan 2012 12:41:16 -0800 (PST)
In-Reply-To: <1327803073-7000-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189419>

On Sat, Jan 28, 2012 at 9:11 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change git-svn to parse --no-abbrev-commit --no-decorate to git-log
Did you mean _pass_ --no-abbrev-commit here?

--=20
-Dan
