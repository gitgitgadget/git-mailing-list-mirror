From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 21:06:10 +0100
Message-ID: <4D87AFB2.8080904@gmail.com>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com> <7vwrjssbfk.fsf@alter.siamese.dyndns.org> <4D877FAD.9000807@viscovery.net> <4D879516.3060204@gmail.com> <7vei60p86y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:12:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lSV-0002gA-LK
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab1CUUMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:12:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49346 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab1CUUME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:12:04 -0400
Received: by bwz15 with SMTP id 15so5328896bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+isQtyt6d62Wj2RSvRFRuwRcjxdds28rMwanKheTpt4=;
        b=C4k9L/rAEteWkFDJKv9c+fmgQ731dFZwwWQhUSzESV8g5qfpDgDxYBb6PAe5oplT9e
         ZcyozU+WAc0pvr/CSCp4Dtehql3tyFI828kKbF3QZx3rQtdlbSFKjKbORt8mVDWWk66F
         YwrEg3TfUK2act5pdPbQ1Ai40bi2l0FRYIQt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=w1X34ZwSFfc2XsoxrROSTTVr9welC0rnbjluqTcfCVbOeJKni6PDj9q7lstsajkEXf
         gUjAJ0yquVbz+NOQXlkk5uOGStyWLJeebuvpXcKubjaYIL7gEFLjMdJm2d88sG+YM5kv
         fTNVhWQjYLxFxXoH/K7FEzXS5um7YwMNtorH0=
Received: by 10.223.29.199 with SMTP id r7mr5422382fac.75.1300737978130;
        Mon, 21 Mar 2011 13:06:18 -0700 (PDT)
Received: from [192.168.1.101] (aadh98.neoplus.adsl.tpnet.pl [83.4.85.98])
        by mx.google.com with ESMTPS id j12sm263374fax.33.2011.03.21.13.06.16
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 13:06:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vei60p86y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169659>

W dniu 21.03.2011 20:47, Junio C Hamano pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> I think I even suspected this might have something to do with the merge
>> conflict and tried to make git-diff show me exact change between working
>> tree and index/HEAD (ignoring the merge).
> 
> Doesn't "git diff HEAD" show the difference between HEAD and working tree
> without the higher stages for the path getting in the way?

Forgot about this - usually commit defaults to HEAD if you didn't specify it.
My fault.

 
> The difference between the index and the working tree is "git diff" which
> is condensed.  I think you can force it to uncondense it by giving "-c"
> option, but I haven't tried (didn't find a need/use for it for a long
> time).

I think I tried it and it didn't work. It's also not described in git diff
man page.


-- 
Piotr Krukowiecki
