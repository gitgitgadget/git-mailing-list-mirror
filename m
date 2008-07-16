From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't cut off last character of commit descriptions.
Date: Wed, 16 Jul 2008 14:11:41 -0700
Message-ID: <7viqv5pm9e.fsf@gitster.siamese.dyndns.org>
References: <m2abh3z14f.fsf@nschum.de> <87k5g7fb05.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nikolaj Schumacher <n_schumacher@web.de>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJEJ0-0005Vs-H9
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967AbYGPVLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jul 2008 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756956AbYGPVLu
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:11:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbYGPVLt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jul 2008 17:11:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BEFE292E8;
	Wed, 16 Jul 2008 17:11:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8A396292E5; Wed, 16 Jul 2008 17:11:44 -0400 (EDT)
In-Reply-To: <87k5g7fb05.fsf@lysator.liu.se> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of "Mon, 30 Jun 2008 12:55:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD63E55E-537B-11DD-8DC6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88759>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Nikolaj Schumacher <n_schumacher@web.de> writes:
>
>> From d485d9c86cba49671b74c7c1571a6ad7ec6d09b6 Mon Sep 17 00:00:00 20=
01
>> From: Nikolaj Schumacher <git@nschum.de>
>> Date: Mon, 30 Jun 2008 12:06:01 +0200
>> Subject: [PATCH] Don't cut off last character of commit descriptions=
=2E
>>
>> ---
>>  contrib/emacs/git-blame.el |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
>> index 9f92cd2..4fa70c5 100644
>> --- a/contrib/emacs/git-blame.el
>> +++ b/contrib/emacs/git-blame.el
>> @@ -381,7 +381,7 @@ See also function `git-blame-mode'."
>>                    "log" "-1"
>>  		  (concat "--pretty=3D" git-blame-log-oneline-format)
>>                    hash)
>> -    (buffer-substring (point-min) (1- (point-max)))))
>> +    (buffer-substring (point-min) (point-max))))
>> =20
>>  (defvar git-blame-last-identification nil)
>>  (make-variable-buffer-local 'git-blame-last-identification)
>
> Yes, this should have been part of
> 24a2293ad35d567530048f0d2b0d11e0012af26d git-blame.el: show the when,
> who and what in the minibuffer. that changed from using
> --pretty=3Doneline to --pretty=3Dformat:... without terminating newli=
ne.

Sorry, I realize I haven't applied the patch from Nikolaj.  Should I ta=
ke
this as an Ack?
