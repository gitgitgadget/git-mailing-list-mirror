From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 11:10:03 +0200
Message-ID: <5195F3EB.8000308@alum.mit.edu>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com> <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com> <7vfvxpfbli.fsf@alter.siamese.dyndns.org> <51932A1A.4050606@alum.mit.edu> <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 11:10:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGg5-0005dr-NS
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab3EQJKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:10:10 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:53020 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752062Ab3EQJKG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 05:10:06 -0400
X-AuditID: 12074412-b7f216d0000008d4-f5-5195f3ed5c56
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FE.AC.02260.DE3F5915; Fri, 17 May 2013 05:10:06 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4H9A3m0018720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 May 2013 05:10:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqPvu89RAg50XmSw2zL3LYtF1pZvJ
	oqH3CrMDs8fOWXfZPS5eUvb4vEkugDmK2yYpsaQsODM9T98ugTtj7f91zAVfOSq2NdxkamDs
	Zu9i5OCQEDCRaG9j6mLkBDLFJC7cW8/WxcjFISRwmVFi5bpFLBDOdSaJb//3sYNU8QpoS7Rc
	bGEBsVkEVCUm7j/IDGKzCehKLOppBpskKhAmsWr9MmaIekGJkzOfgNWLANUvP3oBbA6zgLXE
	iteHmUCOEBbQkZg3MxRi1xImiXO7l4P1cgoESjQ+aWUBqWEWUJdYP08IolVeYvvbOcwTGAVm
	IdkwC6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCwlZoB+P6
	k3KHGAU4GJV4eBV+TgkUYk0sK67MPcQoycGkJMq79+PUQCG+pPyUyozE4oz4otKc1OJDjBIc
	zEoivMdBcrwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErwvPwE1Chal
	pqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiNL4YGKcgKR6gvRdB2nmLCxJzgaIQracY
	dTlm/Jj8jlGIJS8/L1VKnPc4SJEASFFGaR7cCliSesUoDvSxMO8dkCoeYIKDm/QKaAkT0BLW
	a2BLShIRUlINjAvCefprZwiHPlWbInBlcZzPo0kpp0u95NWNFkTFn1Bbzj5ZeuHH8+FLhN6q
	8UxLrT2Rsmje4gf5hctPzTlZ+Zm1SJM7nTn+v1rbjWnJQfFqUTa79x/9++B2r/T9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224663>

On 05/15/2013 08:03 PM, Eugene Sajine wrote:
> My primary goal was to understand better what are the real problems
> that we might have with the way we use git cvsimport, so I was not
> asking about the guarantee of the cvsimport to import things
> correctly, but if there is a guarantee the import will result in
> completely broken history.

So what are you going to do, use cvsimport whenever you cannot *prove*
that it is wrong?  You sure have low standards for your software.

The only *useful* guarantee is that software is *correct* under defined
circumstances.  I don't think anybody has gone to the trouble to figure
out when that claim can be made for cvsimport.

> If the cvsimport is that broken - is there any plan to fix it?

For one-time imports, the fix is to use a tool that is not broken, like
cvs2git.

Alternatively, Eric Raymond claims to have developed a new version of
cvsps that is not quite as broken as the old version.  Presumably
cvsimport would be not quite as broken if used with the new cvsps.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
