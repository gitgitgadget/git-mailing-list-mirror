From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/5] Make mktag a builtin.
Date: Mon, 12 May 2008 10:09:31 -0500
Message-ID: <48285DAB.2040707@nrlssc.navy.mil>
References: <1210299589-10448-1-git-send-email-drafnel@example.com> <1210299589-10448-2-git-send-email-drafnel@example.com> <7689656.1210299528037.JavaMail.teamon@b301.teamon.com> <7v63tk6992.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 17:11:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZgv-0007tU-AF
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbYELPK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYELPK5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:10:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46379 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbYELPKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:10:55 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m4CF9WCG010957;
	Mon, 12 May 2008 10:09:32 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 May 2008 10:09:32 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7v63tk6992.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 May 2008 15:09:32.0852 (UTC) FILETIME=[2EF21F40:01C8B442]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81872>

Junio C Hamano wrote:
> drafnel@gmail.com writes:
> 
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> 
>> @@ -306,6 +305,7 @@ BUILT_INS += git-fsck-objects$X
>>  BUILT_INS += git-get-tar-commit-id$X
>>  BUILT_INS += git-init$X
>>  BUILT_INS += git-merge-subtree$X
>> +BUILT_INS += git-mktag$X
>>  BUILT_INS += git-peek-remote$X
>>  BUILT_INS += git-repo-config$X
>>  BUILT_INS += git-show$X
>> @@ -423,6 +423,7 @@ LIB_OBJS += log-tree.o
>>  LIB_OBJS += mailmap.o
>>  LIB_OBJS += match-trees.o
>>  LIB_OBJS += merge-file.o
>> +LIB_OBJS += mktag.o
> 
> This is unusual for a builtin.  Why didn't it migrate to builtin-mktag?

I didn't know how to do it.

I was trying not to do a code move and a code change at the same time.
I didn't think I should move the non-builtin mktag.c to builtin-mktag.c,
and then after I modified mktag to be a builtin I knew I was moving it
to builtin-tag.c so I didn't see a point to renaming it.

Also, I decided about those things _before_ I realized how small the changes
would be to mktag to make it a builtin.

Do you think the modified patch you posted conflicts with the idea that
"code move should be separate from code change"?

-brandon
