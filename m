From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/3] Teach git diff-tree --stdin to diff trees
Date: Sat, 9 Aug 2008 22:36:51 +0200
Message-ID: <20080809203651.GA18968@diana.vm.bytemark.co.uk>
References: <20080808204348.7744.46006.stgit@yoghurt> <20080808204829.7744.11661.stgit@yoghurt> <7vk5erb3ru.fsf@gitster.siamese.dyndns.org> <20080809095605.GA10804@diana.vm.bytemark.co.uk> <7viqua54vd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 22:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRurt-0006rn-KG
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 22:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYHIUPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 16:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbYHIUPc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 16:15:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2234 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbYHIUPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 16:15:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KRvBD-0004wz-00; Sat, 09 Aug 2008 21:36:51 +0100
Content-Disposition: inline
In-Reply-To: <7viqua54vd.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91779>

On 2008-08-09 13:07:50 -0700, Junio C Hamano wrote:

> Thinking about it a bit more, -m, -c and --cc are not about commits
> at all. Your excuse not to support them is because these three are
> about diffing more than two trees (and I'd say that is still a good
> rationale).

Indeed (but only because that mode is not supported on the command
line). Would you like a commit message with a revised excuse?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
