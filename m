From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] blob.c: remove unused function
Date: Tue, 12 Jan 2010 22:56:24 -0800
Message-ID: <7veilusdbb.fsf@alter.siamese.dyndns.org>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
 <1263282781-25596-17-git-send-email-gitster@pobox.com>
 <alpine.LNX.2.00.1001121128410.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx9k-00013b-1r
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab0AMG4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965Ab0AMG4c
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:56:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab0AMG4b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:56:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C2A490031;
	Wed, 13 Jan 2010 01:56:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NqCWZ46eIB4vS7dTUUAthFc7ZAc=; b=YQ3iRCDKVhJLWR66vN/HwR6
	pgwtmXg6oWaPHHlcRbZran9l93ZfQaaRBD3fO0EE+wOSX1d1i5jG97wu6upJ5gXS
	9vAIb06KC1QNWxy2i43fyv04HRDGldB3+2J528Y8CgRlx95mztQuesy8io7jb6u4
	iW5O/D1xuHh31jd0+N7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XAaJzOzU8VHjJHEXRKlsFooEqvHcaSKSPuuuqr/bhheM+cQW/
	QELQ/lKmUiCeQARXsimPRlAQ7nxEyCV+WbXczYxEiYDP2YZzsmEN9Bc3H4n5B2GC
	dwrbD/P8BlncqM//Sr4yH0s2ox921qE2gCpcF8S2eq31F3TLiYbpfcWXPI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7950290030;
	Wed, 13 Jan 2010 01:56:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D68B09002D; Wed, 13 Jan
 2010 01:56:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5EF7BB0-0010-11DF-B6C0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136782>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 11 Jan 2010, Junio C Hamano wrote:
>
>> parse_blob() is not used anywhere since a510bfa (Mark blobs as parsed when
>> they're actually parsed, 2005-04-28).
>
> Perhaps it should be replaced with a comment that blobs are never parsed, 
> because they don't need to be? We don't need the actual function, but I 
> think it's worth having a note where the function would be.

I tend to agree.

Care to come up with a patch, with a real description of the reason _why_
they don't need to be parsed, please?
