From: David Aguilar <davvid@gmail.com>
Subject: Re: git-p4: Fix sync errors due to new server version
Date: Mon, 1 Feb 2010 11:38:53 -0800
Message-ID: <20100201193851.GA6134@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: simon@lst.de, git@vger.kernel.org, pal_engstad@naughtydog.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 01 20:39:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc276-0003hj-3U
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 20:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab0BATjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 14:39:06 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:34168 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab0BATjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 14:39:05 -0500
Received: by bwz23 with SMTP id 23so453201bwz.21
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=kRksofGxXtK487qW1qSEMITTjBpwX3Tuo627TM35W5M=;
        b=mP5Ob+C0WCLh/9rSWR/5HXPZEB9ele98D+Hw8ELPTH5zboBwxxaCiqPVn+CYYNJGRB
         rIeLH2J6oDaxtSHuZhKRxNHq80DdsNQyB5OMF5eJONcyLbGg32luEgnCgBVdl3Y4sjS+
         Bpl4g+mJkXAliEn1lZWW/m0qERKT/Ujzqhy2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=F3yaRYRbSIQoj8HQqnNhGQpg5WUeukVHSQqUl2qUKZ/DrE/4imlIIVl3YhF9UMrubD
         r58Zim1BFjkJ3wti229XDULfB9b8qZGb74+QZT7EOOOw7MQDKpfaBuap3rIg4cNhnFE0
         KaMHQg3MH7KkziDJa6vKBNi3KvEDsxYGhp/cc=
Received: by 10.102.204.13 with SMTP id b13mr2569496mug.127.1265053141991;
        Mon, 01 Feb 2010 11:39:01 -0800 (PST)
Received: from gmail.com (guest-wireless.pixar.com [199.108.77.12])
        by mx.google.com with ESMTPS id 25sm3208381mul.20.2010.02.01.11.38.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 11:39:00 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138642>


Hi Junio

It looks like we forgot about this patch:

http://article.gmane.org/gmane.comp.version-control.git/137723

The patch looks good and Pal added his sign-off
(I believe that and not inlining the patch were the original
 setbacks).

Simon, are there any reasons to not apply it?

Thanks,

-- 
		David
