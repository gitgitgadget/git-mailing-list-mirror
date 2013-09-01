From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Re* [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Sun, 01 Sep 2013 06:03:22 +0200
Message-ID: <5222BC8A.3020605@alum.mit.edu>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com> <1377717793-27170-2-git-send-email-felipe.contreras@gmail.com> <vpqhae97f8j.fsf@anie.imag.fr> <CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com> <vpqy57l4jcx.fsf@anie.imag.fr> <xmqq7gf58okw.fsf@gitster.dls.corp.google.com> <xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 06:10:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFyzg-00085p-Kf
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 06:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab3IAEK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 00:10:29 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43432 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753009Ab3IAEK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Sep 2013 00:10:28 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Sep 2013 00:10:28 EDT
X-AuditID: 1207440e-b7f0f6d0000043b7-40-5222bc8e2808
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AA.92.17335.E8CB2225; Sun,  1 Sep 2013 00:03:26 -0400 (EDT)
Received: from [192.168.69.9] (p57A24E87.dip0.t-ipconnect.de [87.162.78.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8143N23024963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Sep 2013 00:03:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqNu3RynIYPk7eYtfZ3exWBx8nGfR
	daWbyaKh9wqzxaXP61kdWD12zrrL7jHxy3FWj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M5Y
	/WI/Y8FRwYrvr2YwNTDe5e1i5OSQEDCR+HzoDSuELSZx4d56ti5GLg4hgcuMEpN+NrJCOGeY
	JB5veg5WxSugLXHrw38WEJtFQFXiz8MZTCA2m4CuxKKeZjBbVCBMYsf0iWwQ9YISJ2c+AasX
	EVCTmNh2iAVkKLPAakaJq3+PghUJC7hIbOtdwgix7S2TxJvLf9lBEpwCdhLHX/YCdXAAdahL
	rJ8nBBJmFpCX2P52DvMERoFZSHbMQqiahaRqASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJd
	Y73czBK91JTSTYyQwObbwdi+XuYQowAHoxIP74popSAh1sSy4srcQ4ySHExKorwpO4FCfEn5
	KZUZicUZ8UWlOanFhxglOJiVRHgZmoByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakF
	qUUwWRkODiUJ3tzdQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoFiNLwZGK0iK
	B2hvBUg7b3FBYi5QFKL1FKMxx5+Vcz8xcrxrmveJUYglLz8vVUqc1x+kVACkNKM0D24RLKW9
	YhQH+luY98MuoCoeYDqEm/cKaBUT0KprExVBVpUkIqSkGhgNI8OzupI338vxj63lEmwLTMgV
	vlP/uyvszK6oT0v65gqczJh2zuqp7BnXU0cOGV6YHCHPzqwqnxDQm5jx9vXymWHL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233563>

On 08/29/2013 11:24 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Do I really need to quote the paragraph in CodingGuidelines?
>>
>> Existing violations are not an excuse to make things worse by adding
>> more.  I think with these comments we can expect a reroll coming,
>> and it should be trivial for any contributor to fix it while at it.
> 
> Actually, I think not fixing it inside that 1/8 is good, as there
> are many existing "cmd > file" (and worse, "cmd > file-$x") in these
> test-*.sh scripts.  Clean-up is better done as a follow-up patch.
> 
> Here are two that I noticed.
> 
> -- >8 --
> Subject: [PATCH 9/8] contrib/remote-helpers: style updates for test scripts
> 
> During the review of the main series it was noticed that these test
> scripts can use updates to conform to our coding style better, but
> fixing the style should be done in a patch separate from the main
> series.
> 
> This updates the test-*.sh scripts only for styles:

s/styles/style/

> 
>  * We do not leave SP between a redirection operator and the
>    filename;
> 
>  * We change line before "then", "do", etc. rather than terminating
>    the condition for "if"/"while" and list for "for" with a
>    semicolon;
> 
>  * When HERE document does not use any expansion, we quote the end
>    marker (e.g. "cat <<\EOF" not "cat <<EOF") to signal the readers
>    that there is no funny substitution to worry about when reading
>    the code.
> 

Please add

    * We use "test" rather than "[".

, as you made a few such changes as well.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/remote-helpers/test-bzr.sh       | 112 +++++++++++-----------
>  contrib/remote-helpers/test-hg-bidi.sh   |  52 ++++++-----
>  contrib/remote-helpers/test-hg-hg-git.sh | 156 +++++++++++++++++--------------
>  contrib/remote-helpers/test-hg.sh        | 154 +++++++++++++++---------------
>  4 files changed, 248 insertions(+), 226 deletions(-)
> 
> [...]

All of the changes in the patch look good to me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
