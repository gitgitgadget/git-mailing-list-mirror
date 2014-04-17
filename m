From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: [tig] [PATCHv2 3/3] log: Colour the diff stat
Date: Wed, 16 Apr 2014 21:04:54 -0400
Message-ID: <20140417010454.GA27665@odessa>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
 <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
 <1397426068-17439-4-git-send-email-a.kumar@alumni.iitm.ac.in>
 <CAFuPQ1JbpNcun3hGps=hwaM14wOjF+iU9bsm9+ZmJvJV_Fea4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 03:35:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WabEQ-0000WT-O9
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 03:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbaDQBfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 21:35:07 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.212]:58333 "EHLO
	mta6.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaDQBfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 21:35:06 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Apr 2014 21:35:06 EDT
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta6.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-9.20 (built Jul 15 2010))
 with ESMTPA id <0N450053QHOC1VZ0@mta6.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Wed, 16 Apr 2014 21:05:01 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1Waal5-0007EM-0I; Wed,
 16 Apr 2014 21:04:55 -0400
In-reply-to: <CAFuPQ1JbpNcun3hGps=hwaM14wOjF+iU9bsm9+ZmJvJV_Fea4Q@mail.gmail.com>
Mail-followup-to: Jonas Fonseca <jonas.fonseca@gmail.com>,
 git <git@vger.kernel.org>
Content-disposition: inline
X-OS: Linux odessa 3.10-2-amd64 x86_64
X-Operating-System: Linux odessa 3.10-2-amd64 x86_64
X-Editor: GNU Emacs 24.3.1
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246398>


On Wed, Apr 16, 2014 at 08:44:41PM -0400, Jonas Fonseca wrote:
> On Sun, Apr 13, 2014 at 5:54 PM, Kumar Appaiah
> <a.kumar@alumni.iitm.ac.in> wrote:
> >
> > This commit adds custom log_read and log_draw functions that utilize
> > the diff stat drawing functions from the diff module. The absence of
> > the triple hyphen separator prevents direct usage of the diff drawing
> > functions directly.
> 
> See my comments below.

Hi Jonas.

> > +static bool
> > +log_draw(struct view *view, struct line *line, unsigned int lineno)
> > +{
> > +       char *text = line->data;
> > +       enum line_type type = line->type;
> > +
> 
> This is missing a call to draw_lineno(...)

Noted.

> > +       if (type == LINE_DIFF_STAT) {
> > +               diff_common_draw_diff_stat(view, &type, &text);
> > +               draw_text(view, type, text);
> 
> I had to #include "tig/draw.h" for this to compile.

I'll take care of this.

I'll send you a pull request eventually. You can handle it after your
refactor is complete.

Thanks!

Kumar
-- 
Kumar Appaiah
