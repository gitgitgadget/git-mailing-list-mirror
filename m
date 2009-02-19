From: John Tapsell <johnflux@gmail.com>
Subject: git rebase -i
Date: Thu, 19 Feb 2009 09:21:49 +0000
Message-ID: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 10:23:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La57o-0002Mt-MV
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 10:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbZBSJVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 04:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbZBSJVv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 04:21:51 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:37131 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbZBSJVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 04:21:50 -0500
Received: by gxk22 with SMTP id 22so805349gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 01:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=nj2HNfLaRoWiproNf6mS8bAfuFvLUYWSkthOzsMNlUM=;
        b=wSUMaMxrHPr3TW5U4i0z1YYcYZIDR/ciK9oe0WWgDhmTuwCaBFty4BGOM0dbNLA1aM
         V+IgvKK22R7KaJVei14YwmTp0By2b9WnWJi+0abTxLDHLLWNA6Mtqc0sVl1pa35ATjy9
         Vl18c5d7P6JLyb4Ehj8NRCtY2NCi9LYS/gZpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=W5M5C+h+fFLMpOf5xsDupKc39ONeCODHG8xYpUKW5Vk0tilLDkXxebarAlpfpOjzeD
         paL0IxNvRI2DKwagKDJaH1lqdmQk3ZbsMjlCbtzY65MmWC+AKRx+xam9d8TRRps229tZ
         qb9R46RGRFinNMZH/zzCjWvs1zGne9qtDEq6U=
Received: by 10.150.220.19 with SMTP id s19mr156698ybg.204.1235035309294; Thu, 
	19 Feb 2009 01:21:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110651>

Hi,

  I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
doesn't matter if you go back 'too far' I just always use HEAD~10 even
if it's just for the last or so commit.

  Would there be any objections to making  'git rebase -i' default to
HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
helps a bit with making it easier to use.

John
