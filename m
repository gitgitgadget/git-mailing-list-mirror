From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 22:27:51 -0700
Message-ID: <7vfxtmtlm0.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
 <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
 <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
 <7vej97x78v.fsf@gitster.siamese.dyndns.org>
 <m3abjushvs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 08:12:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm0CQ-0001tl-1d
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 07:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYDPF2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 01:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbYDPF2D
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 01:28:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYDPF2C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 01:28:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B33962E3F;
	Wed, 16 Apr 2008 01:28:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EDF6E2E3E; Wed, 16 Apr 2008 01:27:53 -0400 (EDT)
In-Reply-To: <m3abjushvs.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 15 Apr 2008 18:33:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79677>

Jakub Narebski <jnareb@gmail.com> writes:

> Please, let's don't repeat Mercurial mistake of placing unversioned
> information (such as branch names in case of Mercurial, or branches
> descriptions in this case) in-tree, i.e. version it.

Is it really a "mistake" in Mercurial's context?

I thought that their named branches do have defined "starting point", and
it is not a mistake at all for them to version "from this point on, this
lineage of history is associated with this symbolic name (which is a
branch)".

It probably does not make sense in the context of git where a branch is
defined to be "illusion" (at least currently).
