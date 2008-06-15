From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git add: add long equivalents of '-u' and '-f'
 options
Date: Sun, 15 Jun 2008 13:21:57 -0700
Message-ID: <7vlk16cuu2.fsf@gitster.siamese.dyndns.org>
References: <1213436881-2360-1-git-send-email-szeder@ira.uka.de>
 <200806142344.m5ENiLqk020529@mi0.bluebottle.com>
 <20080615085305.GA7003@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 15 22:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ylC-0004Nz-3J
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 22:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYFOUWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jun 2008 16:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbYFOUWM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 16:22:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYFOUWL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2008 16:22:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C2C5E6CED;
	Sun, 15 Jun 2008 16:22:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA7A26CEB; Sun, 15 Jun 2008 16:22:05 -0400 (EDT)
In-Reply-To: <20080615085305.GA7003@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Sun, 15 Jun 2008 10:53:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBD9CA40-3B18-11DD-AE2E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85113>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Sun, Jun 15, 2008 at 08:43:12AM +0900, =E3=81=97=E3=82=89=E3=81=84=
=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:
>> Isn't this patch adding a new feature during the freezing period bef=
ore
>> the release?  What is the policy of accepting such a patch in genera=
l?

The policy during the freeze is "bugfix only unless otherwise noted",
which is, admittedly, not saying much ;-)

> I think this patch is rather a bugfix in the user interface than a ne=
w
> feature.

Strictly speaking, this is a new feature but I think the documentation
value to clarify -u stands for "update" is great enough to make it an
exception.  I've rewritten (from empty!  Szeder, next time please write
sensible commit log message to defend your changes, instead of having _=
me_
to defend your changes to others here, like this) the commit log messag=
e
to clarify this point.
