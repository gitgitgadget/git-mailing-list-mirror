From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Does cloning a shallow repo require special setting in the cloned one?
Date: Thu, 26 Feb 2009 08:34:51 +0200
Message-ID: <87tz6hn1tg.fsf@iki.fi>
References: <1235620146513-2387799.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: roylee17 <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 07:37:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcZs1-0002FG-7z
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 07:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbZBZGe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 01:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbZBZGe4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 01:34:56 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:47940 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbZBZGe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 01:34:56 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC9058A9A24; Thu, 26 Feb 2009 08:34:52 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LcZpb-00010V-Jo; Thu, 26 Feb 2009 08:34:51 +0200
In-Reply-To: <1235620146513-2387799.post@n2.nabble.com> (roylee's message of "Wed\, 25 Feb 2009 19\:49\:06 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111527>

On 2009-02-25 19:49 (-0800), roylee17 wrote:

> $ git clone --depth 1 git-full git-shallow2
> 'git log' still gives a full history
>
> Why can't I clone a shallow repo from the git-full?
> Does it requires some settings in the git-full repo?

I don't know the "why" part but using file:// URL should work:

    git clone --depth 1 file:///path/to/git-full git-shallow2
