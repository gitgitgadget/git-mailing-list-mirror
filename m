From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: migrate to parse-options
Date: Tue, 23 Jun 2009 22:08:06 -0700
Message-ID: <7vws721ao9.fsf@alter.siamese.dyndns.org>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
	<1245817672-25483-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 07:08:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJKib-0002Ly-It
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 07:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbZFXFIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 01:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbZFXFIK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 01:08:10 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:40323 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbZFXFIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 01:08:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090624050813.NRJR20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jun 2009 01:08:13 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7h8C1c0034aMwMQ04h8C16; Wed, 24 Jun 2009 01:08:12 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=zKQtKpDWXuoA:10 a=pGLkceISAAAA:8
 a=Hs4Ol_0MEeltZlT5GioA:9 a=EG-VWBdHXNlAdlsf1obIlj0UKM8A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1245817672-25483-2-git-send-email-bebarino@gmail.com> (Stephen Boyd's message of "Tue\, 23 Jun 2009 21\:27\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122124>

Stephen Boyd <bebarino@gmail.com> writes:

> Cleanup the documentation to explicitly state that --exclude-directory
> is only meaningful when used with -u. Also make the documentation more
> consistent with the usage message printed with read-tree --help-all.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  Documentation/git-read-tree.txt |    5 +-
>  builtin-read-tree.c             |  220 +++++++++++++++++++++-----------------
>  2 files changed, 126 insertions(+), 99 deletions(-)

Sorry, but I have to ask: Why?
