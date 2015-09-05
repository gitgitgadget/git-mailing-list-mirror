From: sigo <spam@sigo.pl>
Subject: Standardization of messages - dot after the sentence
Date: Sat, 5 Sep 2015 14:22:18 +0200
Message-ID: <CALx9kCVwpOvBfTxBi8gn7MBajEbuMLGP_HAJ0TW3XGzmUE0=QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 14:22:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYCUB-0001xz-Rm
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 14:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbbIEMWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 08:22:20 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36697 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbbIEMWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 08:22:19 -0400
Received: by ioii196 with SMTP id i196so49526663ioi.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 05:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4brKd54Ujs+eRZ2KQ1prg6QlyGdRzc7N8IeMm1lbHuA=;
        b=fPmHTM1ookLMa/j3rSd2C2051CaeV7ZC1aFnMN/9eA32aCm8OJA8bQYQYU1kJMIofP
         PI+XuAgGXsfwIVmdEPePa1ppQn0+eo7/OFmz6pWpT4WBPM7IbFXX7WWrxtcLs0wruxsv
         U2WhSGE8I1EB/+q9lItnybMmrKR8twRQTGWQ0RjSgrXO9Q80AU2f+Qemy2BAV6BQt5Pf
         O2M7VHQJUb82u6wrVEkgMmbnPU7zqPGFjsn7Zkz6jU1Zpf5vjsrWxg/CLBwdepHj9M4t
         FmZ1Ldx2Lw/VH2i8Czo7ily58ZUNNUPvb4WPH2NLsqUOiS1skMM34i+gohEmM90Gn9Id
         5Vsw==
X-Received: by 10.107.30.13 with SMTP id e13mr15337791ioe.57.1441455739199;
        Sat, 05 Sep 2015 05:22:19 -0700 (PDT)
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com. [209.85.223.170])
        by smtp.gmail.com with ESMTPSA id b78sm3490234ioe.2.2015.09.05.05.22.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2015 05:22:19 -0700 (PDT)
Received: by iofh134 with SMTP id h134so49689238iof.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 05:22:18 -0700 (PDT)
X-Received: by 10.107.160.82 with SMTP id j79mr6142750ioe.18.1441455738735;
 Sat, 05 Sep 2015 05:22:18 -0700 (PDT)
Received: by 10.79.38.199 with HTTP; Sat, 5 Sep 2015 05:22:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277368>

I've found really "little bug" with dots in the git output.

$ git push
Everything up-to-date

git pull
Already up-to-date.

Could all phrases contain dots? :)
