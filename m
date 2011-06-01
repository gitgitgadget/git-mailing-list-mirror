From: Chengwei Ding <waterding@gmail.com>
Subject: Re: git annotate with date option not working?
Date: Wed, 01 Jun 2011 14:33:30 +0200
Message-ID: <4DE6319A.5020808@gmail.com>
References: <4DE5F655.9020400@gmail.com> <BANLkTik2bTqScNLRwRwdz3h=cPJJxX6v2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Arnaud Lacurie <arnaud.lacurie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 14:33:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRkcN-0002tZ-17
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 14:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227Ab1FAMdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 08:33:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55224 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab1FAMdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 08:33:38 -0400
Received: by eyx24 with SMTP id 24so2001391eyx.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dgZaU5juq2wtXkNWrJBfKlZJD6wqCOuqGpEtxgRwfeI=;
        b=twR293vC4PNDEKeFi7epn3cR7zym0/2UajdKU8hWGK/BPyxmwcsxl8VhB+i4DyzvMC
         PD5kdifK8R+vw0D1iLKTzZmi/YprerZECz/2F5qMRgJZAnLlj2rADebjECQpJQHMMtIA
         /MnKlOKWlgxlsXaNgpG2J8e9Tgvwib/H4Axls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IX7Tufp1IXwW1TWVyjtDT3Te3cEnN8cym+w3nH6EPUdWMbya+JVq2OSRaEcA6ud/Qe
         JXH9Je1VEXlS5//7UamNLuuctq0o17mIFU3bUv+FBnxW52BryQHM14WfbFvWwTiYTDBh
         cnHgzLNoUuHKMVtG/u4+rEIKWxPIonTq3KzYg=
Received: by 10.213.107.17 with SMTP id z17mr2930731ebo.100.1306931617600;
        Wed, 01 Jun 2011 05:33:37 -0700 (PDT)
Received: from [10.20.9.95] (mail.kreditor.se [213.136.42.60])
        by mx.google.com with ESMTPS id x46sm679831eea.24.2011.06.01.05.33.34
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 05:33:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <BANLkTik2bTqScNLRwRwdz3h=cPJJxX6v2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174863>

On 06/01/2011 11:41 AM, Arnaud Lacurie wrote:
> Hi,
>
>> can anyone confirm that this "--date" option is working for git annotate
>> cmd.
> I tried 'git annotate --date=relative<onefile>' and it works perfectly here.
> git version 1.7.4.1
> ubuntu 11.04
>
> It works also well on the git version 1.7.5.3.401.gfb674 (The latest on master)
>
> Regards
>
try again on my machine, give same result when with and without --date. 
haven't tried latest master but did try the 1.7.5.3 official release 
(manual compiled)

//Chengwei
