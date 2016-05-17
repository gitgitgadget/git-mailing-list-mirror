From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Date: Tue, 17 May 2016 21:07:33 +0200
Message-ID: <573B6BF5.1090004@kdbg.org>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue May 17 21:07:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2kLM-0002wu-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbcEQTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:07:39 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:6078 "EHLO bsmtp7.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbcEQTHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:07:38 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp7.bon.at (Postfix) with ESMTPSA id 3r8Rfb1h9tz5tl9;
	Tue, 17 May 2016 21:07:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id DD16B528B;
	Tue, 17 May 2016 21:07:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294897>

Am 15.05.2016 um 15:05 schrieb Noam Postavsky:
> With a certain topology involving an octopus merge, git log --graph
> --oneline --all --color=never produces output which includes some ANSI
> escape code coloring. Attached is a script to reproduce the problem
> (creates a git repository in subdir log-format-test), along with
> sample graph and valgrind output (indicates some unitialialized memory
> access).
>
> I've observed the problem with Windows git versions 2.7.0, 2.5.3.
> I've NOT observed it with 1.9.5,
>
> On GNU/Linux the symptom only appears when running with valgrind, I
> tried versions
> 2.8.0, and 2.8.2.402.gedec370 (the last is where the valgrind output comes from)
>

Sorry, I can't reproduce your observation. I ran the script you provided 
with HOME=$PWD and a minimal .gitconfig that only sets user.email. But 
valgrind is happy with both 2.8.0 and v2.8.2-402-gedec370 on my Linux box.

-- Hannes
