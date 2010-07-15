From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2010, #02; Wed, 14)
Date: Thu, 15 Jul 2010 13:58:22 +0200
Message-ID: <20100715115822.GD22574@debian>
References: <7vhbk1wt8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 13:56:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZN3T-0004nK-0N
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 13:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336Ab0GOL4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 07:56:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43265 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758231Ab0GOL4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 07:56:36 -0400
Received: by ewy23 with SMTP id 23so179398ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7GUKXeQyqIrUZd1FhjXx/UqWFCo4zwCeWcT5UYNPrrE=;
        b=IlJZlS73uo4FqK68d60LEPPkDZ4Xi62UzYV4FiuTpqioMdv71zeUfZLtqM9MOg1LpT
         g3n0d9Fd1ap8c4HUw8f8Oey0PkYtpkVYPPlpCauDKUQspZ44W94wj8Axn+RKswqU0P1D
         kR/gZwRLWZJjn0vAGQd0aYFoBAKNuvUY717M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ABof/2yR3h5VXWE1xl0kdJPAnkDyeiwUov+spF8GmwyagmthoHJdNuEBqcSqlTTOcX
         mmPFIAPmKzax9eOCuxWDHUmeWtsYkK6u7/KiVKVeSD2GSiKyPH0Ub7GqHRPtUXFc1I1S
         4R+wtpWSCY+h45jcX9j+Dr1xv5WkWC+M6OOTA=
Received: by 10.213.13.69 with SMTP id b5mr653640eba.29.1279194995363;
        Thu, 15 Jul 2010 04:56:35 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm7535647eei.12.2010.07.15.04.56.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 04:56:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbk1wt8k.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151075>

Hi Junio,

Junio C Hamano writes:
> * rr/svn-export (2010-06-10) 7 commits
>  - Add LICENSE
>  - Add SVN dump parser
>  - Add infrastructure to write revisions in fast-export format
>  - Add stream helper library
>  - Add library for string-specific memory pool
>  - Add cpp macro implementation of treaps
>  - Add memory pool library
> 
> I recall there was another round of re-roll planned for this one.

I was waiting for the ternary treap refactor, but I figure that it's
taking longer than I expected. I'll try to re-roll today.

-- Ram
