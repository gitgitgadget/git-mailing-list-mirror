From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve documentation for --dirstat diff option
Date: Mon, 01 Sep 2008 03:29:23 -0700
Message-ID: <7vwshww458.fsf@gitster.siamese.dyndns.org>
References: <20080901005028.GA31502@zakalwe.fi> <g9gdev$2un$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:30:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6gH-0005hs-JE
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbYIAK3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 06:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYIAK3c
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:29:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYIAK3b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 06:29:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E80C5BEBC;
	Mon,  1 Sep 2008 06:29:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8E3325BEBB; Mon,  1 Sep 2008 06:29:27 -0400 (EDT)
In-Reply-To: <g9gdev$2un$1@ger.gmane.org> (Jakub Narebski's message of "Mon,
 01 Sep 2008 11:42:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC564BA6-7810-11DD-9A58-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94564>

Jakub Narebski <jnareb@gmail.com> writes:

> Heikki Orsila wrote:
> ...
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can be set with "--dirsta=
t=3Dlimit". Damage for a child directory is not
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0counted for the parent di=
rectory, unless "--cumulative" is used.
>
> I rather prefer "impact" to "damage". And it should probably be=20
> "child directory _shown_".

The word "damage" did raise my eyebrow as well, even though I knew it c=
ame
from the wording of the variable to compute it, and coming from somebod=
y
like Linus it somewhat sounds funny ;-) I was going to suggest using a
more neutral "change" in the end user documentation.
