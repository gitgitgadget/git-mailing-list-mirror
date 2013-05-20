From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: set stdout to binary mode on win32
Date: Mon, 20 May 2013 11:18:32 -0700
Message-ID: <7vehd1v7k7.fsf@alter.siamese.dyndns.org>
References: <1368964428-1059-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s32tF01P5=Go+cdh8x8m9c0c5e=SR4jpx_Zi38yQrGk7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Amit Bakshi <ambakshi@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 20:18:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeUfP-0005If-Ox
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 20:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757786Ab3ETSSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 14:18:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757666Ab3ETSSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 14:18:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D760204AC;
	Mon, 20 May 2013 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2kCzrg2ro2T8HN6h5lPLU6F1MnM=; b=DSEWVm
	vtuXe2B4PmFYl7OC5W+a3PQHcumOjWEHqaDTACH43TqslHdYqcMi6OH8lPr9KqQ3
	1I3kTqlwhiIy7MCj3Ny5KvGXlBo7t3+qUtpJd3MIDPOuqbmRpcX2iTQNvWlGWNF4
	9xdm9IZ1rR8qMp2cPbGwDiwZMwrYXv7p9LFDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AkWMuUMPUZNm7hDqUtjVDRe6UCTjsMSY
	TgbiSYwNOgm90oiWRU03oCFD6lnTyYo8ukH7PAvTvu5UySFVnG4dDyaC1/L1qzBQ
	I0K80AP0cC2zl2oSdN0Rdq7oM+/25beCcRnC73lhnaXyc45khTtq113JCGX0X6dM
	dlwPdo30Ygw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23D5F204AB;
	Mon, 20 May 2013 18:18:34 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FA79204A7;
	Mon, 20 May 2013 18:18:33 +0000 (UTC)
In-Reply-To: <CAMP44s32tF01P5=Go+cdh8x8m9c0c5e=SR4jpx_Zi38yQrGk7w@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 19 May 2013 07:00:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE6A8592-C179-11E2-BCF6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224971>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, May 19, 2013 at 6:53 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> From: Amit Bakshi <ambakshi@gmail.com>
>>
>> git clone hangs on windows, and file.write would return errno 22 inside
>> of mercurial's windows.winstdout wrapper class. This patch sets stdout's
>> mode to binary, fixing both issues.
>
> Forgot:
> [fc: cleaned up]
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Thanks, sounds like this is meant for 'master'?
