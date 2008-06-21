From: Junio C Hamano <gitster@pobox.com>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Sat, 21 Jun 2008 14:42:07 -0700
Message-ID: <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
 <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jan Engelhardt" <jengelh@medozas.de>,
	"Bart Trojanowski" <bart@jukie.net>, git@vger.kernel.org
To: "Vegard Nossum" <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAArf-00055z-F0
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbYFUVmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbYFUVmX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:42:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbYFUVmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:42:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 47FABD470;
	Sat, 21 Jun 2008 17:42:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8BEDED46F; Sat, 21 Jun 2008 17:42:11 -0400 (EDT)
In-Reply-To: <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com>
 (Vegard Nossum's message of "Sat, 21 Jun 2008 23:30:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED0359EE-3FDA-11DD-865D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85729>

"Vegard Nossum" <vegard.nossum@gmail.com> writes:

> On Sat, Jun 21, 2008 at 11:21 PM, Jan Engelhardt <jengelh@medozas.de> wrote:
>>
>> Since git 1.5.6, `git status` always invokes a pager, which is really
>> annoying when the output is less than the number of terminal rows
>> available. Can I turn that off somehow or do I need to send a reverting
>> patch?
>
> I think it would work to set PAGER="less -F" (a.k.a. --quit-if-one-screen)?

Probably better with LESS=FRSX, which is what git uses as a sane default
if nothing is set.
