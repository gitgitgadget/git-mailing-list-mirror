From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Fri, 11 Jan 2013 21:08:49 +0100
Message-ID: <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de>
 <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de>
 <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com>
 <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
 <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black>
 <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"Stephen & Linda Smith" <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttkv0-0005Nb-04
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 21:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab3AKUJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 15:09:11 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62079 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab3AKUJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 15:09:10 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1194142pad.4
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 12:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MlTLr9f/H6CjTA1bmABuGl2TxqmfqTkq0DQDp1Dg7lQ=;
        b=mf+a3N67lO9ruQ0h+dpWo1H6hF18d9t2uvqkMdF7QuIlW8vMVYfwSu7muRYajXXVKN
         kfkmad0hoQmokYcWTnLCGLIgi1TPC5q5VNffpIk3ol+N9Eokr4eNjyESEZ4UhAodBUH7
         9395JWiwuCawimW4H9B4L4ZWacsyW/2X1SAgczOVTxJ6HxwkmfSZAepEBGfoiNeRBOHk
         7tKos9B9jCEncmsNizmjDByWW8RRefdtf2glpgf8xctfL8EcdQfy1tfVIoIxen18wNx0
         ukmDQJgW3bgX00NZXJ+FjTxwD6+o8k6zrAWKDEt8kLDR6+HsiWp4gptMwMLY8pQ8YPJl
         QlNA==
Received: by 10.66.73.230 with SMTP id o6mr209999977pav.57.1357934949636; Fri,
 11 Jan 2013 12:09:09 -0800 (PST)
Received: by 10.66.15.67 with HTTP; Fri, 11 Jan 2013 12:08:49 -0800 (PST)
In-Reply-To: <50EB8EB5.6080204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213239>

This short discussion on GitHub (file git-compat-util.h) might be relevant:

https://github.com/msysgit/git/commit/435bdf8c7ffa493f8f6f2e8f329f8cc22db16ce6#commitcomment-2407194

The change suggested there (to remove an inclusion of windows.h in
git-compat-util.h) might simplify the solution a little. Might even
remove the need for auto-configuration in Makefile (worked for me).
