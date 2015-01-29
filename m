From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Score in diff-format
Date: Wed, 28 Jan 2015 22:20:51 -0800
Message-ID: <xmqq386uf6po.fsf@gitster.dls.corp.google.com>
References: <20150128062309.GA29506@glandium.org>
	<54C8F306.1000001@drmicha.warpmail.net>
	<xmqqk306fvvk.fsf@gitster.dls.corp.google.com>
	<20150129012211.GA11678@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 07:21:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGiTK-0007BT-D1
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 07:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbbA2GUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 01:20:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752200AbbA2GUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 01:20:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EA672935C;
	Thu, 29 Jan 2015 01:20:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CHoZk/duJuGHnR2Dbbwos/fXeNg=; b=Zw0VTp
	4CSMkM39H4ohf7dX4yYz+rAFGLhR0NFk32JAAOeUuTLdKEUhVFQRgIaj/X45L3fU
	5mxm+LYxujWhB7oQoojvRsRIL9Xigi6upYTlRIklwzWYbkaoYalBM1g/cHFDZrTP
	4sDIRbqo3iJYE2Dlv2M4PhDcoly0qY2h4rEOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=weRB6r0v1EXkugDqxLElYFbrK51m/IiY
	Hu2IL36sJLN7UFiMBYpA8ixwZ+xaRiUsEalKsdQhU98taUfSqOuC9zMc+3y/7EFY
	Vb7tneWAAv/96pBZWx0T6701c861+/mzDoXIY1/78uG2ZkGyEfZ+AgvnAsmf4rKb
	z/Vshy5w+9w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45B1F2935B;
	Thu, 29 Jan 2015 01:20:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0A1D2935A;
	Thu, 29 Jan 2015 01:20:52 -0500 (EST)
In-Reply-To: <20150129012211.GA11678@glandium.org> (Mike Hommey's message of
	"Thu, 29 Jan 2015 10:22:11 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9E1C214-A77E-11E4-8C25-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263141>

Mike Hommey <mh@glandium.org> writes:

> On Wed, Jan 28, 2015 at 01:17:19PM -0800, Junio C Hamano wrote:
>> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
>> index 15c7e79..e6cfc9b 100644
>> --- a/Documentation/diff-format.txt
>> +++ b/Documentation/diff-format.txt
>> @@ -66,7 +66,8 @@ be committed)
>>  
>>  Status letters C and R are always followed by a score (denoting the
>>  percentage of similarity between the source and target of the move or
>> -copy), and are the only ones to be so.
>> +copy).  M may show how completely the modification rewrites the file
>> +with a score (denoting the percentage of dissimilarity).
>
> How about something like:
>
>   Status letter M may be followed by a score (denoting the percentage of
>   dissimilarity) for file rewrites.

OK.  That seems to make the end result sound more consistent by
repeated use of "status letter X".  Let's use that.

Thanks.
