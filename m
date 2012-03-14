From: David Bremner <david@tethera.net>
Subject: Re: [PATCH jh/notes-merge-in-git-dir-worktree] fixup! t3310 on Windows
Date: Wed, 14 Mar 2012 09:20:11 -0300
Message-ID: <87fwdbnzlw.fsf@zancas.localnet>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com> <1331563647-1909-1-git-send-email-johan@herland.net> <1331563647-1909-2-git-send-email-johan@herland.net> <4F60593A.5070106@viscovery.net> <CALKQrgdjYvkSBn8UORSsZecSVyhJbfU5tjU0hPJOYn1OMVxMyw@mail.gmail.com> <4F60882E.90303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:20:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7nCI-0005it-So
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 13:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758969Ab2CNMUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 08:20:24 -0400
Received: from tesseract.cs.unb.ca ([131.202.240.238]:36908 "EHLO
	tesseract.cs.unb.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab2CNMUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 08:20:24 -0400
Received: from fctnnbsc30w-142166230117.dhcp-dynamic.fibreop.nb.bellaliant.net ([142.166.230.117] helo=zancas.localnet)
	by tesseract.cs.unb.ca with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <bremner@unb.ca>)
	id 1S7nBh-0002vt-66; Wed, 14 Mar 2012 09:20:17 -0300
Received: from bremner by zancas.localnet with local (Exim 4.77)
	(envelope-from <bremner@unb.ca>)
	id 1S7nBb-0007xO-TW; Wed, 14 Mar 2012 09:20:11 -0300
In-Reply-To: <4F60882E.90303@viscovery.net>
User-Agent: Notmuch/0.12~rc1 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
X-Spam-Score: -1.0
X-Spam_bar: -
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193100>


> I doubt that the use-case that is tested here makes sense.

To me, the obvious workflow to resolve notes conflicts is is chdir into
this directory, edit files, and then call git notes merge --commit. The
(implicit) requirement that one cannot call commit from within the
directory you edited files was quite surprising to me. So in my opinion
the use case does make sense, which is why I submitted the bug in the
first place.

In any case, it should not fail silently, whether or not one is required
to chdir back to the worktree before calling git notes merge --commit.

d
