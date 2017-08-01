Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A051F991
	for <e@80x24.org>; Tue,  1 Aug 2017 02:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbdHACqL (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 22:46:11 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:49536 "EHLO
        johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751716AbdHACqK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 22:46:10 -0400
X-Greylist: delayed 2113 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jul 2017 22:46:10 EDT
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller)
        by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <greened@obbligato.org>)
        id 1dcMe8-0006qM-Rz
        for git@vger.kernel.org; Mon, 31 Jul 2017 21:10:57 -0500
From:   greened@obbligato.org (David A. Greene)
To:     git@vger.kernel.org
Subject: [RFC] Moving main git-subtree development. to GitHub
Date:   Mon, 31 Jul 2017 21:10:54 -0500
Message-ID: <87mv7kf369.fsf@waller.obbligato.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Filter-Spam-Score:  ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I have decided that moving git-subtree development off of the main git
mailing list is the best way to address the needs of git-subtree users
while providing the flexibility necessary to get it in shape for
eventual "official" status in the git project.

Over the last year and a half I have been working on some new features
for git-subtree, motivated by day-job requirements.  Much of that effort
has been spent hardening the new code in a real work environment, driven
by real-world needs.  I believe it is now ready for public consumption.
However, because it is a large change, it will need lots of public
exposure before it can be considered safe for general use.  Essentially,
I would like to do a "beta" release of the new code while not impacting
existing users of git-subtree in contrib.

During this time and due to work and life commitments, I have not been
able to keep up with the git mailing list as I would like.  Questions
and patches related to git-subtree have languished and I don't want to
lose that good work by our users.  Therefore, I would like to transfer
the main development activity over to GitHub.  GitHub's patch tracking,
review and feedback infrastructure works better for me that a large
mailing list with patches sent via e-mail.  It is easy to lose things in
a sea of conversations.  It's completely personal preference but I think
a switch to GitHub will also make tracking git-subtree's progress easier
for users.  Moving the main development to GitHub will also allow
git-subtree users to be more visible, ask questions and help each other
out.

Going forward, I would like to do the main feature and bug fix work on
GitHub and periodically subtree-merge to git's main repository under
contrib when the code has stabilized and we are reasonably confident
interfaces are stable.  This will allow us to experiment with new ideas
while keeping a stable codebase for end users.  I expect a lot of
re-engineering of the core bits of git-subtree to bring it into
compliance with git's coding standards, support new features and provide
a better user experience.

I believe keeping a stable git-subtree in contrib is valuable.
git-subtree and git-submodule provide alternative solutions to similar
problems, as well as each solving problems the other does not.
Anecdotally, I noticed an uptick in git-subtree user activity after the
move into contrib.  I would like to maintain that visibilty.

Does this mode of operation work for the larger git community?  Are
there suggestions of how to make this work as smoothly as possible?

Thank you for your feedback and support of git-subtree!

                          -David
