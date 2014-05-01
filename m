From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] CodingGuidelines: call the conditional statement "if ()", not "if()"
Date: Thu, 01 May 2014 11:11:26 -0700
Message-ID: <xmqqfvktcqsx.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-7-git-send-email-gitster@pobox.com>
	<87lhulziv6.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 01 20:11:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfvSK-0000Vz-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbaEASLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 14:11:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52326 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaEASLb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:11:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B806911534;
	Thu,  1 May 2014 14:11:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BWq6n8sFICNG9evbelGZ1+R8ASE=; b=U+HZ6M
	oL/XQ1RNRYj3WLD8i8Y/CFGALok+QkyBWQKG9RyrLBnkF5P8NkOXE5sfSxfBx5Zf
	aoxuOvH1N86fZNQz+Y1k2cjVCcuM4Q/0hcXi5+OQHMJPCDjLn/HZP2/bvS3S2L/n
	9B1gSiqP/dyEj7+b8/mkO4x+H+GJ8UmYFogng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0C3xLRyNkgAVe2neQ4H81S7Mw/5f0Hq
	sDxST44ISDsJAGD9dX7nSl3CFKiaVXxh5rIE63lo55jvJsOC5e3i+rJ3wvfED7W3
	hkvjAaH1l+ZuTGCyNik8dAT25eePS6dZkNcsUXn9dlv1XtnxJqKkfqi62TolUxXM
	TZaXaw6cNEQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6FD611533;
	Thu,  1 May 2014 14:11:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3EC7011531;
	Thu,  1 May 2014 14:11:28 -0400 (EDT)
In-Reply-To: <87lhulziv6.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 01 May 2014 16:14:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 03D3FF34-D15C-11E3-9169-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247822>

David Kastrup <dak@gnu.org> writes:

>> - - We try to avoid assignments inside if().
>> + - We try to avoid assignments inside "if ()" condition.
>
> That's not grammatical.

OK,

	... inside the condition part of an "if ()" statement.

then?
