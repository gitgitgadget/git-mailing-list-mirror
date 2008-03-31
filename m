From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 31 Mar 2008 01:39:52 -0700
Message-ID: <7v8wzzmgmf.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
 <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
 <7v8x0wie56.fsf@gitster.siamese.dyndns.org>
 <7v4pbhv87i.fsf@gitster.siamese.dyndns.org>
 <7vfxv0npis.fsf@gitster.siamese.dyndns.org>
 <7vod9hr7p1.fsf@gitster.siamese.dyndns.org>
 <7veja192i4.fsf@gitster.siamese.dyndns.org>
 <7vk5jn7hb2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 10:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgFa8-0002ze-5F
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 10:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYCaIkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 04:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbYCaIkO
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 04:40:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbYCaIkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 04:40:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F75924CB;
	Mon, 31 Mar 2008 04:40:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B3B5E24CA; Mon, 31 Mar 2008 04:40:04 -0400 (EDT)
X-maint-at: f8dd64fdbf47ac65c1b8d2ed25b789ae2655f8c8
X-master-at: f58dbf23c33e0e79622f4344b48ab5bc9bc360cc
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78568>

A handful fixes are in 'master', and a few topics are still in 'next' as I
ran out of time this weekend.

* The 'master' branch has these since the last announcement.

Bryan Donlan (1):
  Silence cpio's "N blocks" output when cloning locally

Eric Wong (1):
  git-svn: remove redundant slashes from show-ignore

Junio C Hamano (4):
  builtin-prune: protect objects listed on the command line
  Add corner case tests for diff-index and diff-files
  diff-index: careful when inspecting work tree items
  diff-files: careful when inspecting work tree items

Marius Storm-Olsen (1):
  git-p4: Handle Windows EOLs properly after removal of p4 submit template
    handling.

Michele Ballabio (3):
  parse-options.c: introduce OPT_DATE
  Add tests for git-prune
  builtin-prune.c: use parse_options()
