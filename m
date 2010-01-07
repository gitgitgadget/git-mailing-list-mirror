From: Bryan Richardson <btricha@gmail.com>
Subject: Problem Using Git with Subversion Repository
Date: Thu, 7 Jan 2010 15:53:26 -0700
Message-ID: <3f81a4241001071453g24297atc1caab4a0a4ad176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 23:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT1ER-0007Wr-9A
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 23:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab0AGWx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 17:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844Ab0AGWx1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 17:53:27 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:56218 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab0AGWx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 17:53:26 -0500
Received: by yxe26 with SMTP id 26so18173558yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=L4puAvZJLSNSlcpzvtfIz83PqDnkBYZW3j+Dy6qsm2A=;
        b=fctrV094fsgaxIjXIlK6ytTFBzVn3AYNNNrPbikEW13xNmYQvcXVkZAK6Ff3FbHZ2o
         TGoEtme8nDUGgtfAo7Ut5der7lU1JmqXQ3MursVrONnhkVP6qmfmLj0sd6MHzRRb0FLX
         yjfhURv0QIYpmmPAZlX9ZPM5RYHAPE3WudIZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tR+sp+wMqvmimI/1FH3GfYxFpGeAlCitdzXgXRl3EWe1WsF/F0xfj/9R4L+DQQhMbY
         g3PQg0wwYj7i8ijFbKnCdxPJ/9AF+bNvF5JkSilFm9XQ//2qMlrFDQBpVTdZ4A9aYy3q
         rY/G6YLhDKy1R0Vr+vpgGoL4M2D9MQFgrTNsc=
Received: by 10.90.37.19 with SMTP id k19mr8580813agk.45.1262904806189; Thu, 
	07 Jan 2010 14:53:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136399>

Hello all,

Has anyone come across a similar problem as this?

Item already exists in filesystem: File already exists: filesystem
'/usr/local/svn/repos/my-apps/db', transaction '96-2v', path
'/app/trunk/vendor/rails/actionpack/test/fixtures/layout_tests/layouts/symlinked'
at /usr/lib/git-core/git-svn line 508

I *think* what happened is in a previous git-svn dcommit I removed the
vendor/rails directory (unfroze rails from my app) and now I'm trying
to freeze it again, in which case git-svn thinks a file needs to be
added (instead of modified) and the Subversion repository says the
file already exists.

Anyone know a way around it?!

--
Thanks!
Bryan
