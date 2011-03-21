From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 21:07:41 +0100
Message-ID: <4D87B00D.2010905@gmail.com>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com> <7vwrjssbfk.fsf@alter.siamese.dyndns.org> <4D877FAD.9000807@viscovery.net> <4D879516.3060204@gmail.com> <20110321195846.GA4277@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lSW-0002gA-64
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab1CUUMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:12:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59246 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab1CUUMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:12:07 -0400
Received: by fxm17 with SMTP id 17so5818760fxm.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=vhGKJBaNlvjN9rsAjgSo838MOMZ+ZrD61wcr95cruiM=;
        b=C/ZRLs8bPfR4BJbylIjJEcJ1ulLq90fUGQiQpdHTcXRlWVBljOxcZK8DJmmA4KQ2rJ
         GVexjDVRhcwJPiQ36KMJsHyqmh1oHr+IwgiWOZ7xei1DVm4Rq6sXO1yAxHKGic3R9EJR
         gRbQl7b52W0xjXJzbjKdvas59JYP+LcN01CTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Gz4ZxEAq//fxAZXRN926gQQMQTHmb4c+HwK8WyWzFP4/9rXpr0ktVbf78p7z0B0UAj
         vT7u+l3VdxlUv22OkEaK3zyhg/3oFN2YRP0sfyPgoube3HWvBAuk9XkCBiJnQUGsWK7m
         7NR7qyUKnYA3crYN7uYM1mgneVf+8SG8fyxZM=
Received: by 10.223.73.194 with SMTP id r2mr5434906faj.108.1300738064438;
        Mon, 21 Mar 2011 13:07:44 -0700 (PDT)
Received: from [192.168.1.101] (aadh98.neoplus.adsl.tpnet.pl [83.4.85.98])
        by mx.google.com with ESMTPS id o17sm2668071fal.25.2011.03.21.13.07.42
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 13:07:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <20110321195846.GA4277@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169660>

W dniu 21.03.2011 20:58, Jonathan Nieder pisze:
> Piotr Krukowiecki wrote:
> 
>> I think I even suspected this might have something to do with the merge
>> conflict and tried to make git-diff show me exact change between working
>> tree and index/HEAD (ignoring the merge), so I can verify the file indeed
>> only have the change I did, but I could not find such option.
>> Does it exists? 
> 
> Sure.  The index contains multiple competing versions, which you can
> see with "git ls-files -u".  To compare the working tree and one of
> those use "git diff --base / --ours / --theirs" (or -1 / -2 / -3).

Thanks, didn't know about that (and it's not documented in diff man page).

 
> To view changes relative to a particular commit, use "git diff <commit>".
> For example, "git diff HEAD".  The git-diff(1) manpage (shown by
> "git diff --help") explains.
> 
> Hope that helps,
> Jonathan


-- 
Piotr Krukowiecki
