From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7701-repack-unpack-unreachable.sh: check timestamp of
 unpacked objects
Date: Mon, 19 May 2008 09:20:05 -0500
Message-ID: <OleexvYZfiSxUgrxHbDqLpGl2g7TsoOO7pwZXC1fiyL2KxKVuWLtWw@cipher.nrlssc.navy.mil>
References: <16342222.1211083116270.JavaMail.teamon@b306.teamon.com> <7vd4niaozy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 16:22:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy6FO-000264-Jm
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 16:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195AbYESOUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 10:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757036AbYESOUj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 10:20:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44275 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbYESOUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 10:20:39 -0400
Received: by mail.nrlssc.navy.mil id m4JEK6Bs007909; Mon, 19 May 2008 09:20:06 -0500
In-Reply-To: <7vd4niaozy.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 May 2008 14:20:06.0125 (UTC) FILETIME=[6F87C1D0:01C8B9BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82431>

Junio C Hamano wrote:
> drafnel@gmail.com writes:
> 
> 
>> +	test -f "$fsha1path" -a ! "$fsha1path" -nt "$packfile" -a \
>> +				! "$fsha1path" -ot "$packfile" &&
>> +	test -f "$csha1path" -a ! "$csha1path" -nt "$packfile" -a \
>> +				! "$csha1path" -ot "$packfile" &&
>> +	test -f "$tsha1path" -a ! "$tsha1path" -nt "$packfile" -a \
>> +				! "$tsha1path" -ot "$packfile"
>> +'
> 
> "Test" primaries -nt/-ot are unfortunately excluded from POSIX.

hrmph, and it even worked on solaris ksh.

-brandon
