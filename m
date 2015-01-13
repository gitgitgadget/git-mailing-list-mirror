From: Ivo Anjo <ivo.anjo@ist.utl.pt>
Subject: How to prevent empty git commit --amend
Date: Tue, 13 Jan 2015 08:56:39 +0000
Message-ID: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 09:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAxHT-0008M0-6R
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 09:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbbAMI4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 03:56:44 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:39258 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbbAMI4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 03:56:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 1DDA5700814C
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 08:56:41 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.6.4 (20090625) (Debian) at ist.utl.pt
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id LCNWJQuEti8N for <git@vger.kernel.org>;
	Tue, 13 Jan 2015 08:56:40 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id E45F2700814F
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 08:56:40 +0000 (WET)
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com [209.85.216.174])
	(Authenticated sender: ist155460)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 6A57A200D3AD
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 08:56:40 +0000 (WET)
Received: by mail-qc0-f174.google.com with SMTP id c9so1247365qcz.5
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 00:56:39 -0800 (PST)
X-Received: by 10.140.81.166 with SMTP id f35mr54346042qgd.0.1421139399404;
 Tue, 13 Jan 2015 00:56:39 -0800 (PST)
Received: by 10.229.159.14 with HTTP; Tue, 13 Jan 2015 00:56:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262329>

Hello,

I sometimes get a bit distracted when making amends. Once or twice per
week I do a commit, then realize I added something I shouldn't, or
forgot to add a line here or there, and then I do a git commit --amend
to fix it.

The thing is, a lot of times I forget to stage the modifications I did.
And here is my issue: *git commit* refuses to work when there's
nothing to commit, but *git commit --amend* happily pops up the editor
and says you have committed something when you did not add/change
anything.

Is there a way to prevent a *git commit --amend** with nothing to
commit from working?
If not, I would like to suggest that this feature would be very helpful :)

Thanks for your time!
Ivo Anjo
