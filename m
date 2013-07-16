From: Dirk Wallenstein <halsmit@t-online.de>
Subject: Re: [PATCH] howto: Use all-space indentation in ASCII art
Date: Tue, 16 Jul 2013 10:24:13 +0200
Message-ID: <20130716082413.GA27283@bottich>
References: <20130715164658.GA8675@bottich>
 <7v61wba3gu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 10:24:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz0Yk-0005Xr-U6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 10:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab3GPIYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 04:24:24 -0400
Received: from mailout01.t-online.de ([194.25.134.80]:53515 "EHLO
	mailout01.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab3GPIYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 04:24:22 -0400
Received: from fwd53.aul.t-online.de (fwd53.aul.t-online.de )
	by mailout01.t-online.de with smtp 
	id 1Uz0YV-00083w-RZ; Tue, 16 Jul 2013 10:24:19 +0200
Received: from localhost (rIagUiZ-whcdm-KKHk1aIuzeq7+cpjwzaXz-LdKyykalGNwZBRcNyQ8s8WdMOT8QGo@[178.202.201.83]) by fwd53.t-online.de
	with esmtp id 1Uz0YR-1QTthY0; Tue, 16 Jul 2013 10:24:15 +0200
Content-Disposition: inline
In-Reply-To: <7v61wba3gu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: rIagUiZ-whcdm-KKHk1aIuzeq7+cpjwzaXz-LdKyykalGNwZBRcNyQ8s8WdMOT8QGo
X-TOI-MSGID: 461c4397-f988-4c8a-9b0d-933b5d28c67e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230543>

On Mon, Jul 15, 2013 at 03:00:17PM -0700, Junio C Hamano wrote:
> Dirk Wallenstein <halsmit@t-online.de> writes:
> 
> > Keep the sketch aligned independent of the tabstop width used.
> 
> Thanks.
> 
> This is a source text to be formatted into HTML, isn't it?
> 
> In our sources, a HT indents to multiple of 8 columns.  As long as
> the output HTML produced from the source can be seen on a terminal
> with any tab-width correctly, I do not see any reason to apply this
> patch.
> 
> Am I missing something???
> 

Those text files are installed as documentation (at least on my distribution).
They have a *.txt suffix, which tells me that they are meant to be read.  If those
would ever be opened with a text editor where the user has set the default
tabstop width to something other than 8 it would teach something nonsensical.
Not to mention if those files would have been printed with the wrong setting.

Why would you want to limit those files to be source for HTML only?

The HTML after this patch is still fine.

-- 
Cheers,
  Dirk
