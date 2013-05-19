From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Sat, 18 May 2013 23:26:36 -0700
Message-ID: <7vzjvrzdr7.fsf@alter.siamese.dyndns.org>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
	<7vbo891ra8.fsf@alter.siamese.dyndns.org>
	<CAPig+cSYKM3XUm4m=ip_=p0mQz=gz0VKx7bfS=UdUsFMECWEQw@mail.gmail.com>
	<7vfvxlzdyu.fsf@alter.siamese.dyndns.org>
	<CAJDDKr58oM6Dm7sb-sUu2tTt210Su_q+ixc+HA0DHbc0Kmrv9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6ger?= =?utf-8?Q?shausen?= 
	<tboegi@web.de>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 08:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udx4u-00028W-9m
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 08:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab3ESG0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 02:26:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab3ESG0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 02:26:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5779A1C953;
	Sun, 19 May 2013 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=klmIJRknxdJFzKY5gVk+z2Plgc4=; b=E6Vggm
	jf5+DM0xJPYaqjRpEvjnTXxvQPlCqvlzJf8Oe95MXlyx4dAaLjPP6WNFCDlMmjjl
	/+USUP5ihBJqnQMFfS0tbnOKwEtWQc3zfT11dKhhMv9rJBQEChMX/lL+yfb4mCPO
	8Sp8JER6Ilbd+kAgmR5nr9P+Tj4A/tFQ6ThD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jLNQ+NNI3I35osyJ2xh0wk/3HUshLzq5
	unTS9P7fzsPs+fUavvnVubEIVyl7uc4NU3qsSk2Tq6/W/Muhoh9uqFCdl2k+kYGZ
	U+POvHXVDsXpZXf8nGstCbTE1JI38CmVMDwRQegQCt+Y4TZAPuA5ekEoGrMnMSNn
	n51N/cvV9AE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43B891C950;
	Sun, 19 May 2013 06:26:39 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B09211C94C;
	Sun, 19 May 2013 06:26:37 +0000 (UTC)
In-Reply-To: <CAJDDKr58oM6Dm7sb-sUu2tTt210Su_q+ixc+HA0DHbc0Kmrv9w@mail.gmail.com>
	(David Aguilar's message of "Fri, 17 May 2013 17:38:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FF66BF6-C04D-11E2-B094-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224822>

David Aguilar <davvid@gmail.com> writes:

> Thanks Eric and Junio.  I looked over the patches and they look good.

Are you sure about that?  It seemed to me that it was breaking
everybody that is not on MacOS X --- did I misread the patch?
