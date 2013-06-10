From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a better coding-style
Date: Mon, 10 Jun 2013 09:41:51 -0700
Message-ID: <7vhah5kje8.fsf@alter.siamese.dyndns.org>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
	<vpqk3m2qs2r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5AN-0005Gh-Sz
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab3FJQlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 12:41:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549Ab3FJQly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 12:41:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B5EA27D7A;
	Mon, 10 Jun 2013 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=exlFhOBosu0n
	1xVvfITfkuoj37U=; b=lQjg6Pfqlx8tor8qpAnuoWymytjysuQ2v+T/P2q3EfqQ
	qhe7hT/yqQxJG2JH+Nmf3bnM3GVtF0IL/VI8eCtzaCRL3JZwnLart1/MvZcVaAnn
	+lA2nrN1UO6aE4hFl9xy7Qta+Ai5VbHFFtsv56U6Gfp+3Dd8mpyLof6cQq/tblc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iLdqJH
	DhvAqsMIjzLuBMV55+ajRxaih2Us6KMPZ6Feg8LYOxCVX56/VAx3eCD49J4SKKyp
	ZWp/tTBqU/FCEVi/ODZyIqh99iQJTNdD5Bm8LkjV9cMurd5XvAH2ot9kh0YizDlY
	UYPL1jEMnwixssp3pVBvtoRBwoOLtIR1B4S8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 151E527D77;
	Mon, 10 Jun 2013 16:41:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D2DB27D74;
	Mon, 10 Jun 2013 16:41:52 +0000 (UTC)
In-Reply-To: <vpqk3m2qs2r.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	10 Jun 2013 10:37:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7620FD0-D1EC-11E2-B4A8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227319>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>
>> @@ -1285,8 +1285,7 @@ sub get_mw_namespace_id {
>>  		# Look at configuration file, if the record for that namespace is
>>  		# already cached. Namespaces are stored in form:
>>  		# "Name_of_namespace:Id_namespace", ex.: "File:6".
>> -		my @temp =3D split(/\n/, run_git("config --get-all remote."
>> -						. $remotename .".namespaceCache"));
>> +		my @temp =3D split(/\n/, run_git("config --get-all remote.${remot=
ename}.namespaceCache"));
>
> I tend to prefer the former, as it avoids long lines (> 80 columns)

But you split the name of a single variable across lines by doing so.

You could split lines to make it a bit more readable.

		my @temp =3D split(/\n/,
			run_git("config --get-all remote.${remotename}.namespaceCache"));

It still overflows the 80-column limit, but the "namespaceCache" is
the only thing that overflows; not much harm is done.

This is totally outside of the topic of "coding-style" series, but I
would be more concerned about the use of ${remotename}, though.  Has
it (and in general the parameters to all calls to run_git()) been
sanitized for shell metacharacters?  If we had a variant of run_git
that took an array of command line arguments given to git, you could
do this

		my @temp =3D split(/\n/,
			run_git([qw(config --get-all),
                        	"remote.${remotename}.namespaceCache")]);

which would be safer and easier to read.

>> @@ -1339,8 +1338,7 @@ sub get_mw_namespace_id {
>> =20
>>  	# Store explicitely requested namespaces on disk
>>  	if (!exists $cached_mw_namespace_id{$name}) {
>> -		run_git("config --add remote.". $remotename
>> -			.".namespaceCache \"". $name .":". $store_id ."\"");
>> +		run_git(qq(config --add remote.${remotename}.namespaceCache "${na=
me}:${store_id}"));
>
> Same.
