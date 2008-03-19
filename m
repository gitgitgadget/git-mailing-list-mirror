From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch] Import "git-forest" into contrib/
Date: Wed, 19 Mar 2008 14:52:35 -0700
Message-ID: <7v4pb22xgc.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803181924560.8851@fbirervta.pbzchgretzou.qr>
 <20080319211140.GK2663@genesis.frugalware.org>
 <alpine.LNX.1.00.0803192222350.25695@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:54:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6F6-00083h-Pj
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939149AbYCSVww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 17:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939144AbYCSVwv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:52:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939139AbYCSVwt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2008 17:52:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A38E1151;
	Wed, 19 Mar 2008 17:52:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 32A3F114E; Wed, 19 Mar 2008 17:52:43 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803192222350.25695@fbirervta.pbzchgretzou.qr>
 (Jan Engelhardt's message of "Wed, 19 Mar 2008 22:22:54 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77563>

Jan Engelhardt <jengelh@computergmbh.de> writes:

> On Mar 19 2008 22:11, Miklos Vajna wrote:
>
>> On Tue, Mar 18, 2008 at 07:25:38PM +0100, Jan Engelhardt <jengelh@co=
mputergmbh.de> wrote:
>>> commit b6612a2efe93660be7ecdb799625015efedadff1
>>> Author: Jan Engelhardt <jengelh@computergmbh.de>
>>> Date:   Tue Mar 18 19:24:33 2008 +0100
>>>
>>>     Import "git-forest" into contrib/
>>
>> missing signed-off-by?
>>
>
> Wasnot sure if it's used for git too;

Yes.

git also expects the kernel style e-mails, and it is _NOT_ "dump output
from 'git show' in the message, commit/Author:/Date: headers and messag=
e
indented by 4-spaces" format.

As to the contents, I did not understand this part.

+Notes on interpretation:
+
+'=E2=95=AC' (or variants thereof, like =E2=95=AA) is meant to be a "pa=
th bridge", i.e.
+traversal is only "allowed" horizontal OR vertical direction.
+
+Branching:
+C D E F G
+=E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=A9=E2=95=90=E2=95=A9=E2=95=90=
=E2=95=9D  A->{C,E,F,G} and B->D.
+A B

So the horizontal line bridge goes over the vertical road between B and=
 D
and these two will not get connection to anything else.  That part I
understand.

 (1) Why then is that horizontal bridge connected to E, F and G?  Do
     pluses and inverted Ts have different meaning?  What about the
     sideway T between A and C?

 (2) If you want to express D is merge between A and B, and C, E, F, G =
are
     independent children of A, how would you write it?

Did you mean "Connection with three legs (T, inverted T, sideways T) me=
an
all sides are connected, connection with four legs (+) mean horizontal =
and
vertical are independent and disconnected"?
