From: Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH] [git-am] Handle "git show" output correctly
Date: Wed, 12 Sep 2012 14:05:08 -0400
Organization: Red Hat, Inc.
Message-ID: <1347473108.12986.6.camel@eddie.install.bos.redhat.com>
References: <vpqligfz1sa.fsf@bauges.imag.fr>
	 <1347464989-17421-1-git-send-email-pjones@redhat.com>
	 <vpqbohbz11h.fsf@bauges.imag.fr> <7v392ndu59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:05:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrJW-00035K-1s
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760960Ab2ILSFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54664 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508Ab2ILSFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:05:14 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8CI5Bv7011814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 12 Sep 2012 14:05:11 -0400
Received: from [10.3.112.24] (ovpn-112-24.phx2.redhat.com [10.3.112.24])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q8CI59wk020479;
	Wed, 12 Sep 2012 14:05:09 -0400
In-Reply-To: <7v392ndu59.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205318>

On Wed, 2012-09-12 at 10:32 -0700, Junio C Hamano wrote:
> We do not want to apply "git show" output that munges the log
> message, period.
> 
> If you want to give patches to somebody (or to yourself) via e-mail
> or via sneaker-net, "git format-patch" is there for you.  Do not
> butcher "am" to accept a format that is not meant for patch
> transport in the first place.
> 
> If you want to screw something in to your shelf, you would use a
> screw and a screwdriver.  You do not try to hammer a nail using your
> screwdriver, find that the screwdriver is not very useful as a
> hammer and modify the screwdriver to hit your nail.

That seems to be completely missing the point - people /send/ them
without knowing, and as a maintainer of several projects, it's /hostile/
to people who are trying to help by sending patches to go around in
circles with them about the fact that they typed the wrong command. I'd
rather just take the patch, but right now the tools won't let me, and
for completely arbitrary reasons.

Let me put it a different way - if you won't accept git-am handling "git
show" output because "git show" has output that wasn't designed to be
parsed ever, would you be opposed to a patch that switches the "git
show" output to be something usable?

-- 
  Peter
