From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: [msysGit] Windows & executable bit for newly created files
Date: Fri, 16 Dec 2011 19:27:37 +0100
Message-ID: <4EEB8D99.9030302@dirk.my1.cc>
References: <4EEA5387.5020808@dirk.my1.cc> <7vwr9xmu48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:28:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbcWc-0003XA-CP
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760510Ab1LPS2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 13:28:50 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:42983 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760178Ab1LPS2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 13:28:49 -0500
Received: from [217.87.98.165] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1RbcVN-0002jP-Pa; Fri, 16 Dec 2011 19:27:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vwr9xmu48.fsf@alter.siamese.dyndns.org>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187298>

Am 15.12.2011 21:56 schrieb Junio C Hamano:
> Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:
>=20
>> Is there a way to convince git that the new mode is 755 instead of 6=
44,
>> even with core.filemode set to false? So that the mode is correct wh=
en I
>> checkout the file under Linux later on?
>=20
> "git update-index --chmod=3D+x"?
>=20

Oh, thanks. I wasn't aware of that option. Works exactly as I like.

Dirk
