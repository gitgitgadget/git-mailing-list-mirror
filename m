From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Tue, 26 Mar 2013 00:18:53 +0530
Message-ID: <CALkWK0kOHPrid3V5tPWBaf5eh1t7tM_oXqsQFnXugBKUGKGpUA@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org> <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
 <20130325182023.GA1414@google.com> <CALkWK0kx_uQy-97nByNXBOU4UruhvdjOeXCpKHR9mNUQHs5o=A@mail.gmail.com>
 <7vppynxre7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKCSj-00040C-QU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771Ab3CYStO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:49:14 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:49883 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757687Ab3CYStN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:49:13 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so5808501iac.33
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8KzObCFAl0dzKDV4mf9kY2bhyoARfITC8l00eMIVaqs=;
        b=Wi5upSYPGnOxhwC46jtkVmoqCmwiRTzZ8NTfoyN0slqGqc44bxkinqDMcr0CMSyzEU
         l8cSwj2Kxy1Y5dofpn3Ih+ZlJnbLW/GBiLOuUwIvJ/tv2qYmKcPCCsz2QH97CJYKgFQK
         cdqLqfkzWZoESm9VWqOpBypAfy0+kEs3XjhZEytywWTOTY884GVxSkHEAdqmmjwjW00T
         zDSj9P7rnmesf06onfsSqLMtUHsUHpHFipT/krznN34Ly5YVxHENfesNDB/GgbkQLVSf
         Hft71YPhUhprcK9HIEtUBSN38Rh5LPJN4QYN611oVYqKT2g0vBVlzZmDwmvubp9c4fFu
         ypxQ==
X-Received: by 10.50.50.71 with SMTP id a7mr12056636igo.14.1364237353172; Mon,
 25 Mar 2013 11:49:13 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 11:48:53 -0700 (PDT)
In-Reply-To: <7vppynxre7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219064>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> I'm talking about slightly better defaults at the porcelain level,
>> at most.
>
> If a change does not even have to break backward compatibilty, that
> is a regular enhancement and independent from 2.0, no?

Okay, I'm confused: why are you waiting for 2.0 to change push.default
then?  Isn't that just a "slightly better default at the porcelain
level" and hence a "regular enhancement"?

You're not worried about breaking everyone's muscle memory (is that
not part of backward compatibility)?  So, if I understand correctly, I
can do changes like the following at any time (provided the reviewers
agree that they're sane):
1. Don't make 'git submodule add' stage (which is what this thread was
originally about).
2. Set pull.autostash to true (I still have to re-roll and finish it ofcourse).
3. Set color.ui to auto.
4. Alias 'git status' to 'git status -sb'.
5. Set help.autocorrect to 20.
