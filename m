From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 25 Jun 2008 02:34:17 -0700
Message-ID: <7vabh93lk6.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
 <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
 <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
 <7vej6oipea.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 11:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBRPQ-0002L6-Ht
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbYFYJe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 05:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbYFYJe2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 05:34:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbYFYJe1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 05:34:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75FBE18280;
	Wed, 25 Jun 2008 05:34:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A3AD61827E; Wed, 25 Jun 2008 05:34:20 -0400 (EDT)
X-maint-at: 74b1e1235781bbe5c90b802c1551446a5f5d69f1
X-master-at: 85fe23ed2a5d88463f5362a3e4fdd6f45a0555fd
In-Reply-To: <7vej6oipea.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jun 2008 00:25:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E70B8842-4299-11DD-8670-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86264>

We'd need a maint release soon to push out the mkstemp() breakage but n=
ot
tonight.  There are a handful changes that are in 'master' and 'next' t=
hat
need backport/backmerge before 1.5.6.1 happens.

* The 'maint' branch has these fixes since the last announcement.

Jan Kr=C3=BCger (1):
  git-svn: make rebuild respect rewriteRoot option

Patrick Higgins (1):
  Workaround for AIX mkstemp()


* The 'master' branch has these since the last announcement
  in addition to the above.

Jeff King (1):
  clone: create intermediate directories of destination repo

Junio C Hamano (2):
  pre-rebase hook update
  Ship sample hooks with .sample suffix

Michele Ballabio (1):
  t9301-fast-export.sh: Remove debug line

Nicolas Pitre (8):
  call init_pack_revindex() lazily
  implement some resilience against pack corruptions
  test case for pack resilience against corruptions
  refactor pack structure allocation
  optimize verify-pack a bit
  move show_pack_info() where it belongs
  verify-pack: check packed object CRC when using index version 2
  verify-pack: test for detection of index v2 object CRC mismatch
