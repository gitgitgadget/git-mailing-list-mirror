From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] am: gather GIT_AUTHOR_* from original commit when 
	rebasing
Date: Tue, 15 Jun 2010 18:24:19 -0400
Message-ID: <AANLkTilyPkaQsW-Qe6BiCOFJXNJjBUmz5sAsUThKmM_H@mail.gmail.com>
References: <1276640292-78522-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:24:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOeYU-0002Bw-0W
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab0FOWYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 18:24:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64077 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0FOWYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:24:19 -0400
Received: by iwn9 with SMTP id 9so4985797iwn.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rqgwDcg93fUEVfRZB7XHCGU8D9/QmfBHG9/SSxgMXoU=;
        b=tEDWSYPf/jev/k/XF1Ti3Pdt6act5csMVGlqt+GoOeEnVFuSoXDFU2wjlY1vMGmLV6
         mEn8JMhJxFj652yS6Qm1DNjBX8W0UUEJdR8p4uWDq0y4AZu0P6wQgzy9sX2dmtRy0qGY
         tPhww1sQOZNDhLwZkQv0HcH5l1PLCXO2kIfLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GlVC8WhfxUs9a7v+pPcgYKzmMuJVAasltEsbDroMYtgQ0b6Td8FA62zHEj2vpWytyB
         ZWzR5SJn23A33dtnsKFgK5c+Egeeye1y7gIkI0D8++xjGYvl93JdruGX3zVXXoX6A3tL
         i9eCFuecbAnmtKuAbqckmfAjTWSCBMy4y7UEk=
Received: by 10.231.168.135 with SMTP id u7mr8334509iby.125.1276640659245; 
	Tue, 15 Jun 2010 15:24:19 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Tue, 15 Jun 2010 15:24:19 -0700 (PDT)
In-Reply-To: <1276640292-78522-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149232>

On Tue, Jun 15, 2010 at 6:18 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> In certain situations, commit authorship can contain an invalid
> e-mail address. For example, this is the case when working with git
> svn repos where the author email has the svn repo UUID appended such
> as:

Grrr, ignore this one. Sorry, sending a v2 shortly.

j.
