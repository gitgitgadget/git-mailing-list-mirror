From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH UI experiment] diffstat: annotate/highlight new or removed files
Date: Tue, 16 Oct 2012 18:15:01 +0700
Message-ID: <CACsJy8AWqZ7xuFD0=Um=2JX3E6y=mx4xEfXi75OimWxXaJ=tJw@mail.gmail.com>
References: <1350311749-15447-1-git-send-email-pclouds@gmail.com> <7v626bwir8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO57g-00022m-U4
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab2JPLPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:15:33 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35812 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2JPLPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 07:15:32 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so6027821oag.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2Eq9q/Xhqke/L9her2FSPCQo6pepTIoR9Oeu+FwJuV8=;
        b=OQ60HSaT66Ww3z19fIDvL/mvzsdMbQjUnJyHYu/ieBpYmkJoVZOsVR9E33bYC3CKfw
         83xSrIEKA3qfQ3wSNx908F+KOUyLETQr8gno/a4lEdTll2jEzFrIzhz9BAI5pa4jML/u
         gukRht7hMo33bUbI58wa0U2nO0TAVYi/9uK4DgNont5kU4yokEioFnA6hwHEr0t/rgs3
         rfRySlpZV3/NFaZX35yCSBK9bqRB3pbK42rss5eRciVCWNU65cD8H1JIIkyL2WUKlTGl
         iQFMih4OEVzbv5OWMde+VOLcY7i5NAhoAX7xH/SQX3RCVBEV+6r/s73eTb316O8HA019
         EHiw==
Received: by 10.60.26.230 with SMTP id o6mr11783684oeg.109.1350386132027; Tue,
 16 Oct 2012 04:15:32 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Tue, 16 Oct 2012 04:15:01 -0700 (PDT)
In-Reply-To: <7v626bwir8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207813>

On Tue, Oct 16, 2012 at 4:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Coloring is to me an improvement over --summary. Probably the main
>> point. Without it, perhaps it's not worth putting extra text to
>> diffstat.
>
> It is kind of surprising that you did not choose to paint new in
> green and gone in red, and rather paint everything in yellow.

The colors of line addition and deletion? Nice. I just wanted to make
sure these stand out, or at least not easily mistaken as part of path
names.

> I personally think the above in monochrome is fairly easy to read;
> with coloring, it might become too distracting, though.

Hmm.. maybe. I'm probably too excited to see the distraction just yet.
I will try it out for longer time, see if I change my mind.

> Just a nit, "new mode" is too similar to "new".  Everything is "new"
> in the sense that they have "new contents"; it may be better phrased
> without saying "new" but giving a stress on "changed".

I think "new mode" should be replaced by the actual mode change (e.g.
"+x", "-x", or "mode +x", "mode -x"). Not too long and quite clear
what it does.
-- 
Duy
