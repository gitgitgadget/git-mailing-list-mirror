From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: cvsexportcommit dies when applying an (empty) merge commit
Date: Wed, 25 Nov 2009 23:00:27 +0000
Message-ID: <4B0DB70B.1090405@yahoo.co.uk>
References: <4B0D1C1A.60707@yahoo.co.uk> <4B0D2BC5.1000002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:00:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQqg-0004nm-8b
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759107AbZKYXAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758951AbZKYXAX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:00:23 -0500
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:52173 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902AbZKYXAW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:00:22 -0500
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.100])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1NDQqa-00052U-Bs; Wed, 25 Nov 2009 23:00:28 +0000
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B0D2BC5.1000002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133695>

Michael J Gruber wrote:
> I think the behavior is correct in the sense that you're telling git
> cvsexportcommit to make a commit to cvs, and it can't, because there is
> no change to commit. A merge can't be represented.

The main problem with this is that by default it aborts the whole process with
an error.  I'd prefer a non-fatal warning rather than having to catch the error
and decide if it's ignorable or not, although for now I guess I'll have to, or
make a fork of git-cvsexportcommit.

CVS doesn't has an --allow-empty equivalent I know of, and nor does
git-cvsexportcommit.

Cheers,

N
