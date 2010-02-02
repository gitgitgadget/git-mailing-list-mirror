From: Ron Garret <ron1@flownet.com>
Subject: Re: How can I create a commit without a parent?
Date: Tue, 02 Feb 2010 00:19:24 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-2FA457.00192402022010@news.gmane.org>
References: <ron1-5383E3.00002602022010@news.gmane.org> <7vwryw6p16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 09:20:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcDzM-0001Mc-6E
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 09:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab0BBIT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 03:19:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:50636 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981Ab0BBITx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 03:19:53 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcDzE-0001Jv-Kx
	for git@vger.kernel.org; Tue, 02 Feb 2010 09:19:52 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 09:19:52 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 09:19:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138698>

In article <7vwryw6p16.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> > git commit-tree insists on having at least one parent commit at 
> > the command line.
> 
> Incorrect.  "git commit" might but "git commit-tree" does.  Perhaps you
> are forgetting that the first object name is a tree to be wrapped.

No, I didn't forget that.  I forgot to omit the -p flag.  Doh!

> A short answer is that you don't create a root commit twice in a single
> repository, period.

Why not?  I could easily create an empty root commit and multiple 
branches off that.  (Maybe that's a better way to go.)  What would be 
the difference?

rg
