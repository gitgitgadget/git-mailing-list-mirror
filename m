From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git bisect goes wild?
Date: Tue, 24 Feb 2009 21:14:12 +0200
Message-ID: <87prh7abqz.fsf@iki.fi>
References: <20090224184414.GE22108@duck.suse.cz>
	<eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com>
	<20090224191002.GF22108@duck.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Jan Kara <jack@suse.cz>
X-From: git-owner@vger.kernel.org Tue Feb 24 20:15:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc2ku-0004XH-P5
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 20:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZBXTOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZBXTOU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 14:14:20 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:47530 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbZBXTOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 14:14:20 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C7057C0800; Tue, 24 Feb 2009 21:14:13 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Lc2jM-0002L4-B1; Tue, 24 Feb 2009 21:14:12 +0200
In-Reply-To: <20090224191002.GF22108@duck.suse.cz> (Jan Kara's message of "Tue\, 24 Feb 2009 20\:10\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111331>

On 2009-02-24 20:10 (+0100), Jan Kara wrote:

>   Ho, hum, right. But if I do:
> git describe 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b
>   I get v2.6.23-rc3-215-g9ec76fb which is a bit strange for bisecting
> between 2.6.23 and 2.6.24. Also the kernel gets named 2.6.23-rc3 and
> kernel config options get also to some pre 2.6.23 state. That's what
> is confusing me. It seems like the kernel checked out is some old one.
> I'm not a git expert so it might be fine but it just seems really
> strange.

Maybe this explanation helps:

http://thread.gmane.org/gmane.comp.version-control.git/99967/focus=99977
