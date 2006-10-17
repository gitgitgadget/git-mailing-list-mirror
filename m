From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 23:23:53 -0700
Message-ID: <7v64ejqx3a.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	<Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<4534656B.7080105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 08:23:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZiMn-0007k7-TH
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 08:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423138AbWJQGXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 02:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423139AbWJQGXz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 02:23:55 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7825 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1423138AbWJQGXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 02:23:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017062353.UVYO2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 02:23:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bJPg1V00Q1kojtg0000000
	Tue, 17 Oct 2006 02:23:41 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <4534656B.7080105@utoronto.ca> (Aaron Bentley's message of "Tue,
	17 Oct 2006 01:08:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29026>

Aaron Bentley <aaron.bentley@utoronto.ca> writes:

> Johannes Schindelin wrote:
>
>>> You'll note we referred to that bevhavior on the page.  We don't think
>>> what Git does is the same as supporting renames.  AIUI, some Git users
>>> feel the same way.
>> 
>> Oh, we start another flamewar again?
>
> I'd hope not.  It sounds as though you feel that supporting renames in
> the data representation is *wrong*, and therefore it should be an insult
> to you if we said that Git fully supported renames.

Not recording and not supporting are quite different things.

What we don't do is to _record_ renames in the data structure.
I personally would not use a word as strong as _wrong_ (and
Linus may disagree), but (1) we can support renames without
recording them just fine, (2) recording renames would not help
to tell users about line movements across files which we would
want to do, and (3) we are getting closer to come up with a way
to even do (2) without recording renames.  Given these, perhaps
I might say recording renames is _pointless_ when I am in good
mood.
