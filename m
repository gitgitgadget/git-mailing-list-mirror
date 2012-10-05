From: demerphq <demerphq@gmail.com>
Subject: Re: Ignore on commit
Date: Fri, 5 Oct 2012 03:35:14 +0200
Message-ID: <CANgJU+XSYWObCsGVnWwaaSB9iZQnfU_y095uzEm5-YXMaUoU_w@mail.gmail.com>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
	<506DEC50.7090402@obry.net>
	<CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
	<CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marco Craveiro <marco.craveiro@gmail.com>, pascal@obry.net,
	git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 03:35:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJwp5-0007L9-QU
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 03:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab2JEBfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 21:35:16 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37547 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab2JEBfP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 21:35:15 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2557120iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 18:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mL9pnXhira1mbAr058+mqNUWjnzDkx/O/12qPEpvNOQ=;
        b=IjWxD5zb0fci/OsTln98fIugXw4XKyOg7nzhyfjA/Avje5AFeJk0Fk4BcKDOxVnToM
         Rbxl2p4NGYVIRY//RmoX2fRuSwQOrvdaWBmx754Yurp/R7CtZjNbjg3QL0xkAvF06Avj
         HQBOLOKrby/Ho1wFnYiDmJ1TdYo6NHXLiw3RDtoZsX1CWa3MMOQxjEPNzsNK2a+knw65
         QNrYs2IvgpOi0ljufr5yV1i1qgIaChgmZswJpoYI/j2kLKf6Fs8fkGaPqDLedV1BqjbX
         fJE4S/vh8Zpy4rwaWQsqevpT2ODkeZrktuK14XR8JV2y3sSk4Oc3+PEG/FPWyXKvLNBJ
         7uUA==
Received: by 10.50.53.170 with SMTP id c10mr7312294igp.45.1349400914491; Thu,
 04 Oct 2012 18:35:14 -0700 (PDT)
Received: by 10.64.86.36 with HTTP; Thu, 4 Oct 2012 18:35:14 -0700 (PDT)
In-Reply-To: <CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207063>

On 5 October 2012 03:00, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 5 October 2012 07:20, Marco Craveiro <marco.craveiro@gmail.com> wrote:
>> ...
>> Similar but not quite; the idea is that you know that there is some
>> code (I'm just talking about files here, so lets ignore hunks for the
>> moment) which is normally checked in but for a period of time you want
>> it ignored. So you don't want it git ignored but at the same time you
>> don't want to see these files in the list of modified files.
>
> What is the reason git ignore is no good in this case? Is it simply
> that you can't see the ignored files in git status, or is it that
> adding and removing entries to .gitignore is too cumbersome? If it's
> the latter you could probably put together a simple shell wrapper to
> automate the task, as otherwise it seems like git ignore does what you
> need.

Git ignore doesn't ignore tracked files.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
