From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 6 May 2012 23:21:49 +0200
Message-ID: <201205062321.52148.jnareb@gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com> <vpqtxztlhjd.fsf@bauges.imag.fr> <CAMP44s3kkEn+_fhdrXyT9znNDE_u39pv1cFvZ+kLFyzOVpsjHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 23:22:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR8u1-0003v9-Bm
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 23:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab2EFVV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 17:21:56 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38303 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab2EFVVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 17:21:55 -0400
Received: by wgbdr13 with SMTP id dr13so4280364wgb.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=RUDW49OdKBgVyKvWzG73iqkaJP8ZauIIQcobzBGofXk=;
        b=Epz+1URhcKAVTkF1nK/i2t1BPMtHY2O6XgmMsiQzBa4GWD4lhjyMKYUnZFpabD9GvD
         o2kQvXGQ9m3Cok1BFeSeqZETLTorWP6qCRRpDNMwhqnsABN8SmzeJ6Ryg1lsa8T2Zs4T
         55MSHdwM7N/nc3clQLSqOmQ3hpqsJsPMZYzUvsoiyY4MUIi6G8Z1mV3mBKQtrE87H+iL
         LHPzi/H6Ifqeq4KRWcCRb7VXUiurDRFJ0FarvWjayz3I1mK3ek9pupUxmq9y4iL7wEUx
         91QsWdlrZMq3ILHGVvQm1c7hiOrM6aVQC09bjFSCx9v6LOLOrGTkPwOLSToMWxKqbHB9
         2f4w==
Received: by 10.216.137.232 with SMTP id y82mr8168105wei.82.1336339314575;
        Sun, 06 May 2012 14:21:54 -0700 (PDT)
Received: from [192.168.1.13] (evc230.neoplus.adsl.tpnet.pl. [83.20.200.230])
        by mx.google.com with ESMTPS id u9sm17067708wix.0.2012.05.06.14.21.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 14:21:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAMP44s3kkEn+_fhdrXyT9znNDE_u39pv1cFvZ+kLFyzOVpsjHg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197216>

On Sun, May 6, 2012, Felipe Contreras wrote:
> On Sun, May 6, 2012 at 12:39 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> >
> > > Actually Git porcelain does use 'the index' as a cache (computing),
> > > i.e. as a place to store redundant information (stat data, sha-1
> > > for trees with DIRC dircache extension) for faster access.
> >
> > This is an implementation optimization, that is not supposed to be
> > visible for the user. Commands refering to the "cache" are not about
> > stat data cache (e.g. "git diff --cached" is really about the content,
> > not the stat cache).
> 
> Exactly; that's an implementation detail that doesn't affect how the
> user actually interacts with the staging area.

Well, it does (or hopefully just did) affect the user: _if it fails_,
in the form of empty diff on no changes because of stat-dirtyness
or racy-git :-P

-- 
Jakub Narebski
Poland
