From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] README: Git is released under the GPLv2, not just "the
 GPL"
Date: Sat, 15 Dec 2012 11:39:30 -0800
Message-ID: <7vhannrtot.fsf@alter.siamese.dyndns.org>
References: <966a27bab02e7deb41ad2268800bfd4a53279a8f.1355499408.git.stefano.lattarini@gmail.com> <7vhanntchw.fsf@alter.siamese.dyndns.org> <7v38z7tb7q.fsf@alter.siamese.dyndns.org> <50CCCE0A.40305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:39:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxaQ-00044M-Og
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab2LOTje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:39:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab2LOTjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:39:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EECD68D1E;
	Sat, 15 Dec 2012 14:39:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0VZRQiJ3EnZEksnO+8EZLil0QAk=; b=ZY9pCM
	YQjE/42k7Ze+nUS2li7olZQ3HriEFFdY9Ol9y5uDZis+2rkhlVhvFtV69Q/21L/6
	uPIjXpUBQp5oADkGf/LeDI8OxOzOS9gUzgeWupSqICsFmUl5At5UykeNyfbgUMva
	+O4OT6ZH7CusNiNSJn96RDEihyb592/EXLt3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T004fMlYRVWK8XLyQO2YwK4bcGVKWIo/
	GeFJJtkVIGjV73gOQYGxlrhykO22ZLs2ambrjjUAYwN7pL4MCXB2nhysUuflUMhO
	RP6QhsZuz9VKomvKNRPIK9CokwbbOS8udVPEHCD1agvMIwnhuyfLJhBMbaTmvr/M
	12cYIKBhdCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC5B98D1C;
	Sat, 15 Dec 2012 14:39:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55BE58D1B; Sat, 15 Dec 2012
 14:39:32 -0500 (EST)
In-Reply-To: <50CCCE0A.40305@gmail.com> (Stefano Lattarini's message of "Sat,
 15 Dec 2012 20:22:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2605F22C-46EF-11E2-B973-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211567>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 12/15/2012 07:35 PM, Junio C Hamano wrote:
>> ...
>> -Git is an Open Source project covered by the GNU General Public License.
>> +Git is an Open Source project covered by the GNU General Public
>> +License version 2 (some parts of it are under different licenses).
>>
> Maybe you could be even more explicit ans state "some parts of it are
> under different licenses, compatible with the GPLv2".  But maybe this
> is just overkill?

I personally do not think it is an overkill; because this "clarify
that we are version 2", followed by "not everything is, but as a
whole it is still GPLv2" is in the end about covering our ass, it is
better to be as clear as possible without making it into a novel.
