From: Joshua Roys <roysjosh@gmail.com>
Subject: Re: How does format-patch determine the filename of the patch?
Date: Thu, 29 Oct 2009 09:14:48 -0400
Message-ID: <4AE99548.5060100@gmail.com>
References: <ed82fe3e0910150917u72ef189epc74411e71a9cd2d4@mail.gmail.com>	 <200910151959.47778.robin.rosenberg.lists@dewire.com> <ed82fe3e0910290605j302747f9o6a86acb414427639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 14:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3UqN-00069Y-6t
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 14:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbZJ2NO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 09:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbZJ2NOz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 09:14:55 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33909 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZJ2NOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 09:14:55 -0400
Received: by yxe17 with SMTP id 17so1626005yxe.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7pDFWF3Kefy7avxwRkk4+WUXZMy6FO67akl+fqwGQJY=;
        b=najtvAK9DUCdPori5RJKmcAm7G8hJ6HUQOA/8VM6KhB4XNOuLwKWXK3DrSRo9KoQhi
         iWsjrtcNtFdITC3eQZ9xmaVX+jjV9GzPnT7KNy5VLjjX9t12NBlraXoyX+T0Mvl5A73m
         LDl87XoR0erl3L/QkJ6s6ip8uf12zn0tTuPk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uv6l8Oo43SOl06woHFINcSqQ9h/YGm2dJ+iCDFN+2/vWfBTxZf2uTmAkIPt6v9vuDg
         8geLj51331oHaThqVx5VenvSVfytt3lSxQi41fuaZL93NHS+eBze1NNT15nNDbwBUTlj
         D1GA7Rjn+Wbhw/XuAMVK/HrdOArvINn+dZVxo=
Received: by 10.101.11.10 with SMTP id o10mr38212ani.91.1256822099598;
        Thu, 29 Oct 2009 06:14:59 -0700 (PDT)
Received: from sis-JRR.stl.gtri.gatech.edu (sis-JRR.stl.gtri.gatech.edu [130.207.197.190])
        by mx.google.com with ESMTPS id 22sm878569yxe.39.2009.10.29.06.14.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 06:14:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <ed82fe3e0910290605j302747f9o6a86acb414427639@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131590>

On 10/29/2009 09:05 AM, Timur Tabi wrote:
> On Thu, Oct 15, 2009 at 12:59 PM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com>  wrote:
>
>>> The reason I ask is that I'm writing a script which calls
>>> git-format-patch to create some patches for post-processing.  So I
>>> need the name of the file that git-format-patch creates so that I can
>>> open it and examine it.  I'd liked to see if there's a way to get the
>>> name of the patch without actually creating the file.
>>
>> It tells you the names on stdout.
>
> Is there a way for it to tell me the name on stdout *without* actually
> creating the patch?
>

Hello,

Is there any way you can just save the names from when you do call 
format-patch?

e.g.
...
my @filenames = qx(git format-patch $opts);
...

Josh
