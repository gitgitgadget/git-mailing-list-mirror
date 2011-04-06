From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 11:34:27 -0400
Message-ID: <4D9C8803.1000708@mit.edu>
References: <4D9B7A9E.6040902@mit.edu> <1302102336-8800-1-git-send-email-asedeno@mit.edu> <4D9C851A.7070801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Ukj-0001AG-Of
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab1DFPeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 11:34:36 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:64260 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932092Ab1DFPef (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 11:34:35 -0400
X-AuditID: 12074424-b7cacae000003d70-f0-4d9c87e2c6d8
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F5.EB.15728.2E78C9D4; Wed,  6 Apr 2011 11:33:54 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p36FYYoF020298
	for <git@vger.kernel.org>; Wed, 6 Apr 2011 11:34:34 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p36FYV32019125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 6 Apr 2011 11:34:33 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id 3012214C021; Wed,  6 Apr 2011 11:34:31 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (ita4fw1.itasoftware.com [63.107.91.99])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id E64A1834721;
	Wed,  6 Apr 2011 11:34:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110309 Icedove/3.1.9
In-Reply-To: <4D9C851A.7070801@drmicha.warpmail.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IR4hTV1n3UPsfXYPIvbYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGUcfrONqWAiX8WX23eYGhifcnUxcnBICJhIfLvk3cXICWSKSVy4
	t56ti5GLQ0hgH6PE5ssrGCGck4wSvTPuMkE4H5kkepedYQJpERIokpi6+yQrRGI3o8SC6U1s
	IAleATWJnWcnMILYLAKqEiv23AWLswm4SCx5fA3MFhWIl1j2cjYrRL2gxMmZT1hAbBEBfYlr
	556ADWUWmMUo8Wj2RGaQhLCAh8S0Y6uZITY3Mkq8nw3WwAn0w/o5+1hA/mEWUJdYP08IJMws
	IC/RvHU28wRG4VlIVsxCqJqFpGoBI/MqRtmU3Crd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU
	0k2MoNBmd1HZwdh8SOkQowAHoxIP7+nFs32FWBPLiitzDzFKcjApifJObZvjK8SXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmE1/T1LF8h3pTEyqrUonyYlDQHi5I47zxJdV8hgfTEktTs1NSC1CKY
	rAwHh5IE7xRgDAsJFqWmp1akZeaUIKSZODhBhvMADb8Mspi3uCAxtzgzHSJ/ilFRSpzXEqRZ
	ACSRUZoH1wtLPa8YxYFeEeZtA6niAaYtuO5XQIOZgAZvnTIbZHBJIkJKqoFxefcth86nOy6t
	iNofZ7DR6dPKV/KV28Jq6l6s3z79+AbrX/bCCjt21Dv7vAxSW2GytczQfOPX9p56k8yYpoiL
	+9MuzeuLmXjcc1cP19WzYpxfu1Q+CR5a0nzNs1r8mBnvy2M39Sf9FHo49+PKsg8L 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170981>

On 04/06/2011 11:22 AM, Michael J Gruber wrote:
> Alejandro R. Sede=C3=B1o venit, vidit, dixit 06.04.2011 17:05:
>> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>> Reviewed-off-by: James Y Knight <jknight@itasoftware.com>
>=20
> :) So, if that review is off, that means...

Um, s/-off//. Oops :)

I can send a follow-up, or let Eric deal with that change, however he p=
refers.

>> diff --git a/git-svn.perl b/git-svn.perl
>> index fa8cd07..184442a 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -531,7 +531,7 @@ sub cmd_dcommit {
>>  		$url =3D eval { command_oneline('config', '--get',
>>  			      "svn-remote.$gs->{repo_id}.commiturl") };
>>  		if (!$url) {
>> -			$url =3D $gs->full_url
>> +			$url =3D $gs->full_pushurl
>=20
> Wouldn't we want to do the same $gs->full_pushurl || $gs->full_url fa=
ll
> back here as below, or is fullpush_url always set? OK, I see it alway=
s is.

Yeah, I just went with full_pushurl returning full_url in cases where
pushurl is not set.

>> @@ -2071,6 +2073,8 @@ sub new {
>>  	$self->{url} =3D command_oneline('config', '--get',
>>  	                               "svn-remote.$repo_id.url") or
>>                    die "Failed to read \"svn-remote.$repo_id.url\" i=
n config\n";
>> +	$self->{pushurl} =3D eval { command_oneline('config', '--get',
>> +	                          "svn-remote.$repo_id.pushurl") };
>=20
> Why eval? We don't do it for url either.

Because otherwise it would die with:

  $ git svn fetch
  config --get svn-remote.svn.pushurl: command returned error: 1

when pushurl wasn't defined. If that happens with 'url' too, well, that=
's
a mis-configured git-svn remote.

>> +sub full_pushurl {
>> +	my ($self) =3D @_;
>=20
> Isn't that a noop?

I'm just copying the style of sub full_url here.

-Alejandro
