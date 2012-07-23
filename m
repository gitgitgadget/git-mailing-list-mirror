From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 0/5] Various merge / diff tool related minor clean-ups
 and improvements
Date: Mon, 23 Jul 2012 09:14:26 +0200
Message-ID: <500CF9D2.30102@gmail.com>
References: <500CF8CE.90906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jul 23 09:14:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StCqk-0001Ie-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab2GWHOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:14:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51210 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab2GWHOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:14:32 -0400
Received: by bkwj10 with SMTP id j10so4847818bkw.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3/unRSL/GLWyrfV8QMfRwTh7Qacm4C/8pcOmgWY9RbE=;
        b=RcdPxtPuS1yP+f4Qw95Sv5vUWambRwsroQ42T8e2ceuvASWGuHRjYzswvImXcGk/sj
         BKz+KWPU4JTXutQ88nTaiIQhdbQMfiUDKemOhXLEAdiJcMVy++aeTfO8TaoViJvV5T0L
         Hrt2VS0cxHV7c+EJdORFMhwgayw0bcZTMmzKKhUS8qp5rGRwVPeBpOnH8TwCe5xLdpbn
         NnHyvPl8wPzpNPDVXuRbNaaCK7WHs346a2qzm6yEJ2VfQ+whnKloahkklZ4EndWip+r+
         o9Z0x/XcobHjiogW9rxfboW9hasls+KiEuO7p1p+XAAvcBdUs+KFPNp1pw00lWrb9Jx2
         vn7w==
Received: by 10.205.123.134 with SMTP id gk6mr7330464bkc.3.1343027671231;
        Mon, 23 Jul 2012 00:14:31 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id gq2sm6108288bkc.13.2012.07.23.00.14.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 00:14:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <500CF8CE.90906@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201914>

This series introduces various minor clean-ups and improvements to the merge / diff tool scripts and documentation.

Sorry, the first version was missing a patch.

Sebastian Schuberth (5):
  Sort the list of tools that support both merging and diffing
    alphabetically
  Use variables for the lists of tools that support merging / diffing
  Explicitly list all valid diff tools and document --tool-help as an
    option
  Make sure to use Araxis' "compare" and not e.g. ImageMagick's
  Add a few more code comments and blank lines in guess_merge_tool

 Documentation/git-difftool.txt         |  9 ++++++---
 contrib/completion/git-completion.bash | 15 +++++++++++----
 git-mergetool--lib.sh                  |  6 ++++++
 mergetools/araxis                      |  8 +++++++-
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
1.7.11.msysgit.2
