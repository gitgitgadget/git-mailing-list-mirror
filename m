From: Walter Bright <boost@digitalmars.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Fri, 30 Jul 2010 22:45:36 -0700
Organization: Digital Mars
Message-ID: <i30da5$84d$1@dough.gmane.org>
References: <i308gl$v6p$1@dough.gmane.org> <20100731044957.GA8920@burratino> <i30bg7$50k$1@dough.gmane.org> <20100731053918.GA19688@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 07:46:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of4tf-0002Bt-66
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 07:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250Ab0GaFp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 01:45:57 -0400
Received: from lo.gmane.org ([80.91.229.12]:49030 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab0GaFpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 01:45:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Of4tL-000233-Av
	for git@vger.kernel.org; Sat, 31 Jul 2010 07:45:51 +0200
Received: from c-24-16-56-60.hsd1.wa.comcast.net ([24.16.56.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:45:51 +0200
Received: from boost by c-24-16-56-60.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:45:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-56-60.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20100731053918.GA19688@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152306>

Ilari Liusvaara wrote:
> On Fri, Jul 30, 2010 at 10:14:40PM -0700, Walter Bright wrote:
>> A final question: where does the repository actually go (so I can
>> back it up)? This is a local thing, I'm not trying to set up a
>> networked or remote repository, so it'll be the default location.
> 
> .git directory in root of working copy. One way to backup is just
> to do recursive backup of entiere working copy[1].
> 
> [1] But upon restore, the working copy cache will be wrong

Why? Is it someplace else?

> and needs to be rebuilt (git update-index --refresh).
