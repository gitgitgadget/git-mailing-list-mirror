From: Stefan Beller <sbeller@google.com>
Subject: Re: Allow git alias to override existing Git commands
Date: Wed, 11 Nov 2015 09:42:52 -0800
Message-ID: <CAGZ79kZcgHknvZ03+T++1o3d2_YMo4+FCNkOMuG13qsHJp8V0Q@mail.gmail.com>
References: <56421BD9.5060501@game-point.net>
	<CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
	<56424DDE.2030808@game-point.net>
	<5642C8BA.8030003@gmail.com>
	<56430A27.2030604@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwZQA-0001LF-Lm
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 18:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbKKRmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 12:42:54 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33642 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbbKKRmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 12:42:53 -0500
Received: by ykdv3 with SMTP id v3so61018890ykd.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XiVpiOY7btNboSW28DEea393kEAf0K00k8hHRjg6/RA=;
        b=K4+vdaBA6QuTp/cIE4HOK/j4JMKe2/IRbusnWNnKY+WG3mi/YzfoFelS9HCwmOdoXf
         5SFyHwvaqEWI8ycc1VWLmFbX2EfRwhd42Q2CtbNR9Sg/0fVBo0oTN+2URtLsi2FkHEXj
         OXSnSWPWNJp4miAoGeblJlqSLEEYm1ZaSCTeqiSFya5ekt5i+Fqbk/pKhqVgv6uUndqq
         z712gCKrmgcecV//TqyT4bcK9YiDYKiLiEZ+WXvvhpPq2onnh2UD0ze7ioXQFGfliBn0
         YnxG1l51nfvdk9RtE/ow8MM8V5o0eYDIkTJ1qdP2ICeDPKsE6CSfokcDs1kXoe0efyWz
         n6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XiVpiOY7btNboSW28DEea393kEAf0K00k8hHRjg6/RA=;
        b=FtGQBEkn4fHvmpOmYdHYGG0q0JISkJJhEFym8yChjbZUirZ/Wqw2q4l6rEMkbnrgvO
         GciwSbcmL/hKkwgwFM4+sMKVaolzHCPWA1w0Dlqr7R+z1Dm714ja3qrdFhwGuXOAe1G+
         ZUN7QUMJJ84O18PygarNwnD19y4UQg4RFj+iPj7thk7rqU2hZ2xpjXx3oMJ44Ca56nNG
         EnNlKb/X4RK9RdMFJY2Z+ft7WhyfRKfQaxQ9ZJmYNaErFT/wRSscA5WwH4llIpJz69tR
         mPHl+iTDCZoNuwy2/KegvqWC7GeMLzTaZHoSdzhW6FQlRKFTwv6GviG8rxcRRMIatCEQ
         I2kg==
X-Gm-Message-State: ALoCoQnDg0be/ZERRVIV6QhU9IHywZGRi2567SNF2T7DYc4hdpsDorDZDB3eN4Vb6+o5bGrQLxC4
X-Received: by 10.129.78.12 with SMTP id c12mr361665ywb.320.1447263772923;
 Wed, 11 Nov 2015 09:42:52 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 09:42:52 -0800 (PST)
In-Reply-To: <56430A27.2030604@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281172>

On Wed, Nov 11, 2015 at 1:28 AM, Jeremy Morton <admin@game-point.net> wrote:
> On 11/11/2015 04:48, Sitaram Chamarty wrote:
>>
>> A lot of things in Unix do follow that "give you rope to hang yourself"
>> philosophy.  I used to (and to *some* extent still do) think like that,
>> but some years of supporting normal users trying to do stuff has taught
>> me it's not always that simple.
>>
>> I can easily see someone blogging some cool way to do something, and a
>> less savvy user uses that in his gitconfig, and gets burned later
>> (possibly much later, enough that he does not easily make the
>> connection!)
>
>
> We're not talking about "normal users" here, that's what Google Chrome is
> for.  We're talking about Git users using the commandline client. They ought
> to know what they're doing and if they don't, they're screwed anyway because
> there are quite a few gotchas with Git.
>

Just because you're an expert, doesn't mean you don't appreciate working without
safety net.

There are tons of people out there, who use Git for $REASONS (their
boss told them so,
it's cooler than $OTHERVCS, the project uses Git), without having the
time to take
a deep dive into Git. "It should just work".

So I haven't tried Sitaram's script, but it looks like it can get your job done?
