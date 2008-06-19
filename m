From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Thu, 19 Jun 2008 12:21:00 -0700
Message-ID: <7vd4mdten7.fsf@gitster.siamese.dyndns.org>
References: <87wsrhex4c.fsf@cpan.org>
 <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
 <7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
 <46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
 <86r6ens6k5.fsf@cpan.org> <86iqzyse9u.fsf@cpan.org> <861w2tjpev.fsf@cpan.org>
 <46a038f90806191200n237633u80f0be736e8d227b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avar@cpan.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	martyn@catalyst.net.nz, martin@catalyst.net.nz
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Pi3-0005u0-Ad
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbYFSTVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 15:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYFSTVR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:21:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYFSTVQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 15:21:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 29B9B1BBA5;
	Thu, 19 Jun 2008 15:21:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 500DD1BBA3; Thu, 19 Jun 2008 15:21:03 -0400 (EDT)
In-Reply-To: <46a038f90806191200n237633u80f0be736e8d227b@mail.gmail.com>
 (Martin Langhoff's message of "Thu, 19 Jun 2008 15:00:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E29452BC-3E34-11DD-AD0F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85517>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On Thu, Jun 19, 2008 at 1:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avar@cpan.org> wrote:
>>> 1. http://git.nix.is/?p=3Davar/git;a=3Dcommitdiff;h=3D60f893bd9fe32=
9bd5cf8ec513d10ec00e85feb2c
>>
>> It has been over 3 months since I submitted this patch without anyon=
e
>> acting on it. In absence of comment from the Mart[yi]ns could this
>> please applied anyway?
>
> Sorry. My opinion on this is a mild ACK on the technical front, and a
> bit of a frown ("do we really want to offer this?"). Specifically, my
> concern goes beyond what you can do against a pserver service - git
> hooks can be targeted with this. "Warning: as safe as telnet" ;-)

"As safe as telnet" is Ok as long as it is strictly optional.  What I
would primarily be worried about is if this change is a no-op for exist=
ing
users, when they chose not to enable the new feature.
