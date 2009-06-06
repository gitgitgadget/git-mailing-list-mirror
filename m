From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-parse-remote: remove unused functions
Date: Sat, 06 Jun 2009 13:37:23 -0700
Message-ID: <7v63f9cd4s.fsf@alter.siamese.dyndns.org>
References: <1244231617-17754-3-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Jun 06 22:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD2dw-0001yT-BG
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 22:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbZFFUhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 16:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZFFUhW
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 16:37:22 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58954 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZFFUhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 16:37:21 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090606203723.RZNB18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Sat, 6 Jun 2009 16:37:23 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 0kdP1c0054aMwMQ04kdP6V; Sat, 06 Jun 2009 16:37:23 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=HcgwT1ojgXgA:10 a=l-fQol_yr7cA:10
 a=3yCQnsJiAAAA:8 a=S-PhCh7O8r36gid5RDIA:9 a=hsmwNvn1ltNRJy06V90A:7
 a=s-zJlHtKivKbsEsLJqgAKg5HtvkA:4 a=cdoSpQTWPqQA:10
X-CM-Score: 0.00
In-Reply-To: <1244231617-17754-3-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Fri\,  5 Jun 2009 21\:53\:37
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120935>

Santi B=C3=A9jar <santi@agolina.net> writes:

> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
> ---
>  .gitignore                         |    1 -
>  Documentation/git-parse-remote.txt |   50 ---------
>  git-parse-remote.sh                |  204 --------------------------=
----------
>  3 files changed, 0 insertions(+), 255 deletions(-)
>  delete mode 100644 Documentation/git-parse-remote.txt

I do not understand this patch.

With this patch remove git-parse-remote from .gitignore (as if the enti=
re
file is going away) and its documentation (again as if the entire file =
is
going away), so naturally I would have expected to see removal of the f=
ile
in the patch as well (and that means Makefile needs to be touched), but
that is not what is happening.
