From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 6/7] build: "make clean" should not remove configure-generated
 files
Date: Thu, 19 Jul 2012 09:30:08 +0200
Message-ID: <5007B780.7010500@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com> <cover.1342649928.git.stefano.lattarini@gmail.com> <e763e7f466efa34f48589f8353a7316fff469145.1342649928.git.stefano.lattarini@gmail.com> <vpqy5mgdyro.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 19 09:30:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlBr-0008NA-Th
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab2GSHaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:30:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39964 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2GSHaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:30:20 -0400
Received: by bkwj10 with SMTP id j10so2126564bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=QZ1Cno29ETnIKahmxSWEIY5w8/z/b122b0jnSml5HNU=;
        b=bcR7HkEG5ujEFvYlocgflCYWhdEeV3iUEgDdFjxwvmuOD0SbTVwD0BjgGJ0c12mlCX
         VJTDRc75QW5e0c3n7C8DlFb04IhWyJjxl+McQ0M4PcKDO3LjobJtIgo9qWByjego8oIP
         ZKJzxXJi9AvkqGCs+jPXsktulVP3ZTeCN8To6HRFCKqe+xX94IRelY8enLqMWcjVjub1
         KNP1WdnA4bV6nZitQDyOZ5iPtxA+EGj3yLZUjjrPcwpcs7Tk7rnhTibaa8SRNyvoWP7n
         wE8sSHwxA7BKYh3HRH28k+Hz1BIdrYBFMetDcG89ZrhdCw/gkfdfJ1YKhFIFhun2VXBJ
         nTpQ==
Received: by 10.204.41.206 with SMTP id p14mr247981bke.54.1342683019248;
        Thu, 19 Jul 2012 00:30:19 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id gq2sm392618bkc.13.2012.07.19.00.30.17
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:30:17 -0700 (PDT)
In-Reply-To: <vpqy5mgdyro.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201713>

On 07/19/2012 08:56 AM, Matthieu Moy wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> for example, an autotools old-timer that has run:
>>
>>     ./configure --prefix /opt/git
>>
>> in the past, without running "make distclean" afterwards, would
>> expect a "make install" issued after a "make clean" to rebuild and
>> install git in '/opt/git';
> 
> I've been hit by that behavior once. Thanks for fixing it. The patch
> looks good.
> 
Should I add "Acked-by: Matthieu Moy" then?  (Sorry if it's a dumb
question, but I'm not sure which the preferred policy is around here).

Thanks,
  Stefano
