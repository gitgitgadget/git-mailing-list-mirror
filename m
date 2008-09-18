From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git equivalent to svn info?
Date: Wed, 17 Sep 2008 22:50:51 -0700
Message-ID: <7v4p4e0zpg.fsf@gitster.siamese.dyndns.org>
References: <1ed9467a-ca0d-4f9f-813d-9ff92dd7413e@s28g2000prd.googlegroups.com>
 <1221689614.7164.31.camel@localhost> <20080917224856.GT10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: public-git-users-/JYPxA39Uh5TLH3MbocFFw@lo.gmane.org
X-From: git-owner@vger.kernel.org Thu Sep 18 07:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCQy-0004mA-S1
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 07:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbYIRFvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 01:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbYIRFu7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 01:50:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYIRFu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 01:50:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C21CF62832;
	Thu, 18 Sep 2008 01:50:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C2C862831; Thu, 18 Sep 2008 01:50:53 -0400 (EDT)
In-Reply-To: <20080917224856.GT10360@machine.or.cz> (Petr Baudis's message of
 "Thu, 18 Sep 2008 00:48:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C35C302E-8545-11DD-8448-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96158>

Petr Baudis <pasky-+ZI9xUNit7I@public.gmane.org> writes:

> On Thu, Sep 18, 2008 at 10:13:34AM +1200, Francois Marier wrote:
>> On Wed, 2008-09-17 at 14:46 -0700, skillzero-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> > Is there an easy way with git to get the URL of the repository that
>> > you cloned from, similar to what svn info shows for a subversion
>> > repository? I see it's stored in [remote "origin"]->url section of
>> > the .git/config, but I was hoping for an easy-to-remember command to
>> > display it.
>> 
>> I normally use "git remote show origin"
>
> You can also get a quick overview with git remote -v.

Ah, that reminds me...

It is Ok to have more than one URL defined for a remote if you use that
remote for push, but "git remote -v" complains, like this:

    $ git remote -v
    warning: Remote builders has more than one URL
    builders        box-fc5:git/
    ko-private	m.kernel.org:git/

when I have 3 URLs (box-fc5, box-fc7 and box-fc9) for "builders" remote to
push into.

Could somebody fix this, please?
