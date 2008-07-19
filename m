From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "error: non-monotonic index" during fresh linux-2.6.git cloning.
Date: Sat, 19 Jul 2008 11:15:16 -0700
Message-ID: <7v8wvx211n.fsf@gitster.siamese.dyndns.org>
References: <20080719174742.GA4253@2ka.mipt.ru>
 <7vfxq521ab.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKGyj-0007rd-TE
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 20:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYGSSPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbYGSSPX
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 14:15:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953AbYGSSPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 14:15:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8505A35547;
	Sat, 19 Jul 2008 14:15:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E01B235545; Sat, 19 Jul 2008 14:15:18 -0400 (EDT)
In-Reply-To: <7vfxq521ab.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 19 Jul 2008 11:10:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A66D7CA4-55BE-11DD-8411-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89122>

Junio C Hamano <gitster@pobox.com> writes:

> Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:
>
>> $ git clone http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> Getting alternates list for http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>> Getting pack list for http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>> Getting index for pack 81cec7c6b26c755e466a79de8dbe1c7b827a48d6
>> error: non-monotonic index
>> /usr/bin/git-clone: line 33:  2025 Segmentation fault git-http-fetch -v -a -w "$tname" "$name" "$1/"
>>
>> $ git --version
>> git version 1.4.4.4
>>
>> Fresh 32bit Debian testing.
>
> The repository you are cloning uses pack idx version #2; 1.4.4.4 predates it
> by a wide margin.

By the way, Debian folks are very aware of the issue and already has a
backported material to cut a 1.4.4.5, but I do not know what the release
schedule for their update is.

Is it an option for you to update to a more modern version from say
backports.org?  Everybody using git for anything serious should be using
1.5.3 or newer these days.
