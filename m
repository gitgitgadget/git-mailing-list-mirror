From: Aneurin Price <aneurin.price@gmail.com>
Subject: Re: git stash broken on MS Windows (automatically modify the files again)
Date: Wed, 3 Dec 2014 16:50:14 +0000
Message-ID: <CAHb+SPAw+aeR4RsB6COhq4RMxuXJ64scY-Ez5tZPk3ziEAGm=Q@mail.gmail.com>
References: <CA+4EQ5d70JWiawt5zb9s6Vc3cDMApPmhdB2w+WLyfmWCcTQF4g@mail.gmail.com>
	<CA+4EQ5cfC2N+e6g7wnxDZnnPj3BKTyuMj=TxX90fB7o+_EiOBQ@mail.gmail.com>
	<CA+4EQ5fbDPFuzuz_OAX1Y=zCdL76j3ah0u0BVUW2pPqjaf4kBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Petr Bena <benapetr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwD8G-0000b7-W2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaLCQuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 11:50:16 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:40538 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaLCQuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 11:50:15 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so15785831pdj.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GVDE1GcZFHT0q8XJ2fdF2uJkkjRIrits2SE68oItkOg=;
        b=a8yLGtRkdKp6+3t9sz0PEDDUUzc5FDMR7JsbKT4gDVlujqC02KNw8pfYw1bEe8ieGj
         uHM986QS8arpiEZ1P2zQIZYphfqvl80n97dZOpbeEWHuJEmpxQhXEc270V1tpWpuE1E2
         dAUHZ9Adj/GzDP6NqtfSNqMtH1F2WBmqMqNYMoRZ0ufykgwelu5kQ+2VbsiLxLY6FmVn
         9XJf5u089fosNosQSGYEQ2o7hujsgfTX6lHDRD8mOYskxAwX3OgVBpZZfHJKboTdDOWR
         jYfCRcGVDG/IpbOk2Ivgvl+kGk8frX24U5ENlzVtvo5U+Z1EluL24e6pioo5Wm9gIJju
         lrRg==
X-Received: by 10.68.65.2 with SMTP id t2mr17729702pbs.39.1417625414770; Wed,
 03 Dec 2014 08:50:14 -0800 (PST)
Received: by 10.70.50.198 with HTTP; Wed, 3 Dec 2014 08:50:14 -0800 (PST)
In-Reply-To: <CA+4EQ5fbDPFuzuz_OAX1Y=zCdL76j3ah0u0BVUW2pPqjaf4kBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260660>

On 3 December 2014 at 14:48, Petr Bena <benapetr@gmail.com> wrote:
> Only solution so far was to clone on linux, remove the folder which
> contains these files and push them, then I had to delete the whole
> repository on windows and clone it again.
>
> If I checkout any revision which contains these files repository get
> broken in a way that only solution is deleting it from disk and
> cloning again. Is this a bug?
>

<snip>

>> fatal: Will not add file alias 'BSS/export_home_oracle/scripts_IDAEU001/Audit/au
>> dit_off.sql' ('BSS/export_home_oracle/scripts_IDAEU001/audit/audit_off.sql' alre
>> ady exists in index)
>>

On your Linux machine (and in the repository), do you actually have
both 'BSS/export_home_oracle/scripts_IDAEU001/Audit' and
'BSS/export_home_oracle/scripts_IDAEU001/audit' directories?
