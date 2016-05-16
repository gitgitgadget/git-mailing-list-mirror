From: Eugene Yarmash <e.yarmash@gmail.com>
Subject: Re: bug: autostash is lost after aborted rebase
Date: Mon, 16 May 2016 14:23:14 -0700 (MST)
Message-ID: <1463433794509-7656556.post@n2.nabble.com>
References: <20140519005719.GB38299@tequila> <vpqlhtym8lp.fsf@anie.imag.fr> <xmqqegzo1hhv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:31:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Q77-0002ly-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbcEPVbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:31:41 -0400
Received: from mwork.nabble.com ([162.253.133.43]:50711 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbcEPVbl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:31:41 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 May 2016 17:31:41 EDT
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 0ACCD2A9C6B48
	for <git@vger.kernel.org>; Mon, 16 May 2016 14:23:15 -0700 (PDT)
In-Reply-To: <xmqqegzo1hhv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294799>

The bug still persists when you abort the rebase by using :cq in Vim (exit
with an error code).
See also http://stackoverflow.com/q/37252108/244297



--
View this message in context: http://git.661346.n2.nabble.com/bug-autostash-is-lost-after-aborted-rebase-tp7611141p7656556.html
Sent from the git mailing list archive at Nabble.com.
