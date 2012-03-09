From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] configure: allow user to prevent $PATH "sanitization"
 on Solaris
Date: Fri, 09 Mar 2012 22:46:28 +0100
Message-ID: <4F5A7A34.3050000@gmail.com>
References: <7vhay6etqc.fsf@alter.siamese.dyndns.org> <a706eaa1e1cd5e13a8cd98362fe09bba628789d1.1331296220.git.stefano.lattarini@gmail.com> <7vaa3p5zht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 22:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S67eN-0001oR-9L
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 22:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339Ab2CIVqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 16:46:42 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:48437 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758552Ab2CIVql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 16:46:41 -0500
Received: by wejx9 with SMTP id x9so1438716wej.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=EvEPojNaHcCbiSsUZczaPJwM1z+aSuhc3x4RwOwPgNQ=;
        b=HKK4uH0cRtuOsfWiSgsq7kz28pLawbAfNWnoajUgLi08xZSur8l7pNtNFAYjocYYMW
         6W5k9JlfIZlRi84eePB4Z6wt6/r5T3TbKGaLocdCPzocd4ce8A+wDa3n0FiYzoEFcVLn
         zpFCrrQnneMVKvxH28X7TzVd6GF/GOZNYfw6I/Saz8Gg/bTE1bjSUYNzS4rfb69f/GiM
         XlWOrcTXmqhwsjzNL2GLyYLvKELMRq2LpVB6y5ONCZqKhe90oaGOMKvpuJlh+VemBuvc
         oeQAQB+7+KMnhjfpNM1nnrRbmpEjPapvw6XeM6jNk/rBcOxfNveyNwoeR5ZDqYB6jbAr
         iuOg==
Received: by 10.180.24.7 with SMTP id q7mr8393818wif.11.1331329599789;
        Fri, 09 Mar 2012 13:46:39 -0800 (PST)
Received: from [87.0.103.201] (host201-103-dynamic.0-87-r.retail.telecomitalia.it. [87.0.103.201])
        by mx.google.com with ESMTPS id k6sm8439517wiy.7.2012.03.09.13.46.37
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 13:46:38 -0800 (PST)
In-Reply-To: <7vaa3p5zht.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192742>

On 03/09/2012 08:46 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> This change implements the second approach, which is less-ambitious but
>> also much less fragile.
> 
> I personally think your second one is the only sane option.
> 
>> ---
> 
> You forgot to sign-off the patch, perhaps?
>
Indeed (but I've now fixed my git aliases to avoid similar issues in
the future).  Will you fix the issue locally, or should I re-roll?

Thanks, and sorry for the noise,
  Stefano
