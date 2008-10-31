From: Pierre Habouzit <madcoder@debian.org>
Subject: Further enhancement proposal for git-send-email
Date: Fri, 31 Oct 2008 13:36:46 +0100
Message-ID: <1225456609-694-1-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 13:38:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvtGY-00007v-JX
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 13:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbYJaMg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 08:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYJaMgz
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 08:36:55 -0400
Received: from pan.madism.org ([88.191.52.104]:54662 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYJaMgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 08:36:52 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3619E3B5AC
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 13:36:51 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3044C5EE23A; Fri, 31 Oct 2008 13:36:49 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.763.g0275.dirty
In-Reply-To: <1225450632-7230-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99582>

Here is a three patch series (again).

[PATCH 1/3] git send-email: make the message file name more specific.
  -> quite independant, and should IMHO be taken.


[PATCH 2/3] git send-email: do not ask questions when --compose is used.
[PATCH 3/3] git send-email: turn --compose on when more than one patch.

  Those two patches enhance git-send-email by making ask less questions
  when --compose is used (as it can grab the subject, from and reply-to
  from the buffer).

  It also turns --compose on by default as soon as there is more than
  one patch, as I believe than commenting a patch series is more often
  done than not. It's is really trivial to "refuse" to comment the
  series by just erasing the full buffer content, which should not
  really be too anoying (or one can explicitely pass --no-compose for
  the same result).

  It's probable that those two changes may trigger some discussion
  though, but I just used that to send this series, and I can tell with
  this git-send-email is nearer what I would like it to be.
