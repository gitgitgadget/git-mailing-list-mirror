From: <dag@cray.com>
Subject: Re: (minor concern) git using the pager should not be a default
Date: Fri, 31 Aug 2012 12:54:45 -0500
Message-ID: <nngligvdk0q.fsf@transit.us.cray.com>
References: <503E3CFE.1080603@sigmadesigns.com>
	<7vd329wpt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Emmanuel Michon <emmanuel_michon@sigmadesigns.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:59:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7VUo-0008B5-G5
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 19:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab2HaR67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 13:58:59 -0400
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:33723 "EHLO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab2HaR66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 13:58:58 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob112.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUED7XxdPxXvgUji6arV9xPAqrJp45IwO@postini.com; Fri, 31 Aug 2012 10:58:58 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Fri, 31 Aug
 2012 12:54:48 -0500
In-Reply-To: <7vd329wpt0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 29 Aug 2012 10:50:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204598>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, Porcelain (roughly speaking, those that page by
> default when their standard output is terminal), are not "command
> line applications"; they have a layer on top with a built-in UI.

Is "status" considered a plumbing layer command?  Because I have often
wondered why it does not use the pager by default.  I pipe it through
less all the time and it's kind of annoying that it works differently
than everything else.

                                -Dave
