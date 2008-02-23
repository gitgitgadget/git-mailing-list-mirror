From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Eliminate confusing "won't bisect on seeked tree" failure
Date: Sat, 23 Feb 2008 14:59:38 -0800
Message-ID: <7vejb3z3c5.fsf@gitster.siamese.dyndns.org>
References: <1203571214.24456.6.camel@homer.simson.net>
 <87pruqfc59.wl%cworth@cworth.org> <7v63wgap10.fsf@gitster.siamese.dyndns.org>
 <87oda7o742.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <efault@gmx.de>, git <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3MS-0005TM-Tf
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbYBWW7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbYBWW7y
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:59:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbYBWW7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:59:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A40D81C9A;
	Sat, 23 Feb 2008 17:59:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF2901C99; Sat, 23 Feb 2008 17:59:41 -0500 (EST)
In-Reply-To: <87oda7o742.wl%cworth@cworth.org> (Carl Worth's message of "Sat,
 23 Feb 2008 10:33:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74876>

Carl Worth <cworth@cworth.org> writes:

>  Does this seem safe enough, Junio?

Neither the earlier one nor this one passes t6030.
