From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 2/3] Documentation: gitrevisions
Date: Wed, 14 Jul 2010 10:42:05 +0200
Message-ID: <4C3D785D.1050000@drmicha.warpmail.net>
References: <cover.1278346173.git.git@drmicha.warpmail.net> <7efed85cefddff1cd2cc3a0e3802326306117f4e.1278346173.git.git@drmicha.warpmail.net> <4C3D562B.3070404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 10:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYxYf-0004CK-VC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 10:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab0GNInI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 04:43:08 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43929 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752190Ab0GNInF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 04:43:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6343E16E7D8;
	Wed, 14 Jul 2010 04:43:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 14 Jul 2010 04:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1uHKuiNWuUZ9VKtkXi/w+hiCfJs=; b=BSiQpMnIo1HItz909yet5AxTriqJlpESw/uSsyqxQFnxGrHxGSW67Ts1CgsNwTgXUN+XOcFivJuHXSWO8YDXYv7ZaJBa7Lu3q/2VnhZTul1EClMEn7ik7VICxBOn40JKCT0TgGJxkh7ztKmNz+5mRUllaoZycsOYZ46OeIWzW28=
X-Sasl-enc: F6ng/RPKQRJsEmBL/HZN51Q4Ll5xxFSbZxfHiRO/rP8v 1279096984
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D3F774F6253;
	Wed, 14 Jul 2010 04:43:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <4C3D562B.3070404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150971>

Stephen Boyd venit, vidit, dixit 14.07.2010 08:16:
>   On 07/05/2010 09:11 AM, Michael J Gruber wrote:
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Many Git commands take revision parameters as arguments. Depending on
>> +the command, they denote a specific commit or, for commands which
>> +walk the revision graph (such as linkgit:git-log[1]), all commits which can
>> +be reached from that commit. In the latter case one can also specify a
>> +range of revisions explicitly.
>> +
>> +In addition, some Git commands (such as linkgit:git-show[1]) also take
>> +revision parameters which denote other objects than commits, e.g. blobs
>> +("files") or trees ("directories of files").
>> +
> 
> Is any of this text (section?) necessary besides including revisions.txt? It seems that revisions.txt nicely covers the types of revisions in the first paragraph of each section and these two paragraphs repeat that.
> 
> Can you squash this in?
> 
> --->8----
> 
> index fc4789f..0e25c5f 100644
> --- a/Documentation/gitrevisions.txt
> +++ b/Documentation/gitrevisions.txt
> @@ -10,19 +10,6 @@ SYNOPSIS
>   gitrevisions
> 
> 
> -DESCRIPTION
> ------------
> -
> -Many Git commands take revision parameters as arguments. Depending on
> -the command, they denote a specific commit or, for commands which
> -walk the revision graph (such as linkgit:git-log[1]), all commits which can
> -be reached from that commit. In the latter case one can also specify a
> -range of revisions explicitly.
> -
> -In addition, some Git commands (such as linkgit:git-show[1]) also take
> -revision parameters which denote other objects than commits, e.g. blobs
> -("files") or trees ("directories of files").
> -
>   include::revisions.txt[]
> 
> 
> 

I added this text on purpose. The "DESCRIPTION" section is meant to give
a concise description of the overall picture so that, e.g., you
understand which section will answer which question without having to
read all of them. In this case it gives you a short overview of what can
be referred to by revisions (commit, commit range, general object)
before the sections go into the details of how to specify them.

Also, as I mentioned in the cover letter, I suggest a rework of the
actual (included, old) content if that structure is to stay. So, in a
second step, one could avoid duplications.

But here, I find it really natural (if not necessary) that the first
paragraph in each detailed section picks up on the pertaining parts of
the concise description.

Michael
