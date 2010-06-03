From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: How do I ignore the changes made by CVS keyword substitution
	efficiently?
Date: Thu, 3 Jun 2010 15:35:27 -0400
Message-ID: <20100603193527.GK28492@bombadil.infradead.org>
References: <AANLkTilhvjn1ypRoKs2CxJdA1zDkaT5i64vh0ZtfjwMk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 21:35:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKGCY-0002CM-LK
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 21:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab0FCTf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 15:35:29 -0400
Received: from bombadil.infradead.org ([18.85.46.34]:34730 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0FCTf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 15:35:28 -0400
Received: from kyle by bombadil.infradead.org with local (Exim 4.69 #1 (Red Hat Linux))
	id 1OKGCN-0005HS-ML; Thu, 03 Jun 2010 19:35:27 +0000
Content-Disposition: inline
In-Reply-To: <AANLkTilhvjn1ypRoKs2CxJdA1zDkaT5i64vh0ZtfjwMk@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148355>

On Fri, Jun 04, 2010 at 03:13:29AM +0800, Lin Mac wrote:
> I'm merging kernel from others, and they used CVS to manage their
> code, and so do some part of linux kernel. Unfortunatly CVS would
> substitude the keywords in the source, result in unecessary changes in
> the code, like the one in the following diff. In fact, there are
> around 1174 of CVS keywords in the kernel source. I don't want those
> useless changes to get into my tree.

You want the -ko option to cvs checkout/update which will use the
original keywords from the import.

regards, Kyle
