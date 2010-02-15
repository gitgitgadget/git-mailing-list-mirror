From: cg <chengang31@gmail.com>
Subject: ce_stage(..) == 2?
Date: Mon, 15 Feb 2010 14:48:43 +0800
Message-ID: <4B78EE4B.2040707@gmail.com>
Reply-To: chengang31@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 07:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgulN-0007cb-WE
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 07:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0BOGsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 01:48:53 -0500
Received: from mail-yw0-f179.google.com ([209.85.211.179]:46243 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0BOGsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 01:48:52 -0500
Received: by ywh9 with SMTP id 9so4181284ywh.19
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 22:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=JmYolIdD+uYVINW4agnuwPWtTgemW3jF5vTdN8sSI78=;
        b=IBlDXcbareIxYAEM1TbykYYivQWyBGUZ8T7hzJ2594P7oxSJx3S59nhW5HkJuT9BZK
         ZMvuVYNHJXSjHpMOzd/gQTArkWHFsNug7GH0VHy9mQqzTdp/DHB17sfNPVz7hhU+Xv7U
         3nfpPtCUqqqauOMd5NGmjXe9BSMqctOOH7gc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=EDMutLyRUXE6rI/gDabABUHukacYHNhT7CHD47E/loe22jLfKwZaezItZcKIgRmEw9
         Sw9nK3m6yXp7XL2/hgm3+63ujZAJkXbsuVqKGSOX3cx33BfFe12SQeEOrK2BStEqi/EE
         2rBdz6UBPQs1EjKuLd4PUwThRf5LnazKJIn4g=
Received: by 10.150.119.8 with SMTP id r8mr5408455ybc.102.1266216531524;
        Sun, 14 Feb 2010 22:48:51 -0800 (PST)
Received: from ?192.168.1.2? ([117.84.150.71])
        by mx.google.com with ESMTPS id 39sm2208459yxd.45.2010.02.14.22.48.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 22:48:50 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139989>

Hi,

I  saw some code like:
attr.c(365): if (ce_stage(istate->cache[i]) == 2)
...
rerere.c(352):  if (ce_stage(e2) == 2
...

but there is no 0x200 in cache.h(158):
#define CE_NAMEMASK  (0x0fff)
#define CE_STAGEMASK (0x3000)
#define CE_EXTENDED  (0x4000)
#define CE_VALID     (0x8000)
#define CE_STAGESHIFT 12

so what does "2" mean?

Thanks
cg
