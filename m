From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] vcs-svn: make reading of properties binary-safe
Date: Mon, 28 Mar 2011 14:41:57 -0500
Message-ID: <20110328194157.GC13433@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
 <20110325033431.GA3007@elie>
 <20110325040730.GB3007@elie>
 <4D90AA6A.1090904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: tb <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:42:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4IKJ-0006zi-R8
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 21:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1C1TmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 15:42:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34656 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab1C1TmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 15:42:03 -0400
Received: by ywj3 with SMTP id 3so1302283ywj.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gYgEQ9KYTtguH1mlUtxcXYFct1OBDYxAUcsSfE6fqhw=;
        b=ZJL10PFTPRJ1XoVEoBq2f8ZYA9fhvGQH0+4Bmzo+is+qW/3uYFkmq20ywugouXFjwv
         y65cw1vmieWjGlrr0Q0hWZKwwqdgPWkq06Vf/a0Z3q6LW/CIYY8fy8dBK8nFsrG58/0R
         UWBqkq3I5HrUao7Hi3VweAPo6jtgN8Zx9A7KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TzwGrb822c16oDVGwhB4d3nbumtp/5+AbAxA/zJgg3CbiRGsnteb1qtTJAG38s0Ktq
         fi1BO/+FF7GUQvOmYb5+3VopE1JGTMzF4q09khSZ3v/Ne7+pbX44EEmP3ZhjWmS5XrJl
         GC5o+HpnWGUdC6PySwFgG10slLbJbBiVdr4Nk=
Received: by 10.150.170.10 with SMTP id s10mr4580177ybe.3.1301341321866;
        Mon, 28 Mar 2011 12:42:01 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.sbcglobal.net [68.255.101.206])
        by mx.google.com with ESMTPS id b30sm2098503yho.16.2011.03.28.12.41.59
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 12:42:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D90AA6A.1090904@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170179>

tb wrote:

> failure on t9010 with commit 195b7ca6f229455da61f9f6b
[...]
> Darwin birne.lan 10.7.0 Darwin Kernel Version 10.7.0: Sat Jan 29
> 15:17:16 PST 2011; root:xnu-1504.9.37~1/RELEASE_I386 i386

Could you try 41e6b91f (vcs-svn: add missing cast to printf argument,
2011-03-27) from

	git://repo.or.cz/git/jrn.git svn-fe

?  I suspect this is fallout from a missing cast in the commit you
pointed to.  Thanks for noticing.
