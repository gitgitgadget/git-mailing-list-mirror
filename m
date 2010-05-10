From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 2
Date: Mon, 10 May 2010 17:25:48 +0200
Message-ID: <AANLkTimxmsj-WQZQjDGTrAuEdJHs-mhocSBZ7aIRLOQh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 17:26:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBUs5-0002DO-HZ
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 17:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0EJP0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 11:26:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52453 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab0EJP0L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 11:26:11 -0400
Received: by vws17 with SMTP id 17so159917vws.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=ZzlUqXcc/lNJ+DPlCcoM/iZFeMY9scGrt6GvKLMdI+A=;
        b=S5wYcEJQDZZ+O8vSCX3jajpKkUXjpdRX588j6hG/RNRY59B1iAfWJ7K1+4nFiVT3n1
         Xs/NWl7vszsrgW+Vj2/qBC5CuH36Ecs5DZOZfaqvNHAKK4Y0g0pP+o1JvtdYFT1QxO2r
         BQb16f7bbtzBVxdFrnzzUyIkhFib7C4DCgoBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=mK0WdOLQU/D1hXZlcW27B9ygdZwwbUOITh3CiFBsnxLp9/cJnaZg42HMOVUzz/piI/
         2rRWIwK1ovRlrXfrwNQJiva/eRSKVhcVu6mxqZgxBIIOouB8+xV76iuMYmQIb1XZpvHa
         pgCcDf89mDDNZmuBKkwf/n0v/CCXkw6jnNsK8=
Received: by 10.229.235.193 with SMTP id kh1mr3435806qcb.106.1273505168818; 
	Mon, 10 May 2010 08:26:08 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 10 May 2010 08:25:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146820>

Hi,

I'm happy to report that I've settled down and have been relatively
productive over the last couple of days. I've started writing a remote
helper, and already have a skeleton ready (WIP patch posted to mailing
list). I've also started contributing to David's SVN exporter. I plan
to clean up the exporter's code, and run some tests over the next few
days to get it ready for a 1.0 release. I'll probably integrate the
exporter into my helper in another week or so. I haven't begun work on
the importer and client yet.

-- Ram
