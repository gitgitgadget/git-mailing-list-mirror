From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix http-push test
Date: Mon, 07 Jul 2008 12:54:41 -0700
Message-ID: <7vej6531xa.fsf@gitster.siamese.dyndns.org>
References: <1215457357-24279-1-git-send-email-mh@glandium.org>
 <20080707190847.GA24489@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 21:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFwoO-00081a-8Z
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 21:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbYGGTyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755702AbYGGTyu
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 15:54:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbYGGTyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 15:54:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B24413458;
	Mon,  7 Jul 2008 15:54:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C761513454; Mon,  7 Jul 2008 15:54:43 -0400 (EDT)
In-Reply-To: <20080707190847.GA24489@glandium.org> (Mike Hommey's message of
 "Mon, 7 Jul 2008 21:08:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E0440B2-4C5E-11DD-B645-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87646>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Jul 07, 2008 at 09:02:37PM +0200, Mike Hommey wrote:
>> http-push test has been broken by 4a7aaccd adding a space character
>> in the place where the test is being run.
>> ---
>> 
>>  Note that the 4th test doesn't pass because of the new git clone, that
>>  creates the clone with packed-refs instead of refs/heads/master that
>>  push is requiring. But this also means push was already broken with
>>  repositories with packed-refs.
>
> Actually, the 3rd is failing too, but fails to report an error because
> git push returns no error code in cases where it says:
>   No refs in common and none specified; doing nothing.

Ok, when you are done checking, care to send in a replacement patch with
failing one marked with test_expect_failure?

You do not have to hurry, I am currently at day job and already deep in
today's integration cycle during the lunchtime, and won't be able to queue
new fixes for several hours from now, so your patch will be part of
tomorrow's or tonight's cycle anyway.
