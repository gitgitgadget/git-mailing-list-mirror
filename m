From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] Doc clean: add See Also links
Date: Sun, 16 Sep 2012 22:00:48 -0700
Message-ID: <7vboh5xmyn.fsf@alter.siamese.dyndns.org>
References: <1347793083-4136-8-git-send-email-philipoakley@iee.org>
 <vpqsjaiyxth.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, gitList <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTS8-0001l8-6O
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab2IQFAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:00:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab2IQFAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:00:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5160B9A8D;
	Mon, 17 Sep 2012 01:00:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tf30LmdZNjiQKou0qIN2gk6THP4=; b=XsD0gx
	OoFoxUPbnDQ1BWayHq3AWAtsHvfmlFHDNSvOI2WKVVECGJT6myBK+NvDZbkm6OxN
	fFxkJ5h5238aGF3iu/2ZLtsMUl0MadBKjdc3cXeBsiAPhwkJJf+6z4DcRNSoILnp
	zcWRlRp6HlgWhTaaCMrYLUW8uL1oPA/mq9dx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQV27kx+8LQbtIFKFOHeIxTI4gZsEwqz
	eWxfk645/gmSVpjAhT/Gl/wS6crBJ+LyXHRLWo5336Nr1k3+piVRGltZE0eFcWRm
	rCVAbG2fXSiRCQ5RTQCymj/AePLUkYD9iCOnrLWGa6OhEV5ijsrr/P+2rdizQd/x
	2N/1kbqwYbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FCFC9A8C;
	Mon, 17 Sep 2012 01:00:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 970CA9A8B; Mon, 17 Sep 2012
 01:00:49 -0400 (EDT)
In-Reply-To: <vpqsjaiyxth.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Sun, 16 Sep 2012 14:08:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A60F95F6-0084-11E2-BE97-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205643>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Philip Oakley <philipoakley@iee.org> writes:
>
>> --- a/Documentation/git-clean.txt
>> +++ b/Documentation/git-clean.txt
>> @@ -63,6 +63,12 @@ OPTIONS
>>  	Remove only files ignored by git.  This may be useful to rebuild
>>  	everything from scratch, but keep manually created files.
>>  
>> +SEE ALSO
>> +--------
>> +linkgit:gitignore[5]
>> +linkgit:gitrepository-layout[5]
>> +The optional configuration variable `core.excludesfile` linkgit:git-config[1]
>
> I think linkgit:gitignore[5] is enough. linkgit:gitrepository-layout[5]
> is a very general documentation, it's not clear to the reader which part
> is intended to be read in complement to git-clean, and indeed, the
> relevant information is already in linkgit:gitignore[5]. Same for
> core.excludesfile which is already documented in linkgit:gitignore[5].
>
> Otherwise, I suspect we'll end-up having the transitive closure of SEE
> ALSO in each manpage ...

Concurred.  Thanks.
