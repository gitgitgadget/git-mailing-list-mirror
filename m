From: Kevin Ballard <kevin@sb.org>
Subject: Re: Add colors to the prompt for status indicators
Date: Tue, 16 Nov 2010 01:07:19 -0800
Message-ID: <C43669C9-CD42-4D51-BFB9-567AAA422C06@sb.org>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com> <4CE04B82.1040804@pileofstuff.org> <19363118-D147-4946-8973-B5DDA4B00985@sb.org> <F7A9874A-738C-4BEA-8EDF-0ED1FA7D6ACF@sb.org> <AANLkTimpyug867ccsKA+fLjzDJ8NukQXcPnVJw3Uk4LD@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	git list <git@vger.kernel.org>
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 10:07:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIHVk-0003q3-Pb
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 10:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348Ab0KPJHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 04:07:24 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39034 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757270Ab0KPJHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Nov 2010 04:07:22 -0500
Received: by pva4 with SMTP id 4so58336pva.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 01:07:22 -0800 (PST)
Received: by 10.142.143.21 with SMTP id q21mr5920546wfd.182.1289898442126;
        Tue, 16 Nov 2010 01:07:22 -0800 (PST)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id q13sm1112416wfc.17.2010.11.16.01.07.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 01:07:21 -0800 (PST)
In-Reply-To: <AANLkTimpyug867ccsKA+fLjzDJ8NukQXcPnVJw3Uk4LD@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161549>

On Nov 16, 2010, at 12:11 AM, Sebastien Douche wrote:

> On Tue, Nov 16, 2010 at 00:14, Kevin Ballard <kevin@sb.org> wrote:
>> I take it back. We can use PROMPT_COMMAND for this, to set up variables
>> containing what you want.
>> 
>> Something like the following should work:
> 
> Hi Kevin,
> good job! I looked the git prompt and I'm a bit disappointed with the
> combination, ps1 can show many items:
> 
> #
> %
> +
> *
> $
> REBASE-i|
> REBASE-m|
> MERGING|
> BISECTING|
> < > <> (or u+count u-count u+countu-count)
> 
> Each item is "optional", so you can have REBASE-i| with * and +, or
> only *. It seems to complicated to wrap all items (I think of the
> verbose mode for upstream branches). Maybe coding a lua (or Python)
> prompt with a config file.

In the end you need to stuff everything that needs a distinct color into its
own shell variable. You could just extend the shell function that's doing that
right now, or you could write a script in another language that emits a
shell-quoted set of variables suitable for evaling by the shell.

-Kevin Ballard