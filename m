From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: get-upstream
Date: Thu, 23 Sep 2010 13:46:06 +1000
Message-ID: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 05:46:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyclV-0006wB-GM
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 05:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab0IWDq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 23:46:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39997 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0IWDq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 23:46:27 -0400
Received: by qwh6 with SMTP id 6so876426qwh.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=yxaYW3uyG04BQdGGLp9VzP7DgvXpppbermbHhl9AW00=;
        b=cRtyLEVvAQcFBYToJsHJPvmgg2odB2v5CjGjJzFCf9UYiBJkMjbP3oLiUtZi0+V4a9
         Jo6PDloGt8P779x+mI32QfW8sRvQb0pWZxcAVjoZqfYb9JRdOtjIZw4IO/4FX0VRowEj
         /5mcIVquJ7dir0MHgJoRRx++iDaDJpDmdk6vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=h0MwHxtrgO82vNK2pYxTbrqXrQpQ+S/MmEvTK8wfGmF2yvRVEO5ZffEX2nta2ONktS
         80DXcgGtKtqvHporaw3p4f0seSynpQolKsSIylKmx797nhEnMPBPfBhYQX4EEtx4clBA
         4KI7hzxmosFc2ADa5t+nRSRSj1ZH36lnopz2c=
Received: by 10.220.158.73 with SMTP id e9mr565228vcx.60.1285213586751; Wed,
 22 Sep 2010 20:46:26 -0700 (PDT)
Received: by 10.220.181.65 with HTTP; Wed, 22 Sep 2010 20:46:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156844>

Is there an easy command to get a symbolic reference to the upstream
branch of a tracking branch?

For example, to get the current branch name I can do this:

$ git symbolic-ref HEAD
refs/heads/mybranchname

Now I can see the upstream name as follows

$ git branch -vv
branch1 ...
mybranchname sha [upstreamname: ahead n] ...
branch3 ...

My question is is there a way to get upstreamname directly to stdout,
similar to the symbolic-ref command?

(I don't want to have to type it manually; tab completion helps a
little, but looking for more. Plus this would be necessary to avoid
scraping in a script.)
