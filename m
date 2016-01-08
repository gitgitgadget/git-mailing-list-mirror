From: Mike Hommey <mh@glandium.org>
Subject: Re: Should notes handle replace commits?
Date: Sat, 9 Jan 2016 06:49:39 +0900
Message-ID: <20160108214939.GA22801@glandium.org>
References: <20160108012830.GA2110@glandium.org>
 <xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 23:12:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHfGy-0003qM-K8
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 23:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbcAHWMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 17:12:36 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:60262 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749AbcAHWMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 17:12:36 -0500
X-Greylist: delayed 1370 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2016 17:12:34 EST
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aHeuh-0005zB-BI; Sat, 09 Jan 2016 06:49:39 +0900
Content-Disposition: inline
In-Reply-To: <xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283585>

On Fri, Jan 08, 2016 at 12:09:45PM -0800, Junio C Hamano wrote:
> > So the question is, is this the behavior this should have?
> 
> The behaviour is a natural consequence of what graft and replace are
> about (i.e. "telling Git what the parents of a commit are" vs
> "telling Git what the contents of a commit are"), so the answer to
> the "should" question is a resounding "yes".

It's not only about contents, except for a very broad definition of
contents that includes ancestry. From my POV, replace is more about
"telling Git that this commit (and its parents) is really that one (and
its parents)".

Anyways, the dummy example is using different commit messages, and notes
everywhere, to make what happens to commits and notes obvious.  In the
real world, "first" would be "real third", so the commit messages would
be as expected in all cases. The question is whether users expect the
note of the non-replaced commit to show up. Would they expect no note at
all in the case there is a note on the replacee, but not on the
replaced?  Maybe the right thing to do would be for *both* notes to be
concatenated? I don't know.

Mike
