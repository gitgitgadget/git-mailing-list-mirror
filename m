From: Bryan Turner <bturner@atlassian.com>
Subject: http-protocol question
Date: Tue, 2 Dec 2014 13:17:43 +1100
Message-ID: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:18:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvd30-0003zD-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 03:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbaLBCRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 21:17:44 -0500
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:34901 "HELO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752816AbaLBCRo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 21:17:44 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]) (using TLSv1) by na3sys009aob129.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVH0hR4ZeFE1zqVYuuCnpo60uyKl8CHXM@postini.com; Mon, 01 Dec 2014 18:17:44 PST
Received: by mail-oi0-f41.google.com with SMTP id a3so8469475oib.14
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 18:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=RQeegApBMU+/C4XZR6sEmg6iXWGv9ymufeLqAZQNWhs=;
        b=dgvpxqO8UcF2b5ivDK/qh0Bo/eHcX6fsfVyDITZrSg1JGFJEkoZ6jyE26Lt3c31KS3
         iJBgEYa/1Ny4O/WDnZjMqZYQdE/0psoOy8oLRIiXnBfscvWLTxgt1Ut7tVYjgaNWFDHf
         xHp/GJliV0TBEWvSsZ8dW3OBBtmu3lg+4f8fLPhpEF19vlUZnuk8wZkrgAHvHrnC9SqK
         i7GG0twlp5y1A+B0E+4hNw29isQF3U5bGTTecIidFsJFDoXqydUb4nSrynoAi2JuC4dc
         HmMd6XhCwFhTe+yxWXkFQcLoVCK71JHY1CmlEXPlJZKqLxUJQLuST1N2z+XzhcMLAGbW
         /3Lg==
X-Gm-Message-State: ALoCoQm4a3V9cAJ/qtJXo6GLUhCd+sxI0DTAixnMCdR/ggBzjK3mw3b7UvAHiywH4y3e9fK3VYO1AiisBMoCQ1L8VA/pNUAcuPujKZwuTtANZL1tM1dmH/LJk+HTnECBm7J3XIKV/AmCnax+sAAnKZGJ7+Q0aWP8Zg==
X-Received: by 10.202.2.79 with SMTP id 76mr34970903oic.106.1417486663420;
        Mon, 01 Dec 2014 18:17:43 -0800 (PST)
X-Received: by 10.202.2.79 with SMTP id 76mr34970897oic.106.1417486663277;
 Mon, 01 Dec 2014 18:17:43 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 1 Dec 2014 18:17:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260524>

In Documentation/technical/http-protocol.txt, there is the following statement:

"S: Parse the git-upload-pack request:

Verify all objects in `want` are directly reachable from refs.

The server MAY walk backwards through history or through
the reflog to permit slightly stale requests."

Is there actually logic somewhere in Git that does that "MAY walk
backwards" step? Or is that something another implementation of Git
may do but the standard Git does not?

Thanks,
Bryan Turner
