From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7701-repack-unpack-unreachable.sh: check timestamp of
 unpacked objects
Date: Mon, 19 May 2008 15:27:02 -0500
Message-ID: <E8K6ZsektNV-bzzpBDDSjLUNAu6_Tgxq9EV2896g2zCI6VyLsESxXw@cipher.nrlssc.navy.mil>
References: <16342222.1211083116270.JavaMail.teamon@b306.teamon.com> <7vd4niaozy.fsf@gitster.siamese.dyndns.org> <OleexvYZfiSxUgrxHbDqLpGl2g7TsoOO7pwZXC1fiyL2KxKVuWLtWw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 22:36:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyC3r-0004jZ-7f
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 22:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758625AbYESUdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 16:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbYESUdc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 16:33:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42188 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYESUdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 16:33:31 -0400
Received: by mail.nrlssc.navy.mil id m4JKR27q010430; Mon, 19 May 2008 15:27:02 -0500
In-Reply-To: <OleexvYZfiSxUgrxHbDqLpGl2g7TsoOO7pwZXC1fiyL2KxKVuWLtWw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 May 2008 20:27:02.0583 (UTC) FILETIME=[B25CA470:01C8B9EE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82447>

Brandon Casey wrote:
> Junio C Hamano wrote:
>> drafnel@gmail.com writes:
>>
>>
>>> +	test -f "$fsha1path" -a ! "$fsha1path" -nt "$packfile" -a \
>>> +				! "$fsha1path" -ot "$packfile" &&
>>> +	test -f "$csha1path" -a ! "$csha1path" -nt "$packfile" -a \
>>> +				! "$csha1path" -ot "$packfile" &&
>>> +	test -f "$tsha1path" -a ! "$tsha1path" -nt "$packfile" -a \
>>> +				! "$tsha1path" -ot "$packfile"
>>> +'
>> "Test" primaries -nt/-ot are unfortunately excluded from POSIX.
> 
> hrmph, and it even worked on solaris ksh.

FYI, also works with dash, and there is a use of '-nt' in git-mergetool.sh
which is not exercised by the test suite.

Maybe I'll think about a perl version.

Also, do you have a url to your posix reference?

-brandon
