From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-helpers: remove --graph in hg_log()
Date: Sat, 6 Apr 2013 18:12:02 +0200
Message-ID: <CALWbr2yhZW46RB=8gUivcN4r5NFhk0y-0ND-X2c8ALKos6qi=Q@mail.gmail.com>
References: <1365264055-30507-1-git-send-email-apelisse@gmail.com>
	<CAMP44s2tdKhGuH3E7nGqU4R3jgEw4tH-=Cq6dhHwiLc=b_fm6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:57:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWWv-0001D7-Fn
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423255Ab3DFQMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 12:12:05 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:52331 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423239Ab3DFQME (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 12:12:04 -0400
Received: by mail-qc0-f178.google.com with SMTP id d10so1986660qca.23
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EVgY5+1DaftMo/mfN7/1OV+H694X0Yl4KR607JSnFz4=;
        b=qplexI4wkKoCQ78gJKGPIyMCQRzUXq+UNz9lWxi5s7EUIghrtvdVsnbgJZlW7CR9CL
         p6yu3tAem6RIDjeiF/vIHFCvW3zHFMNIvHUQoBwCxP9Ehjcmpv3Tw+qxmpz2sqeOvg8f
         i54C7nOjEXlslb8StRG6/z3HV4MLfW8Tdv5Pq3bGuLy/ZqVJVYMMQRI1MhpRKUjK0RdE
         HwZAbLhe1uxGJMd4CLxIq7BTewDgH3CBu3DRFkvWFdAc3/N1OkLo5PXY+MCVtE2EUabH
         w3V/JduHqTcsWbMGbSkT2gvEDX7LtM6KCplhJFBx7XYmW+0vfNBSqNSN/b0523n8TsWt
         21oQ==
X-Received: by 10.49.61.226 with SMTP id t2mr14059594qer.40.1365264722725;
 Sat, 06 Apr 2013 09:12:02 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sat, 6 Apr 2013 09:12:02 -0700 (PDT)
In-Reply-To: <CAMP44s2tdKhGuH3E7nGqU4R3jgEw4tH-=Cq6dhHwiLc=b_fm6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220246>

On Sat, Apr 6, 2013 at 6:06 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Apr 6, 2013 at 10:00 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> I'm not so confident that --graph is useless to the test. If it's really
>> necessary, it would be nice either to activate it in setup() or to use
>> it just for the command through: "--config extensions.graphlog=".
>
> I think it should be activated in the setup, it comes packaged with
> mercurial, and it's likely that many users have it enabled.

But is it relevant to the tests ? I have the feeling that it's not
strictly necessary to both add an extension to hgrc and a command line
option. (and indeed, the tests still work for me, but maybe I'm
missing something).
