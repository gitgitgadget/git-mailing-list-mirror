From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/2 v2] git-gui - provide commit base to the hooks/pre-commit
 script
Date: Fri, 18 Jun 2010 22:59:20 -0400
Message-ID: <4C1C3288.5000308@gmail.com>
References: <1275965763-18940-1-git-send-email-mlevedahl@gmail.com> <1275965763-18940-2-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, jsixt@viscovery.net,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 19 04:59:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPoHN-0001st-KH
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 04:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab0FSC7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 22:59:24 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:34594 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab0FSC7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 22:59:23 -0400
Received: by ywh36 with SMTP id 36so1364212ywh.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ooMEG4N1u8sDxNhlNJelRnkOh2eAolNEbYvVPX1Yii0=;
        b=sc48zvVrT7hREjen3KWtOD3S5Ef6f9eKUnd67X9HI3weRvCk31+dhQszhv1bs3sQFv
         27C3oq8VLwFi1rEl8wfVYlGMzEx7PzGTm0vRY9xjSEqwuXzmHLY1H1CDBngnJQmaoKxw
         q69nvpJM9QkSZk/R/X2fL/KRnudd8Go+0F7DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hwWOtEmbmtXzkcOqCS6NQq8VqAl9FsznL3TWW2JdDwO1bPrze1E2nMVH2jbua+TblM
         QVGXEmr+7BPFAyISot19TILkQY2FnOnpd9n4d6VNo/bJfpumin0bm/CTrxz4JLS0HAH8
         7wIn7u/9VShCJtZR74S4QqKsLQWiUi+Yx2Ww4=
Received: by 10.229.182.147 with SMTP id cc19mr1044955qcb.213.1276916362444;
        Fri, 18 Jun 2010 19:59:22 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id m29sm46157185qck.4.2010.06.18.19.59.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 19:59:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
In-Reply-To: <1275965763-18940-2-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149373>

On 06/07/2010 10:56 PM, Mark Levedahl wrote:
> If hooks/pre-commit acts based upon the changes to be checked in
> rather than just the resulting content, the script needs to know which
> commit to use. For a normal commit, this is HEAD, but when amending this
> is HEAD~1. So, this modifies commit.tcl to pass $1 as HEAD|HEAD~1 depending
> upon the commit type. Existing scripts are unaffected as they did not
> expect any argument so will silently ignore this extra bit of info.
>
> Signed-off-by: Mark Levedahl<mlevedahl@gmail.com>
>    
Given the discussion on the first series  (starting 
with)<1275759590-16342-1-git-send-email-mlevedahl@gmail.com>, and the 
absence of objection to v2, I presume this sequence is ok?

Mark
