From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 13:23:58 -0700
Message-ID: <7vk3wy1t7l.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
 <2BB1E674DD214C66B06660612F34109D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@suse.cz>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 22:24:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T26bw-0006WI-ND
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 22:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537Ab2HPUYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 16:24:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057Ab2HPUYA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 16:24:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6562B80F7;
	Thu, 16 Aug 2012 16:24:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vlgz+GGxn2Ep/cOmQ6zn7iUInM4=; b=bgHJOv
	VdfPcJ2nbfy7m8eyssGwxIcY2WNbgnz9nsnMLgjkqAH3UiEzqNGF7wogzeODZ0TZ
	bGenbeh+GCMBA2mJS+4uhR/Zr58kGdiL+oIzDSc2qWhSafUzTK4zQceoD1PpqtgZ
	Ck8RPIIpLN0mngJQaEl4H95CNTrKXR5MF84dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uPTHJnNHSM+fBhSfmh8hX8hUi2urGzdP
	E2H+t5GZjUp9sR5IIuCAam0G2GQggHtNpZZKoDlh9rn6rWUsv5HnYO73piRR0bX3
	eQU7Y+GCrbJRmF0ouNsmFK1Jv8PfdzBCwuot/dbi5apbuzjjTa43g2paeY2eisjj
	2n4HpTEKsDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5196B80F6;
	Thu, 16 Aug 2012 16:24:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEC6680F5; Thu, 16 Aug 2012
 16:23:59 -0400 (EDT)
In-Reply-To: <2BB1E674DD214C66B06660612F34109D@PhilipOakley> (Philip Oakley's
 message of "Thu, 16 Aug 2012 20:59:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FF3CC76-E7E0-11E1-9F6D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> I wasn't aware of the  "abbreviated options" capability. Is meant to
> be in the man pages as I couldn't find it, or is it described
> differently?

$ git help gitcli

is the closest that comes to mind.

If it is not reachable from "git help git", we may want to sprinkle
some more linkgit:gitfoo[$n] around the documentation sources.  I
didn't check.
