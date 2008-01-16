From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Merging using only fast-forward
Date: Wed, 16 Jan 2008 08:27:52 -0800
Message-ID: <863asxivlj.fsf@blue.stonehenge.com>
References: <loom.20080116T151930-575@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Hvammen Johansen <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFB7n-0000vL-FK
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 17:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYAPQ1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 11:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbYAPQ1y
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 11:27:54 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:23447 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbYAPQ1x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 11:27:53 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9D9561DE267; Wed, 16 Jan 2008 08:27:52 -0800 (PST)
x-mayan-date: Long count = 12.19.14.17.19; tzolkin = 10 Cauac; haab = 7 Muan
In-Reply-To: <loom.20080116T151930-575@post.gmane.org> (Sverre Hvammen Johansen's message of "Wed, 16 Jan 2008 15:54:34 +0000 (UTC)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70697>

>>>>> "Sverre" == Sverre Hvammen Johansen <hvammen@gmail.com> writes:

Sverre> If there are changes on both A and B that have not yet been integrated
Sverre> (by A doing a pull (fetch/rebase)) I want a pull (fetch/merge) on B to
Sverre> fail.

Junio implemented a 7-line patch on the IRC channel (calling parts of it
"for randal" or something, I believe :) to do precisely this.

Perhaps you can test it, and submit it as if it were your idea.  I, for one,
would use it as well.  I'm doing ugly things with parsing the output of
git-status right now to achieve the same thing.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
