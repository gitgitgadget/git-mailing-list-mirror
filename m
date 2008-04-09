From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 09 Apr 2008 02:44:24 -0700
Message-ID: <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 11:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjWvV-0004Ts-IV
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 11:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYDIJsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 05:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYDIJsT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 05:48:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYDIJsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 05:48:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF79F15BB9;
	Wed,  9 Apr 2008 05:44:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3E47915BB8; Wed,  9 Apr 2008 05:44:31 -0400 (EDT)
X-maint-at: f8dd64fdbf47ac65c1b8d2ed25b789ae2655f8c8
X-master-at: 2a5fe2545882721d6841bad11dae0f15b454bf0d
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79092>

* The 'master' branch has these since v1.5.5.

Frank Lichtenheld (4):
  var: Don't require to be in a git repository.
  Git.pm: Don't require a repository instance for config
  Git.pm: Don't require repository instance for ident
  send-email: Don't require to be called in a repository

Gerrit Pape (2):
  gitweb: fallback to system-wide config file if default config does not
    exist
  gitweb: fallback to system-wide config file (fixup)

Govind Salinas (1):
  pretty.c: add %x00 format specifier.

Jeff King (2):
  add--interactive: ignore mode change in 'p'atch command
  add--interactive: allow user to choose mode update

Junio C Hamano (4):
  Optimize rename detection for a huge diff
  t5300: add test for "unpack-objects --strict"
  unpack-objects: fix --strict handling
  rebase [--onto O] A B: omit needless checkout

Martin Koegler (3):
  unpack-objects: prevent writing of inconsistent objects
  receive-pack: allow using --strict mode for unpacking objects
  t5300: add test for "index-pack --strict"
