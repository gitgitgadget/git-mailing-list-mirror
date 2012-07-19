From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 3/7] autoconf: remove some redundant shell indirections
Date: Thu, 19 Jul 2012 09:30:57 +0200
Message-ID: <5007B7B1.8000909@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com> <4392b87d8e6c73cfa06459a24b1721b8a8e13a81.1342649928.git.stefano.lattarini@gmail.com> <7v394owq3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 09:31:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlCX-00010j-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab2GSHbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:31:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42469 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2GSHbC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:31:02 -0400
Received: by bkwj10 with SMTP id j10so2126954bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=9SyjSFwfxBscIdg/oco9IDNxoatAqLzY3SdyfA5fNFg=;
        b=eVx0A/AsVdVk5R9dsUivaMccW571b7oKXgFAjLhwhmrNnajGCio6WaQ3MRdpxbTtVm
         h64+xTQMc0U8QEkKwvVbZqiykWkVL02xcqJhNgDPZ0BK8PkqqtrecK88svsOLUCfaYQ0
         TD5vuTUcxeSzlwQlvtKXHGwrjESyfo1kgajMmvfb0ZNQjPvEPdb1gm9Wmp/oLhU2uudM
         ZsIj6N35GpQEyX7jSW5Pn7K4LVA+zhzZNjFq1M+EPoSj53rGcl6vK36QULhuNFHNTHq1
         GDOhJkrwKf82BIczFw8oq0EMA9z28ajjEv/2hCBjCqX2zXJdr0NoLbV+cpiEynYfl3pd
         CDOg==
Received: by 10.205.126.14 with SMTP id gu14mr232502bkc.137.1342683060977;
        Thu, 19 Jul 2012 00:31:00 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id fu8sm402855bkc.5.2012.07.19.00.30.58
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:30:59 -0700 (PDT)
In-Reply-To: <7v394owq3l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201714>

On 07/19/2012 02:29 AM, Junio C Hamano wrote:
> 
> The inconsistency between the existing one that does not quote the
> string that is not substituted, i.e.
> 
> 	GIT_UC_PROGRAM[]_PATH=$withval
> 
> and the new one that quotes _PATH, i.e.
> 
> 	GIT_CONF_SUBST(GIT_UC_PROGRAM[_PATH], [])
> 
> looks somewhat strange, though.
>
Will fix that in the re-roll.

Thanks,
  Stefano
