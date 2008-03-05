From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Wed, 05 Mar 2008 14:53:02 -0800
Message-ID: <7vwsogkckx.fsf@gitster.siamese.dyndns.org>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
 <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
 <8aa486160803051433h2a5f0aeenaf473784198276f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2VE-00075S-Rg
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764121AbYCEWxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 17:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764030AbYCEWxS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:53:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763239AbYCEWxQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 17:53:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 405B419F0;
	Wed,  5 Mar 2008 17:53:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 880B619EE; Wed,  5 Mar 2008 17:53:10 -0500 (EST)
In-Reply-To: <8aa486160803051433h2a5f0aeenaf473784198276f6@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Wed, 5 Mar 2008 23:33:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76285>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On Wed, Mar 5, 2008 at 10:29 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
>>  Perhaps you can make git-init run a post-init hook script by
>>  default, and have ~/.gitconfig specify the location of it, and
>>  have it do whatever custom settings to the per-repository
>>  configuration file?
>
> I would still need something to prevent doing a commit without a
> locally specified name/email.

Yes, but that something could simply be "echo '[user] name'
>.git/config" in that hook, for example.



