From: Kevin Daudt <me@ikke.info>
Subject: Re: Please consider extending .gitignore to support setting of a
 file size limit
Date: Fri, 8 May 2015 08:54:59 +0200
Message-ID: <20150508065459.GB31516@vps892.directvps.nl>
References: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com>
 <xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roger Mendes <sproger1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 08:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqcBl-0000T3-FB
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 08:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbbEHGzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 02:55:04 -0400
Received: from ikke.info ([178.21.113.177]:46527 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbbEHGzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 02:55:01 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 0195A440080; Fri,  8 May 2015 08:54:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268603>

On Thu, May 07, 2015 at 02:31:12PM -0700, Junio C Hamano wrote:
> Roger Mendes <sproger1@gmail.com> writes:
> 
> Having said all that, why is it that you do not want to track
> certain files that happen to be large?  Don't the existing large
> file support facility work for you (or perhaps you are not using
> them)?  It might be that your time is better spent on improving
> that, instead of working around the issue, no?
> 

My experience in #git is that people want to prevent other people
accidentelly adding large files, resulting in all sorts of problems,
which takes a lot of effort to fix if you're not an experienced user.
