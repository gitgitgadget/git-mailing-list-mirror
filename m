From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: allow -X for non-recursive strategy
Date: Wed, 10 Nov 2010 02:55:54 -0600
Message-ID: <20101110085554.GA10282@burratino>
References: <1289336299-28282-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 09:56:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG6Tf-0001p2-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 09:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab0KJI4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 03:56:19 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46345 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab0KJI4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 03:56:18 -0500
Received: by gwj21 with SMTP id 21so181836gwj.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qMtGQs2KT14gxUNamOShw2OrmZqMgevNf5QEIzt0zkk=;
        b=GX+SS/t5IDu0AJtS+oOSaT4tTEmo2LEsMF4NP5U4cjlgCxWivhELzKY7ql11N9H6Fe
         AmMQHPsVeoQECTF4x80vxEBCTZz5+G5Iuv4x0v6OQNv1rwyi2WSgc03StZiBE8SA4CKO
         AomhF/228TGRaNRBR5mEEGz0wNmUIIArnnQWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=r8s9TS7InXVrosfLU+9Xo6vVFdgGrEccF/ow2+35RlOZhqfXj6n3qhdGlJZ6Ptn7cp
         a115cKTfn+NUtle7e6yGOJ3jRQMkRPKfNfmRaiSDBQlr1lXkCX4I5bqXuV5u309uErb4
         SqaBPIxVdgOEvMNTm8K0QceSxrTqV3JgS7UsQ=
Received: by 10.151.100.16 with SMTP id c16mr12265925ybm.52.1289379378163;
        Wed, 10 Nov 2010 00:56:18 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v8sm398737yba.2.2010.11.10.00.56.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 00:56:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289336299-28282-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161141>

Martin von Zweigbergk wrote:

> Subject: [PATCH] rebase: allow -X for non-recursive strategy

I first read this as "allow -X option, which can be used to set a
non-recursive strategy".  Of course that was nonsense, but maybe
it can be made clearer?  e.g.

	rebase -X: do not clobber strategy

This fixes a regression introduced in v1.7.3-rc0~67^2 (2010-07-29).
