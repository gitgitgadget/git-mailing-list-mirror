From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [RFC] Interactive difftool
Date: Sat, 28 Mar 2009 17:14:56 +0800
Message-ID: <46dff0320903280214i5cddb261sb439f0330a8ec4e1@mail.gmail.com>
References: <46dff0320903260829j34d8c613wf9b4fcc954c8519a@mail.gmail.com>
	 <20090327145122.GA944@gmail.com>
	 <46dff0320903270823v5e8e9c80w506d8a85440588f5@mail.gmail.com>
	 <20090328073253.GA9013@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 28 10:16:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnUeg-0004bt-Qc
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 10:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbZC1JO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbZC1JO7
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 05:14:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:16981 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZC1JO6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 05:14:58 -0400
Received: by wa-out-1112.google.com with SMTP id j5so903085wah.21
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K7dCVVugssXaUcFVBRjhs32PKISe5DggiGk1UKQ5GEU=;
        b=kXS8ytwK2h7ujScVTPmtMdZdKjWfZ1DDeLuAblv4F1ziTIUFEikMBqJaIlN8NXwMNC
         MzzHj3/+tKY/3HXAAek0Psl9G/VaPT+KqdbI4X332ykb6JWPguMXuru8XCvfrEUNMGbA
         sURlVlRhVxiQ66Ecb6i+MArAQjH7RCBFYB4nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vmaBHSvLYuplsQTbFoIaJQePXzCsU3ruBTkmneAhpR5SuCQ1TZxFnE77gaSyu3qIBB
         QMVoQwJXl4r1t71jBgflcEMqOnHUc+CXVLjx29Y1izhbD9rA00pLO6YRI3SLrvv/Q3Sq
         AyYDeCDAWM5wvwx1fVhO0aJVcOBA1hIKaFUd8=
Received: by 10.114.73.6 with SMTP id v6mr2079550waa.48.1238231696724; Sat, 28 
	Mar 2009 02:14:56 -0700 (PDT)
In-Reply-To: <20090328073253.GA9013@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114942>

On Sat, Mar 28, 2009 at 3:32 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 27, 2009 at 11:23:15PM +0800, Ping Yin wrote:
>
>> We can just change git-difftool.perl
>>
>> The easiest way is first parsing the output of git diff --stat,
>> adding the number at the beginning, for example
>> [1] diff.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 10 +++++++++-
>> [2] t/t4020-diff-external.sh | =C2=A0 =C2=A08 ++++++++
>
> I am not paying enough attention to this thread to comment on your
> overall goal, but instead of parsing "--stat", try "--numstat".
>

Thanks, that helps.
