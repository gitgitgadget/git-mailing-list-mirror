From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [ILLUSTRATION PATCH] color-words: take an optional regular expression describing words
Date: Fri, 09 Jan 2009 15:05:05 +0200
Message-ID: <87wsd48wam.fsf@iki.fi>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch>
	<alpine.DEB.1.00.0901091202250.30769@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0901091255230.30769@pacific.mpi-cbg.de>
	<200901091324.40583.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 09 14:07:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLH4S-00056t-2X
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 14:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbZAINFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 08:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZAINFT
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 08:05:19 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:59368 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbZAINFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 08:05:18 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A8803835CD6; Fri, 9 Jan 2009 15:05:08 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LLH2v-0002ln-UQ; Fri, 09 Jan 2009 15:05:05 +0200
In-Reply-To: <200901091324.40583.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 9 Jan 2009 13\:24\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105010>

Thomas Rast (2009-01-09 13:24 +0100) wrote:

> Johannes Schindelin wrote:
>> > And I would like to keep the default as-is (together _with_ the
>> > performance. IOW if the user did not specify a regexp, it should
>> > fall back to what it does now, which is slow enough).
>
> That's definitely a valid request.

I agree with that too. A good thing about the current --color-words is
that it automatically works with UTF-8 encoded text. This is _very_
important as --color-words is usually the best diff tool for
human-language texts.
