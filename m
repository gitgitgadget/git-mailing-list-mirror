From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Merge commit before branch tip
Date: Mon, 26 Jul 2010 11:38:04 -0400
Message-ID: <AANLkTikp5dHz97qp3pf+DE-wABNVYTGAQ+h30D9Fa04c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 17:38:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPkp-0006Uv-VC
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab0GZPiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:38:06 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45110 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab0GZPiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 11:38:05 -0400
Received: by qwh6 with SMTP id 6so155679qwh.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 08:38:04 -0700 (PDT)
Received: by 10.224.43.100 with SMTP id v36mr6152019qae.201.1280158684612; 
	Mon, 26 Jul 2010 08:38:04 -0700 (PDT)
Received: by 10.229.236.2 with HTTP; Mon, 26 Jul 2010 08:38:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151847>

I realize this is not a best practice but is it possible to merge a
branch but at a point before the branch tip?

This came up recently for us. There are 9 new commits in our stable
branch that need to be merged back into "master". However, there is 1
commit (the branch tip) that we're not all that happy with and don't
want to merge into the "master".

Ideally, I'd like them to show up as a merge rather than a cherry-pick
basically as if I'd done the merge before that latest commit was made.
