From: Junio C Hamano <junio@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4.4
Date: Sun, 09 Mar 2008 13:28:39 -0700
Message-ID: <7v1w6jod54.fsf@gitster.siamese.dyndns.org>
References: <7vr6f31iwj.fsf@gitster.siamese.dyndns.org>
 <7vr6eknpjf.fsf@gitster.siamese.dyndns.org> <47D416C8.1020903@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755216AbYCIU3M@vger.kernel.org Sun Mar 09 21:30:17 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755216AbYCIU3M@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYS9s-0003If-GO
	for glk-linux-kernel-3@gmane.org; Sun, 09 Mar 2008 21:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbYCIU3M (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 9 Mar 2008 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbYCIU2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Mar 2008 16:28:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYCIU2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Mar 2008 16:28:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A822E24EF;
	Sun,  9 Mar 2008 16:28:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F263524EE; Sun,  9 Mar 2008 16:28:41 -0400 (EDT)
In-Reply-To: <47D416C8.1020903@garzik.org> (Jeff Garzik's message of "Sun, 09
 Mar 2008 12:56:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76665>

Jeff Garzik <jeff@garzik.org> writes:

> Junio C Hamano wrote:
>> The latest maintenance release GIT 1.5.4.4 is available at the
>> usual places:
>>
>>   http://www.kernel.org/pub/software/scm/git/
>>
>>   git-1.5.4.4.tar.{gz,bz2}			(tarball)
>>   git-htmldocs-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
>>   git-manpages-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
>>   RPMS/$arch/git-*-1.5.4.4-1.$arch.rpm	(RPM)
>
> Does it address the following issue, present in git-core-1.5.4.1-1.fc8?
>
> http://marc.info/?l=git&m=120423022832530&w=2

I do not think so.

Is it really an issue, or is it just a warning message unread/unfollowed?

I am comparing the last line you quoted from the command output in that
message, which suggests the user to run 'git prune', and your comment on
the next line in that message that says "I regularly run 'git gc'", and
scratching my head.  I cannot tell if you regularly run 'git prune' or not
from it...
