From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH 1/2] git-svn.perl: perform deletions before anything else
Date: Sun, 12 Feb 2012 10:35:43 -0500
Message-ID: <CAK8d-aKJCBq2xpsz65hA4g8oa_szKaofLpkYB3v3_2dd=BAgiQ@mail.gmail.com>
References: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org> <1328820742-4795-1-git-send-email-stevenrwalter@gmail.com>
 <1328820742-4795-2-git-send-email-stevenrwalter@gmail.com> <20120212070353.GA30477@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 16:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwbTi-0006Nr-SZ
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 16:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab2BLPgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 10:36:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59258 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab2BLPgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 10:36:05 -0500
Received: by yenm8 with SMTP id m8so2053072yen.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 07:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=am4+pHWD/Fn02PQbO+/p26ZC99aacTxN+9laRfqjwas=;
        b=GxNsl8sOB2O7LKq0h3ae0QdIJi1P/KDvtUZP7mkXs7YDNMYvEXmUAvGojfP/1G4zmP
         gc/S+3ETYLUUl75DcsG3bxL9dhPFrs/KMJrcGVuPgiefbrVZ/BS9f4fmsSDF7VjP5ahU
         uS6dRv1qp+x4UK9SFaGFOWh7OMnpEZVUNLpuk=
Received: by 10.236.72.167 with SMTP id t27mr16089974yhd.79.1329060964201;
 Sun, 12 Feb 2012 07:36:04 -0800 (PST)
Received: by 10.100.96.10 with HTTP; Sun, 12 Feb 2012 07:35:43 -0800 (PST)
In-Reply-To: <20120212070353.GA30477@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190575>

On Sun, Feb 12, 2012 at 2:03 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Steven Walter <stevenrwalter@gmail.com> wrote:
>> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
>
> Thanks, shall I fixup 2/2 and assume you meant to Sign-off on that, too?

Yes, thanks
-- 
-Steven Walter <stevenrwalter@gmail.com>
