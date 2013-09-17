From: Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 11:03:45 +0200
Message-ID: <CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
References: <5236FBEA.80909@gmx.de>
	<CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
	<vpqvc1z6eoo.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 11:04:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLrCR-0001S5-5M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 11:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab3IQJDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 05:03:46 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:49771 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab3IQJDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 05:03:45 -0400
Received: by mail-vc0-f181.google.com with SMTP id hz10so3691315vcb.40
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LGzh194KuZUBgwJnIekwOw2RvB+g35Y1WogNy8D/6vk=;
        b=VNxZKzbTdeTdoj72RhecpwntDainKM2ro9n7huZfilK9wZPf99jzOvAIB+hf1R1xZw
         vEl3MKm4f1ZMzpRjomanm3gN2T43pFRm2xeH0wahqUzUG1xIccB7waAKOyinLr0tQYtk
         RtKxrsiGE1kNcAXmb9GiBQfEWpL71Ovz4mVA6l3KmnlY5gr+AbFNHffb8DOahyJWZMqg
         +szOdDLF8h/RsyH0z5B8pCPJuAMuNgY5VDbrgG/6hhqD2nP5LTzbJsCJGz1HBDDsBup5
         Phm/Iyz1mk1Qn39hK3DjO8UteKcv8BRfBQXKgVYFz1L3L/OXHkfMI/8x/ke2heqGMivS
         8tdQ==
X-Received: by 10.59.9.138 with SMTP id ds10mr10208719ved.5.1379408625080;
 Tue, 17 Sep 2013 02:03:45 -0700 (PDT)
Received: by 10.58.240.102 with HTTP; Tue, 17 Sep 2013 02:03:45 -0700 (PDT)
In-Reply-To: <vpqvc1z6eoo.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234865>

On Tue, Sep 17, 2013 at 10:21 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> In practice though, as git bisect is a kind of binary search, if what
>> you want to exclude is exclusively touched by half the commits, it
>> will only add one more bisection step if you don't exclude it.
>
> Actually, I think the same remark would apply to any other Git command
> that deal with a set of revisions. If you want to review code with "git
> log -p", but you don't care about a subdirectory, you may want a "git
> log -p --ignore-dir foo/" or so, too.

Yeah, and there was a patch series about that 2 years ago:

http://thread.gmane.org/gmane.comp.version-control.git/182830/

> And then, the "it's logarithmic" argument doesn't work anymore ;-).

Sure.

Best regards,
Christian.
