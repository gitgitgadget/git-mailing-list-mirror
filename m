From: "James North" <tocapicha@gmail.com>
Subject: Encoding problems using git-svn
Date: Wed, 29 Oct 2008 04:14:26 +0100
Message-ID: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 04:15:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv1XE-0007dm-8n
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 04:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYJ2DO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 23:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYJ2DO2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 23:14:28 -0400
Received: from qb-out-0506.google.com ([72.14.204.233]:47971 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYJ2DO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 23:14:28 -0400
Received: by qb-out-0506.google.com with SMTP id f11so2174111qba.17
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 20:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=vKo0Vu1QJnHIGcb3CcN7FH/teflUujznexYcHdquv7A=;
        b=THFBckiEeM8yFk40YIKyF5c/B8Ve4EY5xx1THkH46snCb4zEJU/Yv++FtWVN2IyB0z
         +T2zTz+PoPCxL9AgIJVA74xoDFNOg7UagQXvR4Keln1yumc95sL4lqcFs7D0fqnOrXGw
         K+WDqCKuKUX/GrFP4kTUhkTBJ77wJx6OvPmbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=TQUUCiptEcOIsKhnAYza/ACtEMJuKsuz7VApS7knKBxdOCCraCD9mtzC68L8vKhDjv
         /zWLBafY5eKJsRcqPSGMqRypzGf2e4ZPCGTaC3NEoarbvsI94VtzTMxTmSH68FEiXi5p
         eFbC5yIgeaAAYZrOInHFkryTMnKvqvFhXU3yQ=
Received: by 10.187.226.7 with SMTP id d7mr784897far.62.1225250066719;
        Tue, 28 Oct 2008 20:14:26 -0700 (PDT)
Received: by 10.187.203.14 with HTTP; Tue, 28 Oct 2008 20:14:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99346>

Hi,

I'm using git-svn on a system with ISO-8859-1 encoding. The problem is
when I try to use "git svn dcommit" to send changes to a remote svn
(also ISO-8859-1).

Seems like git-svn is sending commit messages with utf-8 (just a
guessing...) and they look bad on the remote svn log. E.g. "Ca?\241a
de cami?\243n"

I have tried using i18n.commitencoding=ISO-8859-1 as suggested by the
warning when doing "git svn dcommit" but messages still are sent with
wrong encoding.

I'm mising something?

Thanks everyone
