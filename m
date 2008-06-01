From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v2] Make "git-remote rm" delete refs acccording to
 fetch specs
Date: Sun, 01 Jun 2008 01:28:05 -0700
Message-ID: <7vve0tbluy.fsf@gitster.siamese.dyndns.org>
References: <20080601042804.GA32293@spearce.org>
 <7vprr1d8p2.fsf@gitster.siamese.dyndns.org>
 <20080601063051.GH12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 10:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2iwF-0008Is-Hj
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 10:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYFAI2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 04:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYFAI2W
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 04:28:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYFAI2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 04:28:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFBE73DC9;
	Sun,  1 Jun 2008 04:28:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4AF4C3DC6; Sun,  1 Jun 2008 04:28:15 -0400 (EDT)
In-Reply-To: <20080601063051.GH12896@spearce.org> (Shawn O. Pearce's message
 of "Sun, 1 Jun 2008 02:30:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0470EBE-2FB4-11DD-A41A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83438>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I think the behavior in 2/2 and 3/3v2 is the best we can do,...

Oh, I think you already know I agree with that.  I was just pointing out
that the extra niceness would not have mattered that much in practice, but
if the code is already written and is not crappy, why not ;-)

Not blindly assuming that the remote nickname matches the actualy used
namespace under refs/remotes _is_ a good bugfix regardless of the issue of
overlapping configuration. 
