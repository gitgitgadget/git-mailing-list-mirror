From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #04; Thu, 20)
Date: Thu, 20 Mar 2014 15:36:46 -0700
Message-ID: <xmqqk3bowl8h.fsf@gitster.dls.corp.google.com>
References: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com>
	<532B659D.9010604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, apelisse@gmail.com, Max Horn <max@quendi.de>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 20 23:36:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQla3-0001GZ-1W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759549AbaCTWgu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 18:36:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758342AbaCTWgt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 18:36:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC127603A;
	Thu, 20 Mar 2014 18:36:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q6ZqdNrLP84f
	7Gdl487QELag29k=; b=RdN5AMGfoQuHFwNyGHYntlcy0H1QoVFLHwy2etyLnjGm
	yjPLCnh4OP8zsF45yZzxI7u91oN+00cVcmqOidUdGkwOaxPi7zrY0coez7+bsa23
	qrHLvAEA7jl7uZr7fmIcis0NiRT0WaK3AV8CEZur8g0Ujmp6EAykUfsg4qWKuN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T7GZ1d
	adnoSvUx0GQ2VvhghPds3W3ClKynoTVDgV+CMqG9Yx+fn/Hi/WbVRKGxX9OVvJz7
	XJhlEo8cgImrjv84KOxnx3G6JhOoDoq8axv7bF+JN/5tj8QEfKJEHXgqvxF+QxxR
	Z5mBwDM5ByQVXYwLQDdNXcAQMQW/ZXCpEKWQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45DDB76039;
	Thu, 20 Mar 2014 18:36:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ECF276038;
	Thu, 20 Mar 2014 18:36:48 -0400 (EDT)
In-Reply-To: <532B659D.9010604@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 20 Mar 2014 23:03:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1FBBB66C-B080-11E3-B8B5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244596>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 03/20/2014 10:09 PM, Junio C Hamano wrote:
>> * ap/remote-hg-skip-null-bookmarks (2014-03-19) 1 commit
>>   - remote-hg: do not fail on invalid bookmarks
>>
>>   Will merge to 'next'.
> Hmm, am I the only one who has 11 failures in test-hg-hg-git.sh,

Still?  I thought I pushed out an updated version.

> like this:
> (Tested under Debian 7, commit 04570b241ddb53ad2f355977bae541bd7ff32a=
f5)

>
>
> master cde5672] clear executable bit
>  Author: A U Thor <author@example.com>
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 =3D> 100644 alpha
> WARNING: Ignoring invalid bookmark 'master'
> To hg::../hgrepo-git
>  ! [remote rejected] master -> master
> error: failed to push some refs to 'hg::../hgrepo-git'
> not ok 1 - executable bit
> []
> # failed 11 among 11 test(s)
> 1..11
