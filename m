From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 00:28:54 -0500
Message-ID: <CAMP44s2ZWA8+ShRDX0uS==THgHPWtoTfXwECFkPXyjSoyXHM=A@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
	<CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
	<CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
	<CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com>
	<20130529234335.GE28153@google.com>
	<CAMP44s3807Dk0SOZcBbaOKTLj5k36bW0SA9F5ZBY2MwS1Nnxiw@mail.gmail.com>
	<20130530052318.GA2923@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 07:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhvQ8-0008Og-9O
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 07:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966945Ab3E3F3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 01:29:00 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:58475 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab3E3F26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 01:28:58 -0400
Received: by mail-we0-f170.google.com with SMTP id u59so6369104wes.15
        for <git@vger.kernel.org>; Wed, 29 May 2013 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MdIWHT7cBsRGYua7tJ+g7TqIwWNsJl/+ctZbrkYb9y4=;
        b=W9sOPgiZPTP1nyu2hGbpghD0B6gSWFmsXVM1IriI5J9d8tyFDPs4V6dYtj9HCNPb8z
         wosAWEpHUCffI98UMBO4hx/bRZKBW5O8RxjQJ6trNWaRPpjcpjqDRxRRS9ZfpT8W+qi1
         zriPkVc/8iBA67zlR1OkM0pZMAy+tDlxurCK0MeAjQcplRfGJGs8/TjOrh+LAPOJEuwo
         cj1zFZ0HT2px9LrF18SXIqHSPXkWSvqVrWQxC81ubLyPFaeBFIBnj759BBJLBIipvjDg
         yAtYJ86hkUI3oXPRBk4tUsKdugjJqe95+zikt4q/2J4ECnlIPc7Ws6fn00vvwGT3qMg1
         rbCQ==
X-Received: by 10.180.189.41 with SMTP id gf9mr2922462wic.32.1369891734841;
 Wed, 29 May 2013 22:28:54 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 22:28:54 -0700 (PDT)
In-Reply-To: <20130530052318.GA2923@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225924>

On Thu, May 30, 2013 at 12:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Wed, May 29, 2013 at 6:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>> A bigger problem (in my opinion) with allowing arbitrary changes to
>>> the meaning of existing commands is that scripts, whether placed in
>>> .sh files or given as commands to run over IRC, stop working
>>> altogether.  It's nice to have commands like "git log" and "git am"
>>> mean the same thing no matter what machine I am on.
>>
>> Except that's not true:
>
> It's not true that my opinion is that a bigger problem than the
> non-problem Ram mentioned with allowing arbitrary changes to the
> meaning of existing commands is that scripts stop working reliably?

It's not true what you said:

commands like "git log" and "git am" mean the same thing no matter
what machine I am on.

> This combative style of communication is toxic.  It kills the chance
> of a calm, pleasant discussion, even with patient people who don't
> even fundamentally disagree.  Please stop it.

Stop assuming bad faith[1].

[1] http://en.wikipedia.org/wiki/Wikipedia:Assume_good_faith

-- 
Felipe Contreras
