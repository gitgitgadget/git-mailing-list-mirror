From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add feature release instructions to gitworkflows man
 page
Date: Sun, 29 Mar 2009 23:57:16 -0700
Message-ID: <7vk567ijlf.fsf@gitster.siamese.dyndns.org>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm>
 <1238391319-4953-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rocketraman@fastmail.fm
X-From: git-owner@vger.kernel.org Mon Mar 30 08:59:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBSX-0000pJ-64
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbZC3G5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbZC3G53
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:57:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbZC3G52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:57:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E910CA6A5A;
	Mon, 30 Mar 2009 02:57:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7997CA6A59; Mon,
 30 Mar 2009 02:57:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 046A45AC-1CF8-11DE-A044-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115093>

rocketraman@fastmail.fm writes:

> From: Raman Gupta <raman@rocketraman.com>
>
> Based on a mailing list discussion, add a description of the workflow,
> and associated commands, for creating a feature release.

The same comment applies to the other one, but this commit log message is
really lacking.  If you do not bother to summarize the discussion, place a
pointer to the list archive, and more importantly, please describe *why*
this change is desiable.

I am not sure rewinding and rebuilding of 'next', or even having 'next',
is applicable for other projects as a BCP.  Other parts (except for the
"branch -f" bit I've already told you about in the other message) looked
good.

Thanks.
