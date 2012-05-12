From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Incorrect time on different machines = file changes loss.
Date: Sat, 12 May 2012 14:55:05 +0200
Message-ID: <1336827305.3002.22.camel@centaur.lab.cmartin.tk>
References: <CAMkKa8D0+9M8QF51r_5kPx19rQMKh+8oXs7z9dtSLkfb=a2MtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Oleg Serov <serovov@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 14:55:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STBqo-0003QG-Od
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689Ab2ELMzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 08:55:04 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:36401 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab2ELMzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 08:55:03 -0400
Received: from [192.168.1.3] (brln-4d0c2fce.pool.mediaWays.net [77.12.47.206])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 8F7C146051;
	Sat, 12 May 2012 14:54:53 +0200 (CEST)
In-Reply-To: <CAMkKa8D0+9M8QF51r_5kPx19rQMKh+8oXs7z9dtSLkfb=a2MtQ@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197734>

On Sat, 2012-05-12 at 16:12 +0400, Oleg Serov wrote:
> Please add local and server time difference check when happing pull or push.
> 
> Incorrect time on different machines = file changes loss.


 Care to explain what this means? What did you do? What happened? What
should have happened? What part of the fetch or push relies on time and
would break if one of the clocks is wrong?

 The data exchange protocol never speaks about time, and git primarily
uses the commit graph in order to determine what to do. Some
optimisation is done with timestamps in e.g. tag --contains but this
shouldn't affect the operations you say are wrong.

   cmn
