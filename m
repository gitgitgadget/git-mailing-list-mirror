From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] sha1_name: pass object name length to diagnose_invalid_sha1_path()
Date: Sun, 17 Mar 2013 12:38:44 +0100
Message-ID: <5145AB44.8050704@lsrfire.ath.cx>
References: <5144BA0B.2040109@lsrfire.ath.cx> <7vzjy2qz6g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 12:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHBw2-0005sS-KX
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 12:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab3CQLix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 07:38:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:49467 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab3CQLiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 07:38:52 -0400
Received: from [192.168.2.105] (p4FFD98FC.dip.t-dialin.net [79.253.152.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 0ED2320A;
	Sun, 17 Mar 2013 12:38:51 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vzjy2qz6g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218359>

Am 17.03.2013 08:10, schrieb Junio C Hamano:
>> @@ -1158,16 +1159,16 @@ static void diagnose_invalid_sha1_path(const=
 char *prefix,
>>   		if (!get_tree_entry(tree_sha1, fullname,
>>   				    sha1, &mode)) {
>>   			die("Path '%s' exists, but not '%s'.\n"
>> -			    "Did you mean '%s:%s' aka '%s:./%s'?",
>> +			    "Did you mean '%.*s:%s' aka '.*%.*s:./%s'?",
>
> Will squash an obvious fix in and apply.

Did I try to make a point there?  Certainly not.  It seems I need to go=
=20
back to http://vim-adventures.com/.

Thank you for spotting this!
Ren=C3=A9
