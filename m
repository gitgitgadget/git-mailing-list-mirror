From: Chris Packham <judge.packham@gmail.com>
Subject: state of the art with moving submodules
Date: Tue, 26 Feb 2013 21:09:54 +1300
Message-ID: <512C6DD2.4000208@gmail.com>
References: <bcaec55555fe91182f04d698b37f@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 09:09:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAFbV-0004UH-TO
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 09:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758309Ab3BZIJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 03:09:12 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:54373 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab3BZIJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 03:09:11 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so1892948dad.24
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 00:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-forwarded-message-id:content-type
         :content-transfer-encoding;
        bh=WcvsutYWmu0xeyDUB0PSlzOLRC0NdH0jUr5JS4PkP3k=;
        b=cxy7bmegZYyoDmvF0cEoQrDStOdXZu4+Hs8w/zCIsmLoJrvZlPrNUgx5YMXT+p+Va6
         nljq4nMPpQ041x8nSyUNhph5fonvBQqDE4ZUvWCZw+6cofN9XHoN1VZyMFqlCUksXzvB
         I0s2EBFJaIAVo2N1p9c+strzNEiL8BFuViZRF4Qm9pU7rG8vOrNXdGwimi6ZylwyW8vm
         1b4QKkggkkR8S95HuM1Dz5OM2tCAeyTAapjHqLwDM78b/I1Y+UAi5EsIzB2y1jhrCH5Z
         SC3HC7g/KAuYfJulh/AVWtUrsrQyNPEF1ccvaUIF1kIvbdXssMP9Onv/h9O15mDuJ0HB
         qWZA==
X-Received: by 10.68.213.170 with SMTP id nt10mr22799348pbc.14.1361866151141;
        Tue, 26 Feb 2013 00:09:11 -0800 (PST)
Received: from [192.168.1.103] (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id g4sm628968pax.4.2013.02.26.00.09.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 00:09:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <bcaec55555fe91182f04d698b37f@google.com>
X-Forwarded-Message-Id: <bcaec55555fe91182f04d698b37f@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217130>

Hi Jens,

(sorry for the dup. gmail insists on sending html)

I know I saw a few threads regarding support for moving submodules but I
lost track of the discussion.

At $dayjob we were discussing a potential re-org of our super-projects
to introduce a bit of hierarchy to the submodules (at the moment it's
fairly flat). One downside of this is the potential loss of locally
committed work. There is also a cost in terms of additional fetching but
we think that will be OK (fetches from local servers with smallish repos).

I was just wondering where things were at with git detecting submodule
moving/renaming? Will our developers be able to keep any local commits
when they happen to pull in the super-project commit that moves a commit.

I think some people with older clones will suffer without the newer
.git/modules layout but those can be manually fixed prior to the re-org.

FYI our current stock workstation install uses git version 1.7.9.5 but
I'm recommending we update to 1.8.x before this re-org to pick up some
of the recent submodule improvements.

Thanks
Chris
