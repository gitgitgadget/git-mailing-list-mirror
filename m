From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PULL svn-fe] Re: 195b7ca6 breaks t9010 at current master
Date: Tue, 29 Mar 2011 02:24:31 -0500
Message-ID: <20110329072431.GC25693@elie>
References: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com>
 <20110329042446.GB25693@elie>
 <08D5E94F-23F7-4F18-9E3F-A92722F70C70@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	David Barr <david.barr@cordelta.com>,
	=?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:24:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4TI9-0005YK-FW
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1C2HYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 03:24:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37146 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1C2HYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 03:24:36 -0400
Received: by iwn34 with SMTP id 34so4525292iwn.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MTFdd9sw0HM5Wow+8mqInBHVg0P2Vxm8YNLd07t0zNs=;
        b=XFHzFo2ad73wNZMY2/+u0VigrhLQc/JPaM4jebnuCxSzUZDNHZiddJP5KR1+IQmLx1
         Hu9QdtTEk0oYHae8e2Mv0oypVl/B5CDk4bZu/WwhztUjSTKO+um7TH4ETlrQDXBzg0Bs
         Cw//3Ez0vOmetuayHc3hIiYmyjJbrTvmQhN8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jnINGJ4NEhILVaObKwTyjLx4J/4lLbVtuRP5JGT5DrTKsBzwonDcrM6iJxjDW2CUE7
         Tf37E1hDb3CLciSRBIlj/JpnXLt9/3/uNbo3Lq7sd+6y4mGWLnKtCSZD6yQ697Y7ZaGd
         f9c5dekchAzDr4EQBjWXFoseZqEjG4VBTioms=
Received: by 10.42.157.9 with SMTP id b9mr260544icx.198.1301383475799;
        Tue, 29 Mar 2011 00:24:35 -0700 (PDT)
Received: from elie (adsl-76-206-232-54.dsl.chcgil.sbcglobal.net [76.206.232.54])
        by mx.google.com with ESMTPS id xi12sm3304454icb.6.2011.03.29.00.24.33
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 00:24:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <08D5E94F-23F7-4F18-9E3F-A92722F70C70@silverinsanity.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170240>

Brian Gernhardt wrote:

> Breakage also seen on OS X 10.6.7, the provided patch does fix.

Thanks.  repo.or.cz doesn't seem to be accepting pushes, so
the following changes are available from

  git://git.debian.org/users/jrnieder-guest/git.git svn-fe

Sorry for the trouble.

Jonathan Nieder (2):
      vcs-svn: add missing cast to printf argument
      tests: make sure input to sed is newline terminated

 t/t9010-svn-fe.sh     |    8 ++++++--
 vcs-svn/fast_export.c |    3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)
