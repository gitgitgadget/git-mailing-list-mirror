From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule
 does not yield complete logs")
Date: Fri, 22 May 2015 13:04:35 -0700
Message-ID: <CAPc5daX-Kw=tJFAZWnJTQ0t8_mY-_qnP1n7s7Yv6fbHC1rd_FQ@mail.gmail.com>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
 <xmqq8ucghf2s.fsf@gitster.dls.corp.google.com> <64326DCF30A041379141BB51437E87A6@PhilipOakley>
 <CAGZ79kaLqZCazM9MPR7wswMnVuvwO+Y0Pw9zPPXPEzAW6MQbEw@mail.gmail.com> <12d36f8293e517ceb5eaaf67d23056a4@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Roberto Tyley <roberto.tyley@gmail.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 22 22:05:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvtBm-0004YM-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 22:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbbEVUE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 16:04:57 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33061 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030201AbbEVUE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 16:04:56 -0400
Received: by obbnx5 with SMTP id nx5so20706680obb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/7fxv8T8ZO7HXwurHHwgHVEdcVZfugeav+tRoQSyrV4=;
        b=hqQe30B+y+cXZt28FgOKekAsVdTyqmouAeyr3porysBCRpoPNXfVB1B/x8x4KIevSH
         vZ6qg8HeHoEIg7YHgcQnkCq9ns6l6XxWIt9tZg8MdDxLwAvfjuT3TaHMlW/v0zdS+RZs
         6WNgogfan3gfvc2i+oPC4rcIUrz9K0RistKKMBOsw4tCFTtTEcaK7KmJ/XJCbwlShzxK
         dV/3LOynwbAl+O7ejVPOKRoMiUVG9LQ5EXSqRbOK+hAkqcV5c56tdQrrosI7SMetQ3CR
         VPr2oEHBKWF/wdZEdL7M7+p+pv9OcUdCjbJfynelGRHLB2CDotGBIKg/CcqDUT4yCtVZ
         JszA==
X-Received: by 10.182.213.99 with SMTP id nr3mr7828888obc.5.1432325096186;
 Fri, 22 May 2015 13:04:56 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Fri, 22 May 2015 13:04:35 -0700 (PDT)
In-Reply-To: <12d36f8293e517ceb5eaaf67d23056a4@www.dscho.org>
X-Google-Sender-Auth: faIXMkurrH7CWYiHCrYQ-flwyKs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269757>

On Fri, May 22, 2015 at 12:59 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> On 2015-05-22 21:23, Stefan Beller wrote:
>>
>> So first of all:
>> Where do I find the Amazon SES account for submitGit, to register
>> my email with?
>>
>> Also can I change the email in the process or change it before?
>
> FWIW I did not have to register my email. All I needed to do was to give submitGit
> permissions to read my personal email address and my public repositories.

Hmph, I was asked way more than that (especially, read and write access).
Does the site ask different authorizations depending on who you are?
