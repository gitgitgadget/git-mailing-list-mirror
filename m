From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT-0.8.3.3 (was: CGIT 0.8.3.1 "chokes" on some bare 
	repos)
Date: Tue, 3 Aug 2010 23:00:24 +0200
Message-ID: <AANLkTikBdqmvXrfo2fPj6m9z00ybprkq7Mmm8WObBTHt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Euguess@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 03 23:00:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgObA-0003WT-6i
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757715Ab0HCVA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 17:00:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50389 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0HCVA0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 17:00:26 -0400
Received: by fxm14 with SMTP id 14so2154774fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=+hag5MeZpf9jOJsjLjEo4ZcfoWyHvxTroytJhYcIC5g=;
        b=WXcpWxg0BbgRH3YMPtsS9maSYMitR0UroqVodvsXKX6O4ru3YqdGSIQRPWumJY4nnH
         5o5/YEQhqOfF8mIjdjYgG/a02xwOApTXI6Tb06/ALg3QONn/PWnXJ++DGJg+ElmNirHU
         +W5VbrFqb0rTXsSGBpekcbq97RX0qO0YfZMlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Heo48Ar/2PHsrq3WSLj5iOOwyTOfGm+RWYnC+BhVn0wATQpfgvGVKmXuLTQbsAeaj2
         viOcYXQkfI70TJnYPxMbWsQbmYUWQGk6dci/oJ6JEOl+riJP0U4B4QuFKrgzwXUYDBQH
         7VIT1oVPxu/lQU8zqNwg1mfLPSgBXiZIUGt6g=
Received: by 10.239.181.74 with SMTP id l10mr3794hbg.33.1280869224651; Tue, 03 
	Aug 2010 14:00:24 -0700 (PDT)
Received: by 10.239.165.79 with HTTP; Tue, 3 Aug 2010 14:00:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152538>

A bugfix-release for cgit (a web interface for git repositories) is
now available at http://hjemli.net/git/cgit.

Changes since 0.8.3.2:

Lars Hjemli (2):
      ui-refs.c: avoid segfault on unparsed ref objects
      CGIT 0.8.3.3

R=C3=A9mi Lagac=C3=A9 (1):
      Reencode author and committer
