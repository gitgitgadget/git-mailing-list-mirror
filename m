From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce receive.denyDeletes
Date: Fri, 31 Oct 2008 01:04:22 -0700
Message-ID: <7v63n99omx.fsf@gitster.siamese.dyndns.org>
References: <20081030191134.62455c24@perceptron>
 <20081030183210.GO14786@spearce.org> <20081030194503.2f9ece1a@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?utf-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Oct 31 09:06:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvp17-0003OY-LX
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbYJaIEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYJaIEm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:04:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbYJaIEk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Oct 2008 04:04:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 046B2770DC;
	Fri, 31 Oct 2008 04:04:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1CB63770D9; Fri, 31 Oct 2008 04:04:29 -0400 (EDT)
In-Reply-To: <20081030194503.2f9ece1a@perceptron> (Jan =?utf-8?Q?Kr=C3=BCg?=
 =?utf-8?Q?er's?= message of "Thu, 30 Oct 2008 19:45:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F8BD2B4-A722-11DD-B84A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99559>

"Jan Kr=C3=BCger" <jk@jk.gs> writes:

> Can I then delete the branch afterwards without lots of juggling (in
> case the test fails due to a random other reason that the branch
> accidentally getting deleted by receive-pack)? I'd expect I'd have to
> save the exit code to a temporary variable and that's just as ugly.

Although I agree that your attempt to allow the test continue even when
this test fails is a very good practice, I personally do not find the
alternative you mention ugly at all.  I actually find that "return 1"
uglier because it feels like it knows too much about how
test_expect_success is implemented.
