From: Chico Sokol <chico.sokol@gmail.com>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 19:33:57 -0300
Message-ID: <CABx5MBQd8Q-NMdFb4p9hk91mpf4FgbTGc3E0oh1tHMfptZSyUQ@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com> <7vzjvokm7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 00:34:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uev8Q-000882-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 00:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab3EUWeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 18:34:18 -0400
Received: from mail-vb0-f42.google.com ([209.85.212.42]:53513 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab3EUWeS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 18:34:18 -0400
Received: by mail-vb0-f42.google.com with SMTP id w15so454735vbf.15
        for <git@vger.kernel.org>; Tue, 21 May 2013 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ExKBIlqt5wD6XxcFAqblII+TqGYKp4tLmediXi+evzk=;
        b=Eo4AgBqD2Kd4MwaeaDCwwO0nT6avl/6D7g+p38cvgeS9aDTIqpNfoI0sG9mFebRCJR
         Lqj/7r6vjD1lfI5H9QQCydiy+t3cWioSwRml2hik1PF+RMDHKYJOZd4QXy3fC4zzvzur
         xHTY0S0POY8yhbVphyU4pp/cozJXutyeqDSFBbEVdX4lRBa9mPiPmUKs/iYSFWtf8FA7
         vUf9Dy+CGvAzyT/lalvIZUwlgg//JDvAbht5bCcFuvoZouzf3qTFwvj8CgYVRd+Iifpy
         KoPJ3OE3ENQb2qh9dRfjBbculEDv5NabBxja4RZVxBqQLU3NDunGUJX4CQPDuy5j3Aih
         xvIQ==
X-Received: by 10.58.225.228 with SMTP id rn4mr1770284vec.35.1369175657416;
 Tue, 21 May 2013 15:34:17 -0700 (PDT)
Received: by 10.220.80.10 with HTTP; Tue, 21 May 2013 15:33:57 -0700 (PDT)
In-Reply-To: <7vzjvokm7f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225088>

It was git who created that object.

We're trying to build a improved java library focused in our needs
(jgit has a really confusing api focused in solving egit needs). But
we're about to get into their code to discover how to decompress git
objects.


--
Chico Sokol


On Tue, May 21, 2013 at 7:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Chico Sokol <chico.sokol@gmail.com> writes:
>
>> Ok, we discovered that the commit object actually contains the tree
>> object's sha1, by reading its contents with python zlib library.
>>
>> So the bug must be with our java code (we're building a java lib).
>
> Why aren't you using jgit?
