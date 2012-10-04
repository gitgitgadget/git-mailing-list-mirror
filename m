From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Thu, 4 Oct 2012 16:59:20 -0700
Message-ID: <CAGAhT3kihpANJ2h=MQ+mpD2ZsZzpbfxDKPRvrdOsEpz53w556g@mail.gmail.com>
References: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com>
	<506CB3B5.808@gmail.com>
	<CAGAhT3mVn-W5P-n_YeafZ_7bntkJGArJ3o6+dA5GO_H44=KHFg@mail.gmail.com>
	<506DA7AE.50005@gmail.com>
	<CAGAhT3k=T0SGngMQkbXHqNfh-=LUb71C7CSrWXP2wsAgc8Tb8A@mail.gmail.com>
	<506E1327.1070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 02:10:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJvKE-0004vU-VL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 01:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab2JDX7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 19:59:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60863 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab2JDX7U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 19:59:20 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1124162obb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 16:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0tRpyiz0w0wzylOWyHxNPU8ziE/K+2D375uQOL7pinc=;
        b=Sd2iLol351FzmiSrellMNMVeEBV8ER/3HUC/iMuxzrm+RzPBJavYcKxgck3f0MfEA+
         2+0zDSzJyA2mjxIz0rHPX9YS7USy3upocvmI6S4Z0C+Td1XrgDAvXFNedF4hyU9zy2+D
         B9l+Jk5HyVHC0tYztxdKw9ePV1DR5BQM4gZTj80KOAhaiQizZwgUfOWzDw2b7crPxo59
         YF3xzuXYbD9OUY9pHC9Hr+SJ1KjKmaJRgqFJcC+axZR+TH+iwS5m0u8X/EppbzPJK7Cs
         +KPgZIahemUDfhxH0FJYjuVzomAPM3UjieEdq5YLHKTq/vy7tEFxlL7BO99MGkiYL+XL
         4EDg==
Received: by 10.182.31.13 with SMTP id w13mr5860831obh.29.1349395160236; Thu,
 04 Oct 2012 16:59:20 -0700 (PDT)
Received: by 10.182.86.164 with HTTP; Thu, 4 Oct 2012 16:59:20 -0700 (PDT)
In-Reply-To: <506E1327.1070602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207056>

Thanks, Andrew!
I'm looking forward for the patch.

On Thu, Oct 4, 2012 at 3:52 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> On 10/04/2012 05:09 PM, Alexander Kostikov wrote:
>>
>> Full script is uploaded to
>> https://dl.dropbox.com/u/10828740/rebase.log  Here is the last page:
>
> Judging from that log, I'm pretty sure "rebase" is failing at
> "format-patch". I was able to reproduce the issue you're having: "rebase"
> finished and modified the branch even though it actually failed.
>
> "rebase" is not catching that error. I'll try to come up with a patch to fix
> it later tonight, so that "rebase" will fail correctly. And when it does,
> you'll be able to do "rebase --abort" to go back to your original state.
>



-- 
Alexander Kostikov
