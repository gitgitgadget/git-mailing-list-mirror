From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 9 May 2014 11:33:16 -0700
Message-ID: <20140509183316.GK9218@google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch>
 <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wipbq-0001Ls-NA
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbaEISdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:33:20 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38779 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbaEISdT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:33:19 -0400
Received: by mail-pd0-f169.google.com with SMTP id z10so3968680pdj.14
        for <git@vger.kernel.org>; Fri, 09 May 2014 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PFZnbSj/KSlTu239xHjHe6yf4E7kG4H9mujGzTf41yc=;
        b=BpxCFO7iJrWrwfwNUDOLHtktpqTyCk/j0DqOwR5JMpNXcyNJonLKAngoyZL73XZHWh
         oWqrowpHG1yi/gnClnUt0OkXMvCd2GE3/lKEfnj0kZGPyFFmA1BQ2z4t6xevYkyLFAlf
         aCuQQcFDxOQoR9FdJT4tNPBjbVjAZn+r5V18lI1PjPNlWggsay8C9TwT9B0y9hyL+6/P
         J75Gxn7dF4lnTP5VW7PR8BcNK2UNj14Ik8w2xNy23s7+VtZTcSRQBnxRWxUxgO4B82vg
         BMPFuGEdt5aUtu/uQkZ9QJ9DC33L5ypwfqxLNYrP9orNkSPw4X6ryN0Rr8E0KetsySTS
         i1Qg==
X-Received: by 10.66.254.3 with SMTP id ae3mr23390695pad.49.1399660399009;
        Fri, 09 May 2014 11:33:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id be7sm11167248pad.9.2014.05.09.11.33.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 May 2014 11:33:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248608>

Hi,

Erik Faye-Lund wrote:
> On Fri, May 9, 2014 at 10:14 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Erik Faye-Lund wrote:

>>> Please don't. This script is useful to build with the MSVC IDE, which
>>> enables us to use their excellent debugger.
>>
>> If you want this script to remain in contrib, please:
>>
>>  a) Write at least a few tests
>>  b) Write some documentation
>>  c) Explain why it cannot live outside the git.git repository like other
>>     tools. [1][2][3]
>
> (Adding Marius, the original author to the CC-list)
>
> Uh, why is such a burden required all of a sudden?

It isn't.  As far as I can tell, the only point of this patch series
was to prove a point.  If a patch from the series happens to be useful
then that's great, but otherwise it's mostly an act of protest as far
as I can tell.

(From my point of view, this kind of protest is not really a good way
to reward people who have made good contributions to contrib/ in the
past, so I hope it doesn't happen often.)

I'm happy the MSVC build scripts are in git.git.  Thanks for keeping
them maintained well.

Sincerely,
Jonathan
