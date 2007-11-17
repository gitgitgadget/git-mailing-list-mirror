From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 17 Nov 2007 13:00:10 -0800
Message-ID: <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 22:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItUmL-0005WJ-AG
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 22:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbXKQVAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 16:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXKQVAQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 16:00:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60929 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbXKQVAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 16:00:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E75562FA;
	Sat, 17 Nov 2007 16:00:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D51A96D42;
	Sat, 17 Nov 2007 16:00:34 -0500 (EST)
X-maint-at: 78e694787cb89cd008e237b17cdc7f0fa5a15d22
X-master-at: dee1b1ea9e1b0b889d9c53c2501e7f6250703341
In-Reply-To: <7vabpg9x5k.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Nov 2007 16:20:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65307>

* The 'maint' branch has these fixes since the last announcement.

There are a few candidate fixes for back-porting from the
development series (see "What's cooking" message).  I will
include them in 1.5.3.6, probably on or around 20th of this
month.

David Symonds (1):
  Improve accuracy of check for presence of deflateBound.

Jeff King (1):
  git-send-email: add charset header if we add encoded 'From'

Junio C Hamano (3):
  core.excludesfile clean-up
  Fix per-directory exclude handing for "git add"
  Update draft release notes for 1.5.3.6

Wincent Colaiuta (1):
  Fix t9101 test failure caused by Subversion "auto-props"


* The 'master' branch has these since the last announcement
  in addition to the above.

Guido Ostkamp (1):
  Remove unreachable statements

Jeff King (1):
  git-ls-files: add --exclude-standard

Johannes Sixt (1):
  refs.c: Remove unused get_ref_sha1()

Junio C Hamano (2):
  Fix per-directory exclude handing for "git add"
  Update draft release notes for 1.5.4

Mike Hommey (1):
  Fix and improve t7004 (git-tag tests)

Sergei Organov (3):
  Documentation: customize diff-options depending on particular
      command
  user-manual.txt: minor clarification.
  Documentation: fix git-clone manpage not to refer to itself
