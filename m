From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Thu, 09 Aug 2007 01:53:28 -0700
Message-ID: <877io5nl6f.fsf@hubert.paunchy.net>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
	<1185851481271-git-send-email-eclesh@ucla.edu>
	<20070731040510.GD12918@filer.fsl.cs.sunysb.edu>
	<87bqdhnotj.fsf@hubert.paunchy.net> <86r6mdp1e1.fsf@lola.quinscape.zz>
	<18071eea0708090122h79dec205j4528f4dfd7aab588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3m4-0004KF-Ff
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 10:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbXHIIxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 04:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763798AbXHIIxk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 04:53:40 -0400
Received: from smtp-6.smtp.ucla.edu ([169.232.48.137]:43366 "EHLO
	smtp-6.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758217AbXHIIxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 04:53:39 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.158])
	by smtp-6.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l798rUZa011361;
	Thu, 9 Aug 2007 01:53:30 -0700
Received: from localhost (adsl-75-26-181-145.dsl.scrm01.sbcglobal.net [75.26.181.145])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l798rUHd011396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Aug 2007 01:53:30 -0700
Received: by localhost (Postfix, from userid 1000)
	id 2ACA21E80B6; Thu,  9 Aug 2007 01:53:29 -0700 (PDT)
In-Reply-To: <18071eea0708090122h79dec205j4528f4dfd7aab588@mail.gmail.com> (Thomas Adam's message of "Thu\, 9 Aug 2007 09\:22\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55431>

"Thomas Adam" <thomas.adam22@gmail.com> writes:

> On 09/08/07, David Kastrup <dak@gnu.org> wrote:
>>     sed -i -e "s,^\($p[[:space:]]*.*\)\$,\1 #$x," "$series"
>>
>> and that's fine.
>
> I'm surprised to see 'sed -i' being at all, it's certainly non-portable.
>
> -- Thomas Adam

You're definitely right. I've been asked to change this a couple of
times and keep forgetting.  Thanks for the reminder.

	Eric
