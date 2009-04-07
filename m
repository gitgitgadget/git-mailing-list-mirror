From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Tue, 07 Apr 2009 00:38:18 -0700
Message-ID: <op.urz95k0q4oyyg1@localhost.localdomain>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com> <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
 <871vs5kjfw.fsf@krank.kagedal.org> <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "David Aguilar" <davvid@gmail.com>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	markus.heidelberg@web.de,
	"Felipe Contreras" <felipe.contreras@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	=?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr68S-00061f-Df
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbZDGHwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZDGHwq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:52:46 -0400
Received: from spider.alvarezp.com ([66.150.225.106]:41109 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZDGHwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:52:45 -0400
X-Greylist: delayed 845 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2009 03:52:45 EDT
Received: from localhost.localdomain (201.160.155.130.cable.dyn.cableonline.com.mx [201.160.155.130])
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id n377cN3T021598
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Tue, 7 Apr 2009 00:38:29 -0700
In-Reply-To: <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
User-Agent: Opera Mail/10.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115923>

On Mon, 06 Apr 2009 11:30:54 -0700, Junio C Hamano <gitster@pobox.com> wrote:
>    - when you want to work with the index, you say --cached;
>
>    - when you want to work with both the index and the work tree at the
>      same time, you say --index.

This is where I also think the options are messed up.

If I want to work with the "index", shouldn't I use... uhh... "--index"?

If I want to work with both, shouldn't I use something like "--both"?

"And if --index works with the workcopy and index, will --cache use both,
the workcopy and the cache?"

To a new user like me, these options don't look like they refer to different
actions, but to different existing things. Those options say that there is
an index, and there is a cache.

(Now I learned all of this through reading the docs which is not hard, but
reading this from the man pages is not intuitive at all.)
