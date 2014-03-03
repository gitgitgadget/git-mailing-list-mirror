From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Mon, 03 Mar 2014 11:10:43 +0100
Message-ID: <53145523.7020900@alum.mit.edu>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com> <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-4-git-send-email-pclouds@gmail.com> <CAPig+cQ7pd4mQTTsT2Kq3KL-erUdncBsYmFjt8aFWB5THE6Srw@mail.gmail.com> <CAPig+cS8XRf8LzajSJL7LVxVKb_cqLviwSimYyYXRWL46dh9QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:10:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKPpp-0002PX-5C
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbaCCKKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 05:10:50 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51669 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754581AbaCCKKs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 05:10:48 -0500
X-AuditID: 1207440e-f79c76d000003e2c-e0-531455271b87
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 02.79.15916.72554135; Mon,  3 Mar 2014 05:10:47 -0500 (EST)
Received: from [192.168.69.148] (p57A2466F.dip0.t-ipconnect.de [87.162.70.111])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s23AAh3T003582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 3 Mar 2014 05:10:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAPig+cS8XRf8LzajSJL7LVxVKb_cqLviwSimYyYXRWL46dh9QA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqKseKhJssH8yv0XXlW4mi0uf17Na
	dE95y2jxo6WH2aJzqqzFmTeNjA5sHjtn3WX3mPjlOKvH8qXrGD2e9e5h9Fj8wMvj8ya5ALYo
	bpukxJKy4Mz0PH27BO6M6R9aGQsmClZcvNbC3sB4iLeLkZNDQsBE4v7pvywQtpjEhXvr2boY
	uTiEBC4zSsyasZ0ZwjnHJHH74i9GkCpeAW2JeRdWs4PYLAKqEpcuv2MGsdkEdCUW9TQzgdii
	AsESqy8/YIGoF5Q4OfMJmC0C1PthwyZGkKHMAh8ZJa6vamHtYuTgEBbwk1jbpAexbBuTRM+b
	ZlaQBk6BQImbh46A1UgIiEv0NAaBmMwC6hLr5wmBVDALyEs0b53NPIFRcBaSbbMQqmYhqVrA
	yLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyQW+HYwtq+XOcQowMGoxMNr
	uFQ4WIg1say4MvcQoyQHk5Ior4WfSLAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd78ZUDlvCmJ
	lVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3rkhQEMFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQfEbXwyMYJAUD9DeHJB23uKCxFygKETrKUZdjtttvz4xCrHk
	5eelSonzTgApEgApyijNg1sBS3yvGMWBPhbmrQGp4gEmTbhJr4CWMAEtMfMDW1KSiJCSamCc
	sum21+Hul9smXr28YdKFR17B2f9XF0+/ZNL/dermy12GHjMFbpd9UmtZde7a1di9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243210>

On 03/02/2014 10:09 AM, Eric Sunshine wrote:
> On Sun, Mar 2, 2014 at 4:04 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
>> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> "git rebase -e XYZ" is basically the same as
>>>
>>> EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
>>> git rebase -i XYZ^
>>>
>>> In English, it prepares the todo list for you to edit only commit X=
YZ
>>> to save your time. The time saving is only significant when you edi=
t a
>>> lot of commits separately.
>>
>> Should this accept multiple -e arguments? Based upon the above
>> justification, it sounds like it should, and I think that would be t=
he
>> intuitive expectation (at least for me).
>>
>> The current implementation, however, is broken with multiple -e argu=
ments. With:
>>
>>     git rebase -i -e older -e newer
>>
>> 'newer' is ignored entirely. However, with:
>>
>>     git rebase -i -e newer -e older
>>
>> it errors out when rewriting the todo list:
>>
>>     "expected to find 'edit older' line but did not"
>>
>> An implementation supporting multiple -e arguments would need to
>> ensure that the todo list extends to the "oldest" rev specified by a=
ny
>> -e argument.
>=20
> Of course, I'm misreading and abusing the intention of -e as if it is
> "-e <arg>".

I think that your misreading is more consistent than the feature as
implemented.

    git rebase -e OLDER

does not mean "do 'git rebase -i OLDER' and oh, by the way, also set up
commit OLDER to be edited".  It means "do 'git rebase -i OLDER^' ..."
(note: "OLDER^" and not "OLDER").  So it is confusing to think as "-e"
as a modifier on an otherwise normal "git rebase -i" invocation.
Rather, it seems to me that "-e" and "-i" should be mutually exclusive
(and consider it an implementation detail that the former is implemente=
d
using the latter).

And if that is our point of view, then is perfectly logical to allow it
to be specified multiple times.  OTOH there is no reason that v1 has to
allow multiple "-e", as long as it properly rejects that usage.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
