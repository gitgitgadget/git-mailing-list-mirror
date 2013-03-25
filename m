From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Tue, 26 Mar 2013 00:36:46 +0530
Message-ID: <CALkWK0nFVOhTjY3dfcwPvjqLZgJrENo6Ha=cv-x6io_Np8FfoA@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org> <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
 <20130325182023.GA1414@google.com> <CALkWK0kx_uQy-97nByNXBOU4UruhvdjOeXCpKHR9mNUQHs5o=A@mail.gmail.com>
 <7vppynxre7.fsf@alter.siamese.dyndns.org> <CALkWK0kOHPrid3V5tPWBaf5eh1t7tM_oXqsQFnXugBKUGKGpUA@mail.gmail.com>
 <20130325185032.GB1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 20:07:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKCk6-0006Al-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 20:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436Ab3CYTHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 15:07:08 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:49042 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758376Ab3CYTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 15:07:07 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so5848294iag.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+kAeCrx18P5W0sR0QUqhut5mquKGk15oMRFd6T5byF4=;
        b=DfJDWU9w+aZhjvnenZ8IyH1oYlP0riollmPc1omZGo4O+s1PRI/PQiQ1xJxRTPKYbL
         IkOM+6n7xkFqKxz8+v273Hr/QdqzPqW4RLOnsU8XpuCrCKuSAg5rql9MbvPM12vl9S3+
         jgnoZiMDFrSooNW6OuDiSOQjXXmkCjZ5S5KdNwpxZkKhAhvlPMRNYT7cOGUt/GAO49W9
         o9fTt+WTAEsd//WEk2Av4cTk5yNrRLYqNUCXVi2G4xGMaJV6c7F3vHPbAeOfaCBR+q+P
         frrfe3/Rpt8fcYzCLG81MwGhkHzCFZ2rQV0ggH+M+ttHHBNAOuKTvwSzPyeXXzeG+dQe
         Tz3A==
X-Received: by 10.50.17.166 with SMTP id p6mr12236777igd.12.1364238426688;
 Mon, 25 Mar 2013 12:07:06 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 12:06:46 -0700 (PDT)
In-Reply-To: <20130325185032.GB1414@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219066>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> Okay, I'm confused: why are you waiting for 2.0 to change push.default
>> then?  Isn't that just a "slightly better default at the porcelain
>> level" and hence a "regular enhancement"?
>
> No.  Among other aspects, "git push" is used heavily by scripts.

Oh, I see.  I would've expected scripts to specify the refspec
explicitly, instead of relying on a default like this.  Then again, I
saw jc/push-2.0-default-to-simple -- massive changes to scripts in our
own testsuite.

This whole "backward compatibility" thing is not black-or-white: it's
shades of gray.  Can I ask about how "backward incompatible" the other
suggestions I listed were, just so I get a rough idea of your scale?
Junio seems to be very extremist today.
