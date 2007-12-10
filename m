From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Interactive editor tests for commit-msg hook
Date: Mon, 10 Dec 2007 08:32:43 +0100
Message-ID: <704CE0C4-FD30-424B-86DF-2625E39707B7@wincent.com>
References: <1197204731-19553-1-git-send-email-win@wincent.com> <7vwsrnmczu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 08:33:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1d8t-0005AR-Uh
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 08:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbXLJHdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2007 02:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbXLJHdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 02:33:09 -0500
Received: from wincent.com ([72.3.236.74]:38292 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbXLJHdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 02:33:08 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBA7WhOZ019408;
	Mon, 10 Dec 2007 01:32:44 -0600
In-Reply-To: <7vwsrnmczu.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67688>

El 10/12/2007, a las 4:42, Junio C Hamano escribi=F3:

>> +# set up fake editor for interactive editing
>> +cat > fake-editor <<'EOF'
>> +#!/bin/sh
>> +cp FAKE_MSG "$1"
>> +exit 0
>> +EOF
>> +chmod +x fake-editor
>> +FAKE_EDITOR=3D"$(pwd)/fake-editor"
>> +export FAKE_EDITOR
>
> Hmm.  Why "export"?

Because I'd seen it in other tests (eg. t3404-rebase-interactive.sh), =20
so I just copied the style. If it's not necessary though we can lose it=
=2E

> I initially was going to say "this is just a style thing", but I =20
> really
> want our tests to read uniformly like this:

Ok, fixed up version will follow in a couple of minutes.

Cheers,
Wincent
