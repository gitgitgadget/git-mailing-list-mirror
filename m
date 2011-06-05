From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] Interactive-rebase doesn't pick all children of "upstream"
Date: Sun, 05 Jun 2011 10:11:11 -0400
Message-ID: <4DEB8E7F.60705@gmail.com>
References: <20110517161234.GA21388@sigill.intra.peff.net> <1307251953-25116-1-git-send-email-andrew.kw.w@gmail.com> <4DEB495F.9080900@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 16:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTE2y-0000Gn-U6
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 16:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab1FEOLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 10:11:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44019 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab1FEOLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 10:11:15 -0400
Received: by iyb14 with SMTP id 14so2496130iyb.19
        for <git@vger.kernel.org>; Sun, 05 Jun 2011 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=i4tFrhWIDlo6n5njm68jvXWHUrMCvGjrE80uoRQ2PwQ=;
        b=H88xkULcN03HIUhhFWyMeVywa3M4KduWhbvH0dw2/276Crs3TJTTgy5wXLDlyNMZR0
         9d2JRqNp26nXOkFqY51WnGeiQG0YBQlK0fzDe1ZJkc3II+lipWJAiox1fbRMlqNDDrt1
         V8ktg1HodgtxnAaWChxihQoATbZVslFU/dMcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dAAfwPNQM/5ud0cPgnr46N4D2chP9bgykixSlLZYqGlOWLv/nLLdxSNh3/VIJZhQIq
         HyDRBFCgtm+MWjk0SUExe6qvqwWRcIAlg1qk1lSlh8OgLf04baw4ljeMqZc9MJAb5Ul8
         lqt1plDKq8Tpv+HLjHdEUW52FbOySguJKqb0o=
Received: by 10.42.26.83 with SMTP id e19mr7032833icc.387.1307283074406;
        Sun, 05 Jun 2011 07:11:14 -0700 (PDT)
Received: from ZanarkandMac.local (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id e1sm2017836icv.20.2011.06.05.07.11.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Jun 2011 07:11:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEB495F.9080900@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175076>

On 11-06-05 5:16 AM, Johannes Sixt wrote:
> Am 05.06.2011 07:32, schrieb Andrew Wong:
>> Currently, (1) and (2) will pick B, D, C, and E onto A and F,
>> respectively.  However, (3) will only pick D and E onto B.  This
>> behavior of (3) is inconsistent with (1) and (2), and we cannot modify C
>> in the interactive-rebase.
> I cannot reproduce your claims:
>
> - (1) and (2) picks B,C,D top A and F, but not E because E is a merge.
>
> - (3) picks C and D, but not E because E is a merge.
Ah, all those commands should have "-p" on them to preserve the merges. 
Thanks for the catch!
