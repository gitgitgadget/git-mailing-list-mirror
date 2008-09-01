From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 18:22:11 -0700
Message-ID: <7vljyc1wzg.fsf@gitster.siamese.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org>
 <53906E21-DE02-4C85-8CC0-4E4AC53AE130@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 03:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZy8c-0007oQ-T2
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 03:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYIABWV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2008 21:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbYIABWV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 21:22:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYIABWU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Aug 2008 21:22:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B3BA86F0B8;
	Sun, 31 Aug 2008 21:22:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2DF86F0B6; Sun, 31 Aug 2008 21:22:14 -0400 (EDT)
In-Reply-To: <53906E21-DE02-4C85-8CC0-4E4AC53AE130@develooper.com> (Ask
 =?utf-8?Q?Bj=C3=B8rn?= Hansen's message of "Sun, 31 Aug 2008 12:54:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B3A6048-77C4-11DD-BCF6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94521>

Ask Bj=C3=B8rn Hansen <ask@develooper.com> writes:

> On Aug 30, 2008, at 10:39, Robert Schiele wrote:
>
>> git-add--interactive has one Perl command that was not yet present i=
n
>> Perl 5.6.  Changing this single command makes it compatible again.
>
> Perl 5.8.0 was released six years ago.  Perl 5.6.0 was released in
> *2000*.  I think we can safely tell people to get with the program an=
d
> use Perl 5.8.
>
>> This is an alternative to my previous patch that just declared Perl
>> 5.8 to
>> be the required version.
>
> +1 to that one.

Now, would somebody volunteer to go everywhere our user base (who no
longer read Release Notes) hang around, post a message saying that some
people on git development list are proposing to drop Perl 5.6 support, =
and
if the proposal goes ahead, it is possible that the next release may fo=
rce
upgrading Perl for them, to make sure they won't complain saying they'v=
e
never heard about the "incompatible change" beforehand?
