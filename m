From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Checkout first version of each file?
Date: Tue, 8 Nov 2011 11:17:27 -0300
Message-ID: <CABLeVKFkSP=2-kwsN4N+oLrPnijkpvV8Ki=Si4dpYXdzc+8ibQ@mail.gmail.com>
References: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
 <20111108140243.GA4866@kolya>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 15:18:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNmV1-0005Dk-6u
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 15:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471Ab1KHORw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 09:17:52 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54614 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544Ab1KHORt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 09:17:49 -0500
Received: by mail-qy0-f181.google.com with SMTP id 2so561296qyk.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HzBsS9r+ZZS9Sg+fQkhvmboJraHSjXxmdSF8EFh6gzY=;
        b=GJiq4ekey/swEdPg8NaXK1IGL+Q2H41r0djosXF3F0HFsUDVEIX9gs/auzk0LmYbwi
         RyP2i+bkVs+d4yl7cXpSFoQ2cKoNl+mMedsWT1aKLQ+8gCHu4t8aM69uzJoe3jCZa2/N
         9M+WKJzu+C+3PNI7cY7AFsZHE2xlU4sWfRMVA=
Received: by 10.68.9.2 with SMTP id v2mr1006288pba.101.1320761868098; Tue, 08
 Nov 2011 06:17:48 -0800 (PST)
Received: by 10.142.253.7 with HTTP; Tue, 8 Nov 2011 06:17:27 -0800 (PST)
In-Reply-To: <20111108140243.GA4866@kolya>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185087>

On Tue, Nov 8, 2011 at 11:02 AM, Fredrik Gustafsson <iveqy@iveqy.com> w=
rote:
> On Tue, Nov 08, 2011 at 10:58:05AM -0300, Dario Rodriguez wrote:
>> Hello,
>>
>> My "issue" comes with my usage of git at work. I work with lots of
>> applications, each of them part of each system. There are lots of
>> processes and lots of subsystems, so I never clone the entire repo
>> into GIT, since it could be painful and slow. Even if I do so,
>> everyone else is using ClearCase, and their changes cannot be includ=
ed
>> into my git repo until they "chickin". Sometimes, I must update
>> sources from FTP because the changes are not up to date in
>> ClearCase...
>>
>> So, I clone every file that I will need to work into GIT, so i can
>> work with these files having a better control (With ClearCase it's a
>> foolish "checkout>>lots of changes>>checkin" flow). But sometimes I
>> don't know how many files I am going to change until I start coding
>> the requisites.
>>
>> In this cases, there is a situation that I don't know how to handle.
>> If I need to rollback every change made to every file I cannot just
>> checkout the initial commit, cause I've added files after that, and =
I
>> need their initial versions too.
>>
>> So, how can I checkout the first version of each file? (I know that
>> GIT tracks contents and not files, but the fact is that I need to ke=
ep
>> track on files, it's the real thing I work with)
>>
>> pd: Sorry about my Argentinian-English (if it sounds so)
>>
>> Thanks,
>> Dario
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> Is all files present in your latest commit? Or can there be deleted
> files that you also need to recover?
>
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
> E-post: iveqy@iveqy.com
> Tel. nr.: 0733 60 82 74
>

Every file in the latest working tree is also a tracked file. The
files are being added to the git repo, but not removed from it.

In other words, the biggest set of files is the latest working tree,
and the smallest one is the first commit.

Dario
