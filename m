From: <dag@cray.com>
Subject: Re: git-svn: --ignore-paths appears to be ignored
Date: Thu, 24 May 2012 11:23:36 -0500
Message-ID: <nngsjepwnsn.fsf@transit.us.cray.com>
References: <CAH3Anrrz3OB2CofKAnRn2yR3DQRvHyQQSp6=GG-jqvYyD79b9g@mail.gmail.com>
	<jpl70m$r97$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
X-From: git-owner@vger.kernel.org Thu May 24 18:23:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXapI-0007Lg-N5
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 18:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405Ab2EXQXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 12:23:44 -0400
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:53949 "EHLO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457Ab2EXQXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 12:23:42 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob112.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT75gjQFN5OA9YhVwY19a6fiJstZp+Qo2@postini.com; Thu, 24 May 2012 09:23:42 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.247.3; Thu, 24 May
 2012 11:23:39 -0500
In-Reply-To: <jpl70m$r97$1@dough.gmane.org> (Ben Tebulin's message of "Thu, 24
	May 2012 13:45:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198390>

Ben Tebulin <nntp.20.jexpert@spamgourmet.com> writes:

> Am 07.05.2012 00:42, schrieb Jon Seymour:
>> I configured ignore-paths as follows:
>>      svn-remote.svn.ignore-paths=^DB.*
>>
>> I expected this would exclude paths of this kind on the initial fetch:
>>      DB/.project
>
> I have the same issue here. I'm failing to import multiple svn
> repository into Git and --ignore-paths provides me no cure.

One thing to be aware of is that --ignore-paths doesn't work across svn
branches.  I tried to ignore entire branches using it and it didn't
work.  I had to resort to importing chunks of revisions at a time,
skipping the ones that created and merged branches I didn't care about.

                               -Dave
