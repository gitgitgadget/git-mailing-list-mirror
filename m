From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff cr/nl files on linux
Date: Sun, 25 May 2008 21:37:10 -0700
Message-ID: <7vskw5el55.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0805240554j71693d5eo2a425ee0efe2f364@mail.gmail.com>
 <483811BF.3090302@dirk.my1.cc>
 <fcaeb9bf0805252115q60f784aax6b1f267c476960b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 06:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0UTi-0000g7-0m
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 06:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbYEZEh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 May 2008 00:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbYEZEh1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 00:37:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbYEZEh0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 May 2008 00:37:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D7FC69DA;
	Mon, 26 May 2008 00:37:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7CE0669D7; Mon, 26 May 2008 00:37:18 -0400 (EDT)
In-Reply-To: <fcaeb9bf0805252115q60f784aax6b1f267c476960b4@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Mon, 26 May 2008 11:15:10 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6F23BBC0-2ADD-11DD-97D0-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82897>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Sat, May 24, 2008 at 8:01 PM, Dirk S=C3=BCsserott <newsletter@dirk=
=2Emy1.cc> wrote:
> ...
>> What about 'git diff -w'? It drops any whitespace changes, including=
 ^M's.
>> Not sure whether that is what you meant.
>
> That won't help.

Just like GNU diff, the only thing -w (and -b) does is to omit hunks wh=
ose
changes consist of _only whitespace changes_ and nothing else.

In your quoted example, you have changes other than whitespace changes,=
 so
it is unsurprising that you will see the whole change, together with yo=
ur
whitespace changes.
