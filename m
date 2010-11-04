From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 02:43:41 -0700
Message-ID: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
References: <1288847836-84882-1-git-send-email-kevin@sb.org> <AANLkTin7d-RJcy4CHmd5A6LaiphAvHEdbsxJExHt317_@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 04 10:44:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDwMT-0002CB-9S
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab0KDJnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 05:43:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54290 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab0KDJno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 05:43:44 -0400
Received: by gyh4 with SMTP id 4so1195858gyh.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:43:44 -0700 (PDT)
Received: by 10.231.19.136 with SMTP id a8mr255370ibb.86.1288863823511;
        Thu, 04 Nov 2010 02:43:43 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id 8sm12572416iba.4.2010.11.04.02.43.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 02:43:42 -0700 (PDT)
In-Reply-To: <AANLkTin7d-RJcy4CHmd5A6LaiphAvHEdbsxJExHt317_@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160708>

On Nov 4, 2010, at 2:36 AM, Erik Faye-Lund wrote:

> On Thu, Nov 4, 2010 at 6:17 AM, Kevin Ballard <kevin@sb.org> wrote:
>> Add a new command "shell", which takes an option commit. It simply exits
>> to the shell with the commit (if given) and a message telling the user how
>> to resume the rebase. This is effectively the same thing as "x false" but
>> much friendlier to the user.
>> 
> 
> I'm sorry if I'm missing something, but how is this different from "edit"?

Edit cherry-picks a commit, then exits to the shell. I needed to exit to the
shell without cherry-picking a commit. As stated in the comments above the
diffstat on the patch, the original use case here was something along the
lines of

  edit 12345 some commit
  fixup 23456 another commit
  shell I want to amend the commit after the fixup

-Kevin Ballard
