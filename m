From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 2/2] receive-pack: hint that the user can stop
Date: Fri, 7 Feb 2014 20:05:40 +0700
Message-ID: <CACsJy8CksVA609ksj5BkiOmAzOJ0aoKnHrZfeUSAKzxNy2qO7w@mail.gmail.com>
References: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
 <1391496765-29564-1-git-send-email-pclouds@gmail.com> <1391496765-29564-2-git-send-email-pclouds@gmail.com>
 <xmqqha8eag6c.fsf@gitster.dls.corp.google.com> <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
 <loom.20140207T133319-524@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 14:06:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBl8Q-00057q-KA
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 14:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbaBGNGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 08:06:18 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:48771 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbaBGNGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 08:06:12 -0500
Received: by mail-qa0-f45.google.com with SMTP id ii20so5114199qab.32
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 05:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FoyTLRx/bDeABh6PFAYlP9jqu9AW9GsL2O80bnTK8S4=;
        b=ebwpnnAMpqmAigaBoPuZXfGjvuo9VtPp8tCGi3zumhXyVryNNT+drCf/Z+FXV9MW80
         aYT8HXmVHx77FTOBAqp5P5f1FoCRoPOZ6/czdFJrO6RF0eGE5feGqqzPW5T/S09hhWd+
         4BwUFlA2OFy0Aj5MDPVXaIVf1G2ZMyqFOtHOzx4E1U/kJ2sG9kCBTWoNGbkSfALJ3gqu
         M1II625ZieGlP248FiVA7Gqo1WyZA5y6fokWgQdC98jkPmnjAZZ2IVeM8cGEJ9fWkFcc
         /aHEVVhNs9MyhQdjAG/aHKYMNN+Xhva03M24DmBg3tEp0kjlUGT6sTykhSQveDC9mumH
         y8nw==
X-Received: by 10.224.167.84 with SMTP id p20mr22023261qay.24.1391778371590;
 Fri, 07 Feb 2014 05:06:11 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 7 Feb 2014 05:05:40 -0800 (PST)
In-Reply-To: <loom.20140207T133319-524@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241771>

On Fri, Feb 7, 2014 at 7:36 PM, chris <jugg@hotmail.com> wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
>> Instead of adding a boolean --break-ok that is hidden, why not
>> adding an exposed boolean --daemonize, and let auto-gc run in the
>> background?  With the recent "do not let more than one gc run at the
>> same time", that should give a lot more pleasant end user
>> experience, no?
>
> That sounds quite useful to me.  Duy, are you up for generating such a patch?

It would not be so hard for that patch. I'm still thinking whether it
should be done if auto-gc is started on the client side too (sometimes
it does, which is equally annoying)..
-- 
Duy
