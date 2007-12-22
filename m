From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move git send-email cover letter temporary file to $GIT_DIR
Date: Fri, 21 Dec 2007 17:09:04 -0800
Message-ID: <7vmys3358v.fsf@gitster.siamese.dyndns.org>
References: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>
	<1198284202-20666-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luciano@eurotux.com, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 22 02:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5srw-0006YU-79
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 02:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXLVBJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 20:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbXLVBJM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 20:09:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbXLVBJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 20:09:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 41E8D1C7B;
	Fri, 21 Dec 2007 20:09:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFFBE1C7A;
	Fri, 21 Dec 2007 20:09:05 -0500 (EST)
In-Reply-To: <1198284202-20666-1-git-send-email-hendeby@isy.liu.se> (Gustaf
	Hendeby's message of "Sat, 22 Dec 2007 01:43:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69116>

Don't you have $repo (an instance of Git) at that point?  You
should be able to ask repo_path() about it, shouldn't you?
