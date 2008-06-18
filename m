From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [RFC] convert shortlog to use parse_options
Date: Tue, 17 Jun 2008 22:03:54 -0500
Message-ID: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, madcoder@debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 05:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8nyy-0007JY-Jv
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 05:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbYFRDES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 23:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbYFRDES
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 23:04:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:40312 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbYFRDER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 23:04:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so37846ywe.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 20:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=x+PZjJ+utwSXhg5rFwUqyZZvSgJPqamMxNK5jWBwNDU=;
        b=xC2fNhZVXlIs6f7aqXCs7VY70jIXgn7N89YN8acMsj2AbIEYRHvEt7jqbQhh/pw8qP
         iaCK5r+Y04WR9Dtyizl8ZmvxoX9twGKH1GXx5ftoIKBAVjLXJnvo7HlWFVdZWOEL/pZR
         ADkXHTGTv/YdiMCYqaFtLm6sazra+vh8e2NHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xmtSKHNyUuFN/3CnrcXo5fsJh0365foqIVLIpRdOF28/uVTz61Zea64BzocWdzn2jz
         wpBB1idH0yQF/E7V/XChTHo43dIzJqpROdjhk7ZtkC8LxNyQSUeIGNj19u4cflPfYI/u
         yKrh2RZlnhGwhk9ATFZ9bb4OV5MeUu2nZkEJg=
Received: by 10.150.50.1 with SMTP id x1mr143245ybx.170.1213758251855;
        Tue, 17 Jun 2008 20:04:11 -0700 (PDT)
Received: from lintop ( [70.114.134.204])
        by mx.google.com with ESMTPS id m30sm3658846elf.12.2008.06.17.20.04.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 20:04:10 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Tue, 17 Jun 2008 22:03:56 -0500
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85354>


I guess I should have searched the list _before_ creating these patches
since I just now stumbled upon some of the questions about how this
should be done for example:

http://kerneltrap.org/mailarchive/git/2008/3/1/1035344

>From my testing this seems to work fine, but I may have missed a use
case.  I actually created these patches because I was annoyed that:

git shortlog --author=bohrer -s HEAD

didn't work, and this also fixes that issue.

--
Shawn
