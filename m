From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Invoke the correct interactive editor
Date: Sat, 30 Aug 2008 23:16:11 +0100
Message-ID: <b0943d9e0808301516o71c073ai5d5f8833e004a8e2@mail.gmail.com>
References: <20080828001843.5510.76140.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 00:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZYkw-0004yb-Ok
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbYH3WQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbYH3WQN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 18:16:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:4879 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbYH3WQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 18:16:12 -0400
Received: by wa-out-1112.google.com with SMTP id j37so856960waf.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 15:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4vcJOXx4SnVX3EytHDCct4vO4DOD2CcV5dOx69Aj0a0=;
        b=gybCuGvZditxB16PAvUETdUsXdp5BHaKquL6hdRjeCegOEQc4/z72jLo01dU1TS6nN
         o//VJf30WzYyCosJlm1FWgwU4hETp/df7ebprA4UiJWX6RQrcuADRO5RBZvT2Izgbx1i
         jSYKk9q4LehxJbQqvXGoeltCwzboP3gOUzW84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=og/4woX4upLAAal/XLiHqqGSOeaPz+e4Zew6/Ku4CoPAxlsprJV7Ie67GcFIvyZv7w
         1pOWtjUGT9H28crNpk3y1PQqzz1jAuBS7hNnl4Mfcv/Sw+7DtXAZW3XW0ykgnMg3JJii
         zTj5yka1QDuw/tCW2LdQc+waUafn3hWFj0i5k=
Received: by 10.114.184.7 with SMTP id h7mr3980734waf.183.1220134571226;
        Sat, 30 Aug 2008 15:16:11 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sat, 30 Aug 2008 15:16:11 -0700 (PDT)
In-Reply-To: <20080828001843.5510.76140.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94439>

2008/8/28 Karl Hasselstr=F6m <kha@treskal.com>:
> The order is supposed to be GIT_EDITOR, stgit.editor, core.editor,
> VISUAL, EDITOR, vi. This patch makes it so.

Looks OK. Thanks.

--=20
Catalin
