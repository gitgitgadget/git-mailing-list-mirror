From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Sat, 07 Jun 2008 02:06:45 +0200
Message-ID: <4849D115.5030602@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>	 <200806061524.04140.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ly9-000383-40
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbYFGAGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755580AbYFGAGs
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:06:48 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:40887 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYFGAGs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:06:48 -0400
Received: by mu-out-0910.google.com with SMTP id w8so753626mue.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7GZtYzeF72ovoaLAtXvd2x8RXvR0T5OKE+amaMAc1wk=;
        b=LARCb9AacUlyWtJihKXqlv9vBKvWmHaUkaE6ONJp9pPNX4SKJCdWl38X83bDehQXUQ
         cvROz3CSHtDJQSgajiEXypfd2b8ku4JM4o5J3IdCkpKU/+TJOf+G4ZNIPYbzcEzpBAyv
         rEX9SajMdZu9zOGOg9uty5i5iHYDYaHsIEByU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rR5mk2kExnY86ddxrf/J5fnqUWCOEp8w9w0cShwGPMpeAUGuadWkoD3sNUvIqNzO/+
         XHHmnTM2Zq2W+USh+/vcH004KyGnlnnIycghgJInqnZDqfiS5ktNttfJu3YWPlORm8Nr
         I+Vj20gbb4P+rrjtEiaeGQt/1Bt1+36kY5iig=
Received: by 10.102.253.13 with SMTP id a13mr399456mui.74.1212797206160;
        Fri, 06 Jun 2008 17:06:46 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id i5sm24280906mue.2.2008.06.06.17.06.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 17:06:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-3)
In-Reply-To: <200806061524.04140.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84148>

On Fri, Jun 6, 2008 at 3:24 PM, Robin Rosenberg 
<robin.rosenberg@dewire.com> wrote:
> A well defined set of enhancements with only minor nitpicks (in separate mails)

Nice to hear. I'll send v2 of these 2 patches (04 and 09) in a moment. 
With a slightly less place for nitpicks, I hope.

>  I'm somewhat reluctant to reformatting patches though. 

Well, so should I remove these reformatting patches from series? (oouch!)

Actually, when I ran into formatting problem, Shawn suggested that I may 
format PackFile as he was also touching this file - I much appreciated 
this idea. PackIndex* formatting is however my own invention.

So you assume that Eclipse 3.4 will just force us to submit new patches
with specified formatting, but keep old lines formatting untouched, am I
right?
Isn't it somewhat annoying that formatting is inconsistent through
project (especially line width in some places)? And that I almost have
to block formatting shortcut to stop my pre-save/pre-commit habit?;)

Thanks,
-- 
Marek Zawirski / zawir
marek.zawirski@gmail.com
