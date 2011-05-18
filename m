From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v4] Add log.abbrevCommit config variable
Date: Tue, 17 May 2011 21:21:43 -0400
Message-ID: <BANLkTin-xuP0Bo-67_03BaAn93w7x9sC+g@mail.gmail.com>
References: <1305681031-97235-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 03:21:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMVSR-0004r9-BJ
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 03:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704Ab1ERBVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 21:21:45 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59475 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab1ERBVo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 21:21:44 -0400
Received: by pvg12 with SMTP id 12so488313pvg.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YT0ObN2unz8MpgCzVktJtRTdDHOAdh0oexY25k80EbY=;
        b=PhcdJp0l6QDGe2aTsKTcnkCFInItoo0eeawEz+40N0hc7ZaOkMM66k3ujOgOGbT95W
         GlMdYtYxKBtcpSVn9YCZmHq+bKuruf4uFUpVx86cQNqUjgjCWGb7JHgQH4goVZzRTY+V
         E7+dATqk7sNA6yAvdxo3oLWpcVZ7QH6WYKI+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OPiEEV1xbpzY2QaSKbEwM3dYwI0uTFurcUtMfVNFp1RTMCwlRhFw8+QsihHA+nV3l0
         wDCLPeCLFkCgZEEFQJJ/GapY6yrMaaEZWA0bbgpsvItPg5BME6Vt1VOqtflz19OYfMc2
         w22bGypViINbnw00S4IEWkGxXj9Wl17Kn9XIw=
Received: by 10.142.225.6 with SMTP id x6mr784409wfg.55.1305681704032; Tue, 17
 May 2011 18:21:44 -0700 (PDT)
Received: by 10.142.200.15 with HTTP; Tue, 17 May 2011 18:21:43 -0700 (PDT)
In-Reply-To: <1305681031-97235-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173835>

On Tue, May 17, 2011 at 9:10 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> Add log.abbrevCommit config variable as a convenience for users who
> often use --abbrev-commit with git log and friends. Allow the option
> to be overridden with --no-abbrev-commit. Per 635530a2fc and 4f62c2bc=
57,
> the config variable is ignored when log is given "--pretty=3Draw".
>
> (Also, a drive-by spelling correction in git log's short help.)
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> - Fixed regression in "git reflog" output where commit was not abbrev=
iated
> - Added tests for "git whatchanged" and "git reflog" output formats
> - Added additional stanzas to "log.abbrevCommit" test to check output
> =C2=A0of "git whatchanged" and "git reflog"

Ignore this, I sent the wrong file. Sorry. Sending v5.

j.
