From: Bart Bogaerts <bartbogaerts@gmail.com>
Subject: Git mv does not work with recursive submodules
Date: Tue, 6 Oct 2015 15:27:13 +0300
Message-ID: <CAOG-3GJtdpEhhaTZuKbMZqhq1qb=Ya7z8b8anZmK0+BO31FfcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 14:28:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjRLb-0006hD-6I
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 14:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbbJFM1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 08:27:55 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33197 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbJFM1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 08:27:53 -0400
Received: by wiclk2 with SMTP id lk2so164423322wic.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Q7tpSTn9n95FwTcHhBdSB5TKuOStnRrlPQ0NvcGgTfg=;
        b=D5GMI78FFnq0WzwBcQ0QImtTESUr5ieMf6YJG3LNg2GGah8J04NCWcsUiJE2DMFCq8
         OpDGhP34/PDxZ4qzn6al6GCoDJ+HnAk/L/JMOwNIaVEOPXpM0m5DwZ8joTDDktK2fNq6
         oVr91RnZseHhtg+HCpwwuQlvMpb0qkbT1kP4hjf3Io0pnqlBq54Zqcv71hkBWDCf85Jz
         ROv34bLzjruq9IAicoBMqV5QfJSiMN/wNES4syAGm8ut/Au3ik0hkoK6Tu7DF6LzEsiw
         b+heNsFCD/CQpkbqU2fA89+5vz3yrH9HR9FTCadGppdMj6asESLZmAfqJApv15myTYIt
         xMWA==
X-Received: by 10.194.184.136 with SMTP id eu8mr41194800wjc.151.1444134472412;
 Tue, 06 Oct 2015 05:27:52 -0700 (PDT)
Received: by 10.27.176.76 with HTTP; Tue, 6 Oct 2015 05:27:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279131>

For a complete description of this bug, see
http://stackoverflow.com/questions/32782382/git-moving-submodules-recursively-nested-submodules/32924692?noredirect=1#comment53760394_32924692

-- 
Bart Bogaerts
