From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 22:22:43 +0100
Message-ID: <cb7bb73a0903251422u5e57065l80a6b8449c79fcfd@mail.gmail.com>
References: <49CA7428.70400@obry.net>
	 <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org>
	 <8c9a060903251133x33749041oc2a5152097da0ae8@mail.gmail.com>
	 <gqe1kf$pg1$1@ger.gmane.org>
	 <fabb9a1e0903251340x637a21dav6e304aa6d2825958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmaa9-0000Tc-V0
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbZCYVWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbZCYVWr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:22:47 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:34069 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZCYVWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:22:46 -0400
Received: by ey-out-2122.google.com with SMTP id 4so73523eyf.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2ZEf3mk1WPsEoCEvu4OaqIHkgHR2R2sOGtFVKTKdMq0=;
        b=rBoyszZm8lAuvGxyiVxt/8e3g8eY6NsQwA7X1cRnW29R4mKBeC6BbcZBbx0nCofAYA
         DqMwVUqm+gcb9kGAHJq/OleSkm0vbSbv7Tw3zA/wkeKOx+3wVhn+K8tYuPoLyMCBsXwN
         le2Q0SC4loTRj55MpyRMiN1+gdFI9Q3F81RRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xwDMdv0m5NY+JQci7G+LK08VTR3M3xwN/w7ZCg3BlBtwxWZb8RRkZ4tXSPEPAHGNzr
         RpgHWgMCPne0yd0nzO/rkf92WlwMqWUr11n4klfObeZo9MSHlwKe5oEpgU5HmB9lIDv8
         KWeVm1pjH5w75ex3GCJtgLlpmihUEw/6tntXE=
Received: by 10.210.34.5 with SMTP id h5mr23548ebh.59.1238016163814; Wed, 25 
	Mar 2009 14:22:43 -0700 (PDT)
In-Reply-To: <fabb9a1e0903251340x637a21dav6e304aa6d2825958@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114665>

On Wed, Mar 25, 2009 at 9:40 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Wed, Mar 25, 2009 at 20:45, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> I wish there was a way to tell rebase -i to go back to the first commit,
>> inclusive, but the two or three times I've tried hacking at it I never
>> managed to come to anything useful 8-/
>
> Wasn't --root added to rebase -i recently?

>From reading the manpage I assumed it could only be used to put the
stuff on top of something else (the --onto requirement). Or did I miss
something along the way?


-- 
Giuseppe "Oblomov" Bilotta
