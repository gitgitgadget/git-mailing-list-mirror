From: Carter Lamb <carter.lamb@livetext.com>
Subject: git diff
Date: Thu, 13 Jan 2011 16:46:16 -0600
Message-ID: <AANLkTik7cfu_DS=GS5gz_Tu94NC=ZGi-eA8YXztyd9Ra@mail.gmail.com>
References: <AANLkTi=ASvicFGaaDfqxjOxJELWPLKsQwvk7rEeT36Fh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 23:47:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdVwZ-0005QV-MJ
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 23:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283Ab1AMWqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 17:46:43 -0500
Received: from nospam.livetext.com ([64.94.43.179]:55220 "EHLO
	nospam.livetext.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136Ab1AMWqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 17:46:38 -0500
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com [74.125.82.179])
	by nospam.livetext.com (Postfix) with ESMTP id 98A97246DDC
	for <git@vger.kernel.org>; Thu, 13 Jan 2011 16:46:37 -0600 (CST)
Received: by wyi11 with SMTP id 11so2220168wyi.10
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 14:46:36 -0800 (PST)
Received: by 10.216.13.194 with SMTP id b44mr2383516web.68.1294958796828; Thu,
 13 Jan 2011 14:46:36 -0800 (PST)
Received: by 10.216.71.145 with HTTP; Thu, 13 Jan 2011 14:46:16 -0800 (PST)
In-Reply-To: <AANLkTi=ASvicFGaaDfqxjOxJELWPLKsQwvk7rEeT36Fh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165067>

I use git diff --summary --numstat <commit> to report the files
modified, created, and deleted between the current commit and some
prior commit. The --stat and --numstat options count the lines added
and deleted for each file. Is there a way to report the lines modified
for each file. For example:

Given content below for commit 1:
aaaaa
ccccc

Given content below for commit 2:
aaaaa
bbbbb
ccccc

Given content below for commit 3:
Aaaaa
Bbbbb
ccccc
ddddd

git diff --numstat between commits 1 and 2 will report one line added.
git diff --numstat between commits 2 and 3 will report three lines
added and two lines deleted.
I'd like to see the diff between commits 2 and 3 report two lines
modified and one line added.
Can this be done?

Best,
Carter
