From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 18:30:49 -0700
Message-ID: <7v3acy5t86.fsf@gitster.siamese.dyndns.org>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com>
 <49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Sat Mar 28 02:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnNPq-0006Xf-HX
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 02:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760052AbZC1Ba7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 21:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759916AbZC1Ba6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 21:30:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759335AbZC1Ba5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 21:30:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B7239803A;
	Fri, 27 Mar 2009 21:30:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EDC7E8035; Fri,
 27 Mar 2009 21:30:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1550702E-1B38-11DE-A959-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114931>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> AFAIK, "committing" in git is "kind of publishing your work" (others may
> pull it).

You, like all the other people who worked with centralized systems for too
long, need a break from this misconception.  Once you get rid of it, you
will realize that the separation of commit (which is merely "recording so
that you can later refer to it, including for the purposes of going back
to it, comparing something else with it and merge something else with it")
and push (which is the "publishing" part) is the fundamental difference
between centralized and distributed systems.  It frees you from having to
worry about the "damned if you commit, damned if you don't" issue I
mentioned in my other message.
