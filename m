From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with test from aa9c83c2
Date: Fri, 29 Feb 2008 13:36:40 -0800
Message-ID: <7vtzjrbg2f.fsf@gitster.siamese.dyndns.org>
References: <20080229210410.GA26683@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:37:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCvK-0004nk-Kh
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760840AbYB2Vgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759253AbYB2Vgz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:36:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584AbYB2Vgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:36:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B7C02AC8;
	Fri, 29 Feb 2008 16:36:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 095D82AC7; Fri, 29 Feb 2008 16:36:48 -0500 (EST)
In-Reply-To: <20080229210410.GA26683@glandium.org> (Mike Hommey's message of
 "Fri, 29 Feb 2008 22:04:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75568>

Mike Hommey <mh@glandium.org> writes:

> When run as root, the test added in aa9c83c2 fails, because root is allowed
> to remove files in unreadable and unwriteable directories. Now, the
> problem is that I don't know what to do with that. Should we care ?

Of course not.  You are nuts running tests as root.

If "git foo" should refuse to remove a file for revision control
reason, and it does refuse correctly for a non-root user but it
fails to refuse when run as root, then that is a bug and we do
care about it.  IOW, I am not saying you are nuts running git as
root.
