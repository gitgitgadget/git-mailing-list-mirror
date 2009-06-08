From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: mention 'git stash pop --index' option explicitly
Date: Mon, 08 Jun 2009 14:23:55 -0700
Message-ID: <7viqj6xvv8.fsf@alter.siamese.dyndns.org>
References: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:24:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmKL-0003Tp-Ob
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbZFHVXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 17:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbZFHVXy
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:23:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52396 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZFHVXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:23:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608212356.TNQU17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jun 2009 17:23:56 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1ZPv1c0094aMwMQ03ZPvDe; Mon, 08 Jun 2009 17:23:55 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=G6np98s7CV4A:10 a=pyTkBgOdRj8A:10
 a=5w6XAim6vY1Y-JBLhEEA:9 a=EUvvGHY2U4PvY0N3B_7bTZCgXPQA:4
X-CM-Score: 0.00
In-Reply-To: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
 ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon\,  8 Jun 2009
 18\:27\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121111>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> -'git stash' (show | drop | pop ) [<stash>]
> +'git stash' (show | drop ) [<stash>]
> +'git stash' pop [--index] [<stash>]
>  'git stash' apply [--index] [<stash>]

Why not "(pop | apply) [--index]"?

Other than that looks sensible.
