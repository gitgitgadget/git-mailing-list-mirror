From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 11:58:36 +0100
Message-ID: <BANLkTik-o=h05=d5JH_LirYQkNzgdYaZxg@mail.gmail.com>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
	<20110602103833.GA4709@Imperial-SSD-Overlord>
	<BANLkTin92KXYO3YF1UytcesWUV-Nh_LaGg@mail.gmail.com>
	<20110602105223.GB4709@Imperial-SSD-Overlord>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tim Guirgies <lt.infiltrator@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 12:58:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5bu-0004RH-OB
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 12:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008Ab1FBK6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 06:58:38 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53587 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933334Ab1FBK6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 06:58:37 -0400
Received: by gwaa18 with SMTP id a18so273547gwa.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=B8vcesvK+YQdWCpFobA81YTfzLMC/REkTKpSGmZ9j8k=;
        b=taKqieKKhfFF7zSFrFK7+VJM2kLzLM7/4zkAHvwPX+U5Zzm6a2Zb436lTkzaph+9eV
         yrTdAO5svvFuF52gvNZg8+NDbFR0NYtqY68ujAObK75GourR89YzSgK0/Bo7cNPF2p09
         5DGOst35uSDRQF9zVuKCJpNxXeAW6SQho7uvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=LxSAmDXUOxnyQrMhnro2++5Sp93Tl8KHb6Njb1ewYPlazXszS0Zbc7gOzNiDYdPKat
         t1Qio4JIvhi+Tj9c28HQl5FhoTihI3tAJ3lT5z7wT2aP2aA3eYPKDiTKooEUmWX9EATi
         x0BWodRhnmccsUuYkYMG0yA0m7X1jZkW3Dyww=
Received: by 10.91.203.37 with SMTP id f37mr537303agq.57.1307012316385; Thu,
 02 Jun 2011 03:58:36 -0700 (PDT)
Received: by 10.90.116.15 with HTTP; Thu, 2 Jun 2011 03:58:36 -0700 (PDT)
In-Reply-To: <20110602105223.GB4709@Imperial-SSD-Overlord>
X-Google-Sender-Auth: kRXyNec1IMg4rnUepdUiEtqjO80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174941>

On 2 June 2011 11:52, Tim Guirgies <lt.infiltrator@gmail.com> wrote:
> On Thu, Jun 02, 2011 at 11:43:19AM +0100, Howard Miller wrote:
>> Hi Tim,
>>
>> Thanks for the lengthy post :) As I said in my previous post, I
>> think/hope I have resolved it. I did read the manpage first (I'm not
>> so brave not to before posting here!!) and it did what it said it
>> would. I just misinterpreted it. A final merge was required. I
>> actually picked that up from the "Pro Git" book page which mentions
>> that extra step.
>
> Well, I'm confused, but that'll be due to my ignorance.

I very much doubt it :) It'll be me failing to explain properly.

>
>
> As for the manpage, though, as someone who read and misunderstood it, do
> you have any suggestions for its improvements?
>

The examples are very helpful but it could be a little more explicit
which branches are going to get modified by the rebase. Once there are
several branches in play it becomes quite a hard think.

Mostly, I just needed a kick to say "look where the branch heads are
pointing" (in the example diagrams) before and after the rebase. I
don't think I would have got it without the remark in Pro Git that a
final merge is required to get the HEADs where I wanted them. Like
most things - it's completely obvious when you know.
