From: Bernt Hansen <bernt@alumni.uwaterloo.ca>
Subject: Re: git rebase -i / git-gui bug
Date: Wed, 19 Dec 2007 23:47:43 -0500
Message-ID: <87r6hias5s.fsf@gollum.intra.norang.ca>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 05:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5DKQ-0001px-Q2
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 05:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbXLTErw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 23:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbXLTErw
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 23:47:52 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55764 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbXLTErv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 23:47:51 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1J5DK0-000Lj5-UZ; Thu, 20 Dec 2007 04:47:49 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18FHu8AP346iKUP1+phNZUe
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id lBK4li3x028630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Dec 2007 23:47:45 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id lBK4lhkY004894;
	Wed, 19 Dec 2007 23:47:43 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id lBK4lha9004697;
	Wed, 19 Dec 2007 23:47:43 -0500
In-Reply-To: <87ve6ub3u7.fsf@gollum.intra.norang.ca> (Bernt Hansen's message of "Wed\, 19 Dec 2007 19\:35\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68972>

Bernt Hansen <bernt@alumni.uwaterloo.ca> writes:

> Now cd /tmp/t1 and do the following:
>
> $ git rebase -i HEAD~9
>
> Change all lines with 'pick' to 'edit'
>
> For each of the 10 commits use git-gui to select 'Amend Last Commit' and
> just hit the [Commit] button (you can change the text if you want but
> it's not necessary to show the problem)
>
> $ git rebase --continue
> after each commit and repeat until the rebase is complete.
>

I can't do this at all with

$ git --version
git version 1.5.4.rc1

If I

$ git rebase -i HEAD~9

and use git-gui to edit the commit then git-rebase --continue fails

$ git rebase --continue
Could not commit staged changes.

-Bernt
