From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2008, #03; Fri, 19)
Date: Fri, 19 Sep 2008 15:45:50 -0700
Message-ID: <7vk5d7pxep.fsf@gitster.siamese.dyndns.org>
References: <7vprmzrh7w.fsf@gitster.siamese.dyndns.org>
 <200809200020.32285.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Sep 20 00:47:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgoki-0008IV-2p
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 00:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbYISWp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 18:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbYISWp4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 18:45:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbYISWpz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 18:45:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B42D962F93;
	Fri, 19 Sep 2008 18:45:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1920962F91; Fri, 19 Sep 2008 18:45:51 -0400 (EDT)
In-Reply-To: <200809200020.32285.trast@student.ethz.ch> (Thomas Rast's
 message of "Sat, 20 Sep 2008 00:20:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7C6BF24-869C-11DD-AD05-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96322>

Thomas Rast <trast@student.ethz.ch> writes:

> Regarding _the_ recommended workflow, I can think of a few possible
> approaches:
>
> a) Authoritative: either because we really believe it's the One True
>    Workflow, or just because we want to sound so.
>
> b) Descriptive: describe it as the workflow "we" use (presumably this
>    includes linux.git which may be worth mentioning; I haven't touched
>    the kernel though).
>
> c) Encyclopedic: describe and classify as many recipes (building
>    blocks) and workflows as possible in an attempt to build a
>    complete reference of sorts.
>
> d) Blind eye: we're just the tool.  Others can devise workflows.
>
> I certainly aimed the patch at (a), since I wanted to be able to point
> people at it (mostly on #git).  The resources I learned Git with,
> except for the videos, just show simple examples of pull/push usage,
> which I found both unsatisfactory (e.g. I want to know _why_ it's a
> good idea to make topic branches) and incomplete.  This list is an
> excellent place to learn, but I doubt that's an effort the average
> user is willing to put in.

I think we should be honest and not try to do (a) nor (c).  And as I
already said, as (b) your description looked fine, but it wasn't very
encouraging that not many people commented on it (nor said "Yeah, that's
what I was missing, thanks").
