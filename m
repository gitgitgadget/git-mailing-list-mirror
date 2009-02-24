From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Altering Previous Commits' Author Field.
Date: Tue, 24 Feb 2009 17:16:59 -0500
Message-ID: <c115fd3c0902241416t65beb6b5x6890b4a229515c63@mail.gmail.com>
References: <c115fd3c0902241329i2455bc8bj62ec41856773be30@mail.gmail.com>
	 <200902242243.49612.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc5bj-0002Vd-Ir
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 23:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbZBXWRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755313AbZBXWRE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 17:17:04 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:43585 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZBXWRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 17:17:01 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1185136yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7SoJEPKy2+Lj5j1MjunKPgaIOFtcsjLNOcHn8L/Hbf4=;
        b=LePcJPN9SX5ZOlsEFjF/5S0n+8BIzIAiNZpo+iZkC+pTc+fO1pslezUksEdR9VmDYV
         UUDADZRDaVqy7Ww1FCnRg5OyPLSFoqVvQZJ8GNw0qFUgTyvRAPoS+Mdta060l6zAxTiI
         88dV/2ngyCMafsOhu6dOk7QjxOstc0/4OEYk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Uw6ckmFAqCcsECr048w2Cxbs+wrlu+lASNJmopC8Z0mLyTPyTSZFF17Qwh2MA5J4xe
         4AkjBNX2EI7FjHndi9PCGIhHkIiZwtLEM5d3o1bUAROd00bfHpUS7FTo9tJNDWsUag1h
         Pu/qHrgtJHSuYMqgU306C/E3NQ+3clBdHmoAA=
Received: by 10.100.154.17 with SMTP id b17mr259645ane.43.1235513819694; Tue, 
	24 Feb 2009 14:16:59 -0800 (PST)
In-Reply-To: <200902242243.49612.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111355>

On Tue, Feb 24, 2009 at 4:43 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:

> If you haven't published your branch you can use git-filter-branch to
> rewrite using the --env-filter "export GIT_AUTHOR_NAME=...  etc"

Awesome!  That's exactly what I was looking for! Thank you! :)

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
