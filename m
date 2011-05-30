From: Markus Duft <mduft@gentoo.org>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Mon, 30 May 2011 08:51:01 +0200
Message-ID: <4DE33E55.6090505@gentoo.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org> <1306332924-28587-3-git-send-email-mduft@gentoo.org> <20110526022045.GA8172@elie> <7vhb8hzcm8.fsf@alter.siamese.dyndns.org> <20110526163921.GD24931@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tor Arntsen <tor@spacetec.no>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 08:50:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQwJT-0000Nr-8E
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 08:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab1E3Guv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 02:50:51 -0400
Received: from smtp.salomon.at ([193.186.16.13]:56096 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752484Ab1E3Guu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 02:50:50 -0400
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id p4U6oUJR025194;
	Mon, 30 May 2011 08:50:30 +0200 (METDST)
Received: from [172.28.8.166] ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 30 May 2011 08:50:24 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110506 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110526163921.GD24931@elie>
X-OriginalArrivalTime: 30 May 2011 06:50:24.0511 (UTC) FILETIME=[DA1BB0F0:01CC1E95]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174729>

On 05/26/11 18:39, Jonathan Nieder wrote:
> Junio C Hamano wrote:
> 
>> --- a/compat/fnmatch/fnmatch.c
>> +++ b/compat/fnmatch/fnmatch.c
>> @@ -127,6 +127,10 @@ extern char *getenv ();
>>  extern int errno;
>>  # endif
>> +
>> +# ifndef NULL
>> +#  define NULL 0
>> +# endif
> 
> Makes a lot of sense.  This fits well with the style of the rest of
> the file and other projects using glibc fnmatch could reuse the fix
> even if targeting ancient platforms.

I tested, and it works well on interix. Will you commit, or should i prepare a patch?

Thanks
Markus
