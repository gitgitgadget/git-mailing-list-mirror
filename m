From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a separate gitdirs.
Date: Fri, 07 Mar 2014 14:19:12 -0800
Message-ID: <xmqqzjl1slcv.fsf@gitster.dls.corp.google.com>
References: <1394178834.7891.38.camel@Naugrim>
	<BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Henri GEIST <geist.henri@laposte.net>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 23:19:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM370-0003lx-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 23:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbaCGWTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 17:19:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbaCGWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 17:19:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B5A1728C7;
	Fri,  7 Mar 2014 17:19:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0lirtggOrx22h4BcP+1KP2E7AeI=; b=ps5eMl
	B1YjWBTGXDvq/BnBDlZj5ST/czGfsDN8UQVNAypFdWmQiyb5BdnsY635hr+mBeND
	9VMCqBKBwjtIyYOm+MGqnoJp7dEwTutVgLHKbVQj2Np1evcu4zcxFv9ux8odrYgU
	l90OiwQZlEaYWZ35Havr5dzmCeEEeI3xFhrsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXy2yOf0//qYJFetbURtP/Ctic3fraco
	BWihp2Lpzr7iu6P4cdEBvArLdrsMeJ+RcRL54gQBqUlee1vqkrtS0qT2945vaVOY
	XHXvTru291lzRFNo9p/H2fSe9G1N9pa+ogAzUqtWjyebPQLQLxQXHjETrPLIHZKP
	2oFNPas/3PA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45123728C6;
	Fri,  7 Mar 2014 17:19:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AE48728C4;
	Fri,  7 Mar 2014 17:19:14 -0500 (EST)
In-Reply-To: <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com> (Andrew
	Keller's message of "Fri, 7 Mar 2014 16:42:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8414C8EA-A646-11E3-A87D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243634>

Andrew Keller <andrew@kellerfarm.com> writes:

>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 21cb59a..ea837fd 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
> ...
> Also, this file contains mostly high-level documentation, and this
> addition feels technical in nature.  Is there a location for more
> technical documentation?  Or, perhaps it can be reworded to sound
> less technical?

I tend to agree that the new paragraph looked somewhat out of place
and goes into a too low-level detail of the implementation.

The repository-layout documentation may be a better place for
readers to learn what lives where inside $GIT_DIR.
