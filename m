From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 16/16] p0002-index.sh: add perf test for the index formats
Date: Thu, 2 Aug 2012 19:50:31 +0700
Message-ID: <CACsJy8AG_dbqentgM+Y9pE=y0bGs2u57sBTF0oG5rNP4HSqY_A@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com> <1343905326-23790-17-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:51:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swurv-00045F-JM
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 14:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab2HBMvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 08:51:04 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:59829 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab2HBMvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 08:51:03 -0400
Received: by ghrr11 with SMTP id r11so2184015ghr.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RfRt5x9IxRMOy27qjd/kdIymgy+iCEhkynJnfvd4ets=;
        b=jE5oCo1mLvfNNK+waD0tEA/K5MpUmzve2fywpnTCPtUFFc9zFfWv653dLb+qZyrl61
         reb4+4up83aRnAJ9DpYEc0Be7FD5JuTB0qX7vvmLPV5r5SEUXU1OiLZhwEwMSoGGvHEU
         onSGG83A0vTZC4TjOGgi97FuBRkKHd9MZpKXl1eBhA+SqdqxdbkhN0o/FYska6kHHSDo
         ml3q9KeCRBlDLlKIVaZzhXoNr7TqMgJIYArDnsMh5jwyTdfzLpXsuUQrahTRyULOtGvf
         qBO8dUHjGwrnSxecylvWItsITva1x839r6KgSkXWl9VLKpa/o/B866zDh6ALf8SRjrkB
         xdjw==
Received: by 10.50.87.131 with SMTP id ay3mr3535228igb.36.1343911861666; Thu,
 02 Aug 2012 05:51:01 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 05:50:31 -0700 (PDT)
In-Reply-To: <1343905326-23790-17-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202774>

On Thu, Aug 2, 2012 at 6:02 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Add a performance test for index version [23]/4/5 by using
> git update-index --force-rewrite, thus testing both the reader
> and the writer speed of all index formats.

On the testing side, it may be an interesting idea to force the whole
test suite to use v5 by default. There are a few test cases that
require a specific index version. We can identify and rule them out.
That'll give v5 a lot more exercises.
-- 
Duy
