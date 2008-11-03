From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/3] packed_git: convert pack_local flag into generic
 bit mask
Date: Mon, 03 Nov 2008 12:24:56 -0600
Message-ID: <CU90KJ5IESAvyuMdaPcAuWOyXIdTgXenJ-InGZLiFn8@cipher.nrlssc.navy.mil>
References: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com> <6141358.1225643400587.JavaMail.teamon@b303.teamon.com> <20081103161202.GJ15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	nico@cam.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:29:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx4BR-0005hm-SX
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbYKCS2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 13:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYKCS2g
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:28:36 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35390 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYKCS2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 13:28:36 -0500
Received: by mail.nrlssc.navy.mil id mA3IOuAQ004565; Mon, 3 Nov 2008 12:24:56 -0600
In-Reply-To: <20081103161202.GJ15463@spearce.org>
X-OriginalArrivalTime: 03 Nov 2008 18:24:56.0653 (UTC) FILETIME=[792A6FD0:01C93DE1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99974>

Shawn O. Pearce wrote:
> drafnel@gmail.com wrote:

>> diff --git a/cache.h b/cache.h
>> index b0edbf9..0cb9350 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -679,12 +679,15 @@ extern struct packed_git {
>>  	int index_version;
>>  	time_t mtime;
>>  	int pack_fd;
>> -	int pack_local;
>> +	unsigned int flags;
> 
> Hmm, isn't this a smaller change to make?

heh, well if you want to do it the "easy" way. :)

For some reason I've never used this bit field mechanism, but
I agree it is more readable and simpler, and you can't argue
with that.

-brandon
