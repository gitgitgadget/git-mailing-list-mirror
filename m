From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 13:57:35 +0200
Message-ID: <t2zfabb9a1e1004230457pae290977w730e1f0adf32017f@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain> 
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home> <87sk6n4426.fsf@frosties.localdomain> 
	<20100423093943.GB30346@atjola.homenet> <87zl0u5r75.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 13:58:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5HWG-0001vo-C4
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 13:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab0DWL57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 07:57:59 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62001 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab0DWL56 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 07:57:58 -0400
Received: by bwz19 with SMTP id 19so1649bwz.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 04:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=I2B6lYrsOv/haOwvGWthLCNae4BgKjECxNgYc3sSAI8=;
        b=hK2TT3gkiSMotFYpvdxqTzBU/ZtcwDAn2/vQLEeXLt475OsY/Ud91dA9NHwXmxcTBu
         5T5RX9kDA/Z3zKVWh4d3/sbQqlY0XZUP0qBxjIXsR4riLaiCOmjRm2FvgvqLKQA8VVf+
         0BLzxV92tsYVOXCkRou8ntXk54O9PY8O6JovM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CESOeMXuaBcLfG9wtqZuZgo2DmQgsrG+YCxje0UGePQxz09j+HWZcAL4PIl2vZigwh
         FIIIUoayC8hxbbwtJ6hxzihf+Jlyg4oJZBsaulxPJpPmhQD2KKSdlnYoKOrGsHUrzP+N
         X8ZR4jY1EwHcz7MG4geF/r8UdUmKVmB4Wm/mA=
Received: by 10.103.168.14 with HTTP; Fri, 23 Apr 2010 04:57:35 -0700 (PDT)
In-Reply-To: <87zl0u5r75.fsf@osv.gnss.ru>
Received: by 10.103.78.10 with SMTP id f10mr3298058mul.126.1272023875139; Fri, 
	23 Apr 2010 04:57:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145610>

Heya,

2010/4/23 Sergei Organov <osv@javad.com>:
> And how do you check your changes for correctness before committing?

git stash save -k && make all test && git stash pop

-- 
Cheers,

Sverre Rabbelier
