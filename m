From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 2/7] l10n: unpack-trees: mark strings for translation
Date: Sat, 9 Apr 2016 12:19:24 +0000
Message-ID: <5708F34C.3090004@sapo.pt>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
 <1460145765-7454-2-git-send-email-vascomalmeida@sapo.pt>
 <xmqqpotzvoia.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 14:19:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aorrg-0001tx-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 14:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbcDIMTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2016 08:19:41 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:50522 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751112AbcDIMTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 08:19:40 -0400
Received: (qmail 26319 invoked from network); 9 Apr 2016 12:19:38 -0000
Received: (qmail 15121 invoked from network); 9 Apr 2016 12:19:38 -0000
Received: from unknown (HELO [192.168.64.2]) (vascomalmeida@sapo.pt@[207.158.41.54])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPSA
          for <worldhello.net@gmail.com>; 9 Apr 2016 12:19:32 -0000
X-PTMail-RemoteIP: 207.158.41.54
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqpotzvoia.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291090>

=C0s 20:23 de 08-04-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> Mark strings seen by the user inside setup_unpack_trees_porcelain() =
and
>> display_error_msgs() functions for translation.
>>
>> One case Git outputs the named strings is when the user does some ed=
iting to
>> a file on some branch and then checks out other branch, but that fil=
e
>> changes by the checkout. This is the case of the first string marked=
=2E
>=20
> The second paragraph puzzling.  Other strings are not shown at all?
> Or is it just you didn't bother explaining the others cases?
>=20
> Either case, it is not immediately clear why you felt that one
> string among others deserve more attention.  Care to elaborate?

I meant that as an example, which was the situation I was when I found
the untranslated string.
I should have written that outside the commit message, as a note.
I'm going to remove that paragraph since it isn=92t irrelevant and
confusing. Hope I answered you.

>=20
> In the patch itself I did not find anything questionable, though.
>=20
> Thanks.
>=20
>>
>> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>> ---
>>  unpack-trees.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 9f55cc2..4bc6b4f 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -61,21 +61,21 @@ void setup_unpack_trees_porcelain(struct unpack_=
trees_options *opts,
>>  	const char *cmd2 =3D strcmp(cmd, "checkout") ? cmd : "switch branc=
hes";
>> =20
>>  	if (advice_commit_before_merge)
>> -		msg =3D "Your local changes to the following files would be overw=
ritten by %s:\n%%s"
>> -			"Please, commit your changes or stash them before you can %s.";
>> +		msg =3D _("Your local changes to the following files would be ove=
rwritten by %s:\n%%s"
>> +			"Please, commit your changes or stash them before you can %s.");
>>  	else
>> -		msg =3D "Your local changes to the following files would be overw=
ritten by %s:\n%%s";
>> +		msg =3D _("Your local changes to the following files would be ove=
rwritten by %s:\n%%s");
>>  	msgs[ERROR_WOULD_OVERWRITE] =3D msgs[ERROR_NOT_UPTODATE_FILE] =3D
>>  		xstrfmt(msg, cmd, cmd2);
>> =20
>>  	msgs[ERROR_NOT_UPTODATE_DIR] =3D
>> -		"Updating the following directories would lose untracked files in=
 it:\n%s";
>> +		_("Updating the following directories would lose untracked files =
in it:\n%s");
>> =20
>>  	if (advice_commit_before_merge)
>> -		msg =3D "The following untracked working tree files would be %s b=
y %s:\n%%s"
>> -			"Please move or remove them before you can %s.";
>> +		msg =3D _("The following untracked working tree files would be %s=
 by %s:\n%%s"
>> +			"Please move or remove them before you can %s.");
>>  	else
>> -		msg =3D "The following untracked working tree files would be %s b=
y %s:\n%%s";
>> +		msg =3D _("The following untracked working tree files would be %s=
 by %s:\n%%s");
>> =20
>>  	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =3D xstrfmt(msg, "removed=
", cmd, cmd2);
>>  	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =3D xstrfmt(msg, "ove=
rwritten", cmd, cmd2);
>> @@ -84,14 +84,14 @@ void setup_unpack_trees_porcelain(struct unpack_=
trees_options *opts,
>>  	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
>>  	 * cannot easily display it as a list.
>>  	 */
>> -	msgs[ERROR_BIND_OVERLAP] =3D "Entry '%s' overlaps with '%s'.  Cann=
ot bind.";
>> +	msgs[ERROR_BIND_OVERLAP] =3D _("Entry '%s' overlaps with '%s'.  Ca=
nnot bind.");
>> =20
>>  	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =3D
>> -		"Cannot update sparse checkout: the following entries are not up-=
to-date:\n%s";
>> +		_("Cannot update sparse checkout: the following entries are not u=
p-to-date:\n%s");
>>  	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =3D
>> -		"The following Working tree files would be overwritten by sparse =
checkout update:\n%s";
>> +		_("The following Working tree files would be overwritten by spars=
e checkout update:\n%s");
>>  	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =3D
>> -		"The following Working tree files would be removed by sparse chec=
kout update:\n%s";
>> +		_("The following Working tree files would be removed by sparse ch=
eckout update:\n%s");
>> =20
>>  	opts->show_all_errors =3D 1;
>>  	/* rejected paths may not have a static buffer */
>> @@ -168,7 +168,7 @@ static void display_error_msgs(struct unpack_tre=
es_options *o)
>>  		string_list_clear(rejects, 0);
>>  	}
>>  	if (something_displayed)
>> -		fprintf(stderr, "Aborting\n");
>> +		fprintf(stderr, _("Aborting\n"));
>>  }
>> =20
>>  /*
