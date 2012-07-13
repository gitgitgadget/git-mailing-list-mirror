From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: Mini bug report origin/pu: t1512 failed on Mac OS X (commit 957d74062c1f0e
 ?)
Date: Sat, 14 Jul 2012 00:43:15 +0200
Message-ID: <5000A483.4090307@gmail.com>
References: <4FFDDD5E.3080309@web.de> <7vipdtdhla.fsf@alter.siamese.dyndns.org> <7va9z5dgff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 00:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spohx-0006nb-7o
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 00:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab2GMWva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 18:51:30 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42469 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab2GMWv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 18:51:29 -0400
Received: by wibhr14 with SMTP id hr14so1060555wib.1
        for <git@vger.kernel.org>; Fri, 13 Jul 2012 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=vMSljNWH2Y+okOIoQOeJpTC/9O0ktTY9PVXBx1KG7Ps=;
        b=enuH24YrOaRsVLl+cd1HZF6BxaBmtYh8pxalbCW2w9e8SOD/wGte5q42Y7o098sPqh
         QiRbqA+DCOu1J/wrTJn8CPSU5hEEU42p6X+qlU8256Z2cKmNX7WUX2xF9N3DD8r1mQGj
         nvcqb4GmtLKGv41ICnD3WzzS6nO8DcUKZdOLqyMTKNZFOVcfWlNN3go2gns16k/H/0C2
         GwHqVjxwQ7TEgXvqF5zIK9w887JSAKz1Cv4KR+d/Bkyh5NXfvn7erAWJS7cag9CyMW3z
         pTFtlDRr+wIOxxIhSCmCV4V4pJMuhh8brr44+9rkL/K2qmN/4vM/WEtlqFSNFZLFSDPe
         j7AA==
Received: by 10.180.106.137 with SMTP id gu9mr999545wib.20.1342219398656;
        Fri, 13 Jul 2012 15:43:18 -0700 (PDT)
Received: from [87.2.92.212] (host212-92-dynamic.2-87-r.retail.telecomitalia.it. [87.2.92.212])
        by mx.google.com with ESMTPS id el6sm5878886wib.8.2012.07.13.15.43.16
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 15:43:17 -0700 (PDT)
In-Reply-To: <7va9z5dgff.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201427>

On 07/12/2012 01:30 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I think the other tests in t/ prefer to unquote it so that we would
>> ignore spaces around "wc -l" output, i.e.
>>
>> 	test $(wc -l <actual) = 16
>>
>> Thanks for a report.
> 
> -- >8 --
> Subject: [PATCH] t1512: ignore whitespaces in wc -l output
> 
> Some implementations of sed (e.g. MacOS X)
>
'sed'?  Shouldn't this read 'wc'?

> have whitespaces in the output of "wc -l" that reads from the standard
> input.
>
FYI, the extra space is present with Solaris wc as well:

$ wc -l </dev/null
       0

Regards,
  Stefano
