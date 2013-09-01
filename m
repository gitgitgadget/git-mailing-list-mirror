From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Re* [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Sun, 01 Sep 2013 06:09:26 +0200
Message-ID: <5222BDF6.3080009@alum.mit.edu>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com> <1377717793-27170-2-git-send-email-felipe.contreras@gmail.com> <vpqhae97f8j.fsf@anie.imag.fr> <CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com> <vpqy57l4jcx.fsf@anie.imag.fr> <xmqq7gf58okw.fsf@gitster.dls.corp.google.com> <xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com> <xmqqd2ow2nqi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 06:09:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFyyw-0007pr-4m
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 06:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab3IAEJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 00:09:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46917 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751857Ab3IAEJa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Sep 2013 00:09:30 -0400
X-AuditID: 12074414-b7f626d0000001f1-78-5222bdf98cf3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id FF.91.00497.9FDB2225; Sun,  1 Sep 2013 00:09:29 -0400 (EDT)
Received: from [192.168.69.9] (p57A24E87.dip0.t-ipconnect.de [87.162.78.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8149RZp025175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Sep 2013 00:09:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <xmqqd2ow2nqi.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqPtzr1KQwaw55ha/zu5isTj4OM+i
	60o3k0VD7xVmi0uf17M6sHrsnHWX3WPil+OsHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ1x
	c+pM1oJ/HBXn91xlb2BcwN7FyMkhIWAi0fPhIiOELSZx4d56ti5GLg4hgcuMEsf3foByzjBJ
	/N+xH6yDV0Bb4uary8wgNouAqsSEVfvAbDYBXYlFPc1MILaoQJjEjukT2SDqBSVOznzCAmKL
	CKhJTGw7xAIylFlgNaPE1b9HwYqEBVwktvUuYYTYNodZYt3D12AdnALWEueW3AfbwCygI/Gu
	7wGULS+x/e0c5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIz
	S/RSU0o3MUKCW2QH45GTcocYBTgYlXh4V0QrBQmxJpYVV+YeYpTkYFIS5U3ZCRTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwsvQBJTjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgST
	leHgUJLgFQBGsZBgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KF7ji4ERC5LiAdor
	B9LOW1yQmAsUhWg9xajL8a5p3idGIZa8/LxUKXFePZAiAZCijNI8uBWwVPaKURzoY2FeHpAq
	HmAahJv0CmgJE9CSaxMVQZaUJCKkpBoYi77a7/5icnbVurPydxxi+RlMXiX9u6DPo/Hnz5vH
	NrHtT4IaWIP5uldntXpHlSbcPuHJnaO06Ff49uNXLv+5Pztgut6lqy8qvd7WnBK2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233562>

On 08/29/2013 11:25 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Actually, I think not fixing it inside that 1/8 is good, as there
>> are many existing "cmd > file" (and worse, "cmd > file-$x") in these
>> test-*.sh scripts.  Clean-up is better done as a follow-up patch.
>>
>> Here are two that I noticed.
>>
>> -- >8 --
>> Subject: [PATCH 9/8] contrib/remote-helpers: style updates for test scripts
> 
> And here is the second one.
> 
> -- >8 --
> Subject: [PATCH 10/8] remote-helpers: quote variable references in redirection targets
> 
> Even though it is not required by POSIX to double-quote the
> redirection target in a variable, our code does so because some
> versions of bash issue a warning without the quotes.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/remote-helpers/test-hg-hg-git.sh | 40 ++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> [...]

Looks good.

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
