From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: add configurable tab size to the diff view git-gui - why not added to git-gui ?
Date: Fri, 19 Sep 2014 11:05:25 -0700
Message-ID: <xmqqsijnmqoq.fsf@gitster.dls.corp.google.com>
References: <lvhesi$qqs$1@ger.gmane.org>
	<xmqqd2aro8fx.fsf@gitster.dls.corp.google.com>
	<xmqq8ulfo868.fsf@gitster.dls.corp.google.com>
	<lvhq23$fq6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: pb158 <pb158@tlen.pl>
X-From: git-owner@vger.kernel.org Fri Sep 19 20:05:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV2Yw-0004vx-7k
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 20:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbaISSFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 14:05:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59824 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757713AbaISSF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 14:05:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A4D63AE01;
	Fri, 19 Sep 2014 14:05:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BSaqZWN3E1qdNc//3/jQYWsYLXk=; b=G/fp6q
	Kcx8z70kXI4Fjc0JNSL440CwtVt2ZXbyppXg4m8aBNyep7iE6lzDcFgCoIaIItoa
	MvXWR4+veLlswyqU0eOGa4M+673FPr66MoucCbS3Ky3FbOGPmg+TSiR+a40OcSph
	ZLdmQT9+1W1ePJid3FJpjZp0kEBytIb15y4lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OTQa2NVaPGSeExyaP6gS9zmliUpiJqXy
	4jWYzlOgxihktD5oGFvItA+GAtmAu1N7qt2G8IJG/MtKGqLnQFqUjuY/yhIJYxds
	fpGoyVa9CDFuxiHrK3cPkF6CrlYaNY7bgH8QWNorLoc1WNn5ESHHJn1TZXgKAvfT
	BiYh7GUxOK8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22D6C3AE00;
	Fri, 19 Sep 2014 14:05:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2FB7C3ADFF;
	Fri, 19 Sep 2014 14:05:27 -0400 (EDT)
In-Reply-To: <lvhq23$fq6$1@ger.gmane.org> (pb's message of "Fri, 19 Sep 2014
	19:44:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88DD6230-4027-11E4-BCE5-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257302>

pb158 <pb158@tlen.pl> writes:

> On 19.09.2014 19:02, Junio C Hamano wrote:
>> [References]
>>
>> *1* http://article.gmane.org/gmane.comp.version-control.git/190576/raw
>>
>
> This solves the problem, I hope ...

Not so fast.  It could be that people were not interested in the
change for a reason when it was posted.  We'll see ;-)
