From: Bernt Hansen <bernt@norang.ca>
Subject: Re: git log -S doesn't find some commits
Date: Tue, 04 Nov 2008 19:25:51 -0500
Organization: Norang Consulting Inc
Message-ID: <87bpwvrpbk.fsf@gollum.intra.norang.ca>
References: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
	<alpine.DEB.1.00.0811050014310.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 05 01:27:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxWEp-0007uj-Ca
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 01:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbYKEAZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 19:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbYKEAZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 19:25:57 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65303 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYKEAZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 19:25:57 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1KxWDa-0007Af-TQ; Wed, 05 Nov 2008 00:25:55 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id mA50PqJ3031559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Nov 2008 19:25:53 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id mA50PqdX014155;
	Tue, 4 Nov 2008 19:25:52 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id mA50Ppag014154;
	Tue, 4 Nov 2008 19:25:51 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18xj+KoAW26ZMRbHkTvoik2
In-Reply-To: <alpine.DEB.1.00.0811050014310.30769@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Wed\, 5 Nov 2008 00\:15\:44 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100129>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 4 Nov 2008, Bernt Hansen wrote:
>
>> Commits B, C, and D are not included in the git log -S output even
>> though with gitk you can see that 'org-publish-validate-link' is in the
>> patch.
>
> It is not sufficient for it to be in the patch, it has to be added or 
> deleted in whole.  So for example if you had a line
>
> 	org-publish-validate-link Hello
>
> and you changed it to
>
> 	org-publish-validate-link World
>
> git log -SWorld will find the commit, but git log 
> -Sorg-publish-validate-link will not.

Ah I wasn't aware of that.

In this case the function 'org-publish-validate-link' was commented out,
and then in a later commit the comments were removed.

I was expecting these commits to be found by git log -S.

Thanks!

Bernt
