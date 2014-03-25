From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC/PATCH 1/4] test-lib: add test_dir_is_empty()
Date: Tue, 25 Mar 2014 22:06:36 +0100
Message-ID: <87y4zyt2cj.fsf@fencepost.gnu.org>
References: <5331B6F6.60501@web.de> <5331B717.5010600@web.de>
	<xmqq4n2mknqf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 12:52:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSmNI-0007qK-WC
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 12:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbaCZLvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 07:51:53 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:59767 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaCZLvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 07:51:52 -0400
Received: from localhost ([127.0.0.1]:58799 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WSmN4-0007PT-Lw; Wed, 26 Mar 2014 07:51:50 -0400
Received: by lola (Postfix, from userid 1000)
	id 64346DF3CE; Tue, 25 Mar 2014 22:06:36 +0100 (CET)
In-Reply-To: <xmqq4n2mknqf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Mar 2014 13:49:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245176>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> For the upcoming submodule test framework we often need to assert that an
>> empty directory exists in the work tree. Add the test_dir_is_empty()
>> function which asserts that the given argument is an empty directory.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>
>> I believe this one is pretty straightforward (unless I missed that this
>> functionality already exists someplace I forgot to look ;-).
>
> I am not very thrilled to see that it depends on "." and ".." to
> always exist, which may be true for all POSIX filesystems, but
> still...

Not even there, though few people will likely use / as their work
tree...

-- 
David Kastrup
