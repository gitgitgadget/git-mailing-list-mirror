From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] improve-wincred-compatibility
Date: Sun, 24 Feb 2013 22:43:49 -0800
Message-ID: <7vsj4k3nbu.fsf@alter.siamese.dyndns.org>
References: <50E73B80.4070105@gmail.com>
 <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
 <50EC473A.6060203@gmail.com>
 <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
 <50EEAF9A.6020302@gmail.com>
 <CABPQNSaUizZPVOeeuEyb=o-Qmm4mYCRxV27qkmp62cSpFkinqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: blees@dcon.de, git@vger.kernel.org, msysgit@googlegroups.com,
	Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 25 07:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9rnN-000416-2C
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab3BYGnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:43:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab3BYGnv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:43:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 464E3A570;
	Mon, 25 Feb 2013 01:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5OkCWIgzFzPCylTg1lcwBnj4nP8=; b=CBgm3z/b1rxRJo/OcloY
	fRWo52pWPxTb4sJqYzivkkS0O4z5UpT7zH38uObe8pe3fBn0tQ306uhsTJNjfOeg
	WmfYjI7v2VK+MDuppO3sn9HmvDGv03OKBMA9GVbqkoWVrjPHImhCIsY26GWU6vNd
	JqeDnLbT0kU1/WGk4Nn0n0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dweQPceu7hcpdaLk+O4eRRuERAMX4qsNlDLqCc09emT0jb
	fdwBPpxnVB62kUf7nj7qroeP+OaTx8b4dtb1KxgEUux+xmyTCudnn3yIf+J8eJ8s
	mfmkn8eVBsOWnZv5x0eouWwUDsb3lyuSSv8rclVWvPB3kYhI1Vgo9w1W1mnYM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A20CA56F;
	Mon, 25 Feb 2013 01:43:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AADBFA560; Mon, 25 Feb 2013
 01:43:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6CB46F4-7F16-11E2-A4F7-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217035>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Jan 10, 2013 at 1:10 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Changes since initial version (see attached diff for details):
>> - split in two patches
>> - removed unused variables
>> - improved the dll error message
>> - changed ?: to if else
>> - added comments
>>
>> Also available here:
>> https://github.com/kblees/git/tree/kb/improve-wincred-compatibility-v2
>> git pull git://github.com/kblees/git.git kb/improve-wincred-compatibility-v2
>>
>> Karsten Blees (2):
>>   wincred: accept CRLF on stdin to simplify console usage
>>   wincred: improve compatibility with windows versions
>>
>>  .../credential/wincred/git-credential-wincred.c    | 206 ++++++++-------------
>>  1 file changed, 75 insertions(+), 131 deletions(-)
>>
>
> Wonderful!
>
> Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

I'm in the "marking leftover bits" mode today, and noticed that
nothing happened for this topic in my tree. Did msysgit folks expect
me to pick this up directly, or did you guys want to feed this series
to me (with possibly other changes you worked on outside this list)?
