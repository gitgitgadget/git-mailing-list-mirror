From: Bernt Hansen <bernt@norang.ca>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 07:11:31 -0400
Message-ID: <87zkgpxr4s.fsf@norang.ca>
References: <20111024201153.GA1647@x4.trippels.de>
	<20111024214949.GA5237@amd.home.annexia.org>
	<20111024225836.GA1678@x4.trippels.de> <878voaym7k.fsf@norang.ca>
	<20111025055310.GB1902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
	"Richard W.M. Jones" <rjones@redhat.com>, meyering@redhat.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 13:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIev4-000682-0A
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 13:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab1JYLLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 07:11:40 -0400
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54644 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab1JYLLk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 07:11:40 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <bernt@norang.ca>)
	id 1RIeuv-000KJK-OT; Tue, 25 Oct 2011 11:11:37 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+9pvNWmwhw5f7Bo96mhi1S
Received-SPF: pass (mail.norang.ca: domain of bernt@norang.ca designates 192.168.1.5 as permitted sender) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=localhost.localdomain; envelope-from=bernt@norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from localhost.localdomain (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p9PBBWuO021265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Oct 2011 07:11:33 -0400
Received: from localhost.localdomain (gollum [127.0.0.1])
	by localhost.localdomain (8.14.3/8.14.3/Debian-9.4) with ESMTP id p9PBBW79005106;
	Tue, 25 Oct 2011 07:11:32 -0400
Received: (from bernt@localhost)
	by localhost.localdomain (8.14.3/8.14.3/Submit) id p9PBBV3r005105;
	Tue, 25 Oct 2011 07:11:31 -0400
X-Authentication-Warning: localhost.localdomain: bernt set sender to bernt@norang.ca using -f
In-Reply-To: <20111025055310.GB1902@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Oct 2011 22:53:11 -0700")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184202>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 24, 2011 at 08:00:15PM -0400, Bernt Hansen wrote:
>
>> I updated from an old commit 2883969 (Sync with maint, 2011-10-15)
>> to origin/master 10b2a48 (Merge branch 'maint', 2011-10-23) today and
>> promptly got segfaults on git status in my org-mode repository.
>> 
>> Going back to the old commit makes it work again.
>> 
>> Git bisect identifies the following commit as the problem:
>> 
>> [2548183badb98d62079beea62f9d2e1f47e99902] fix phantom untracked files when core.ignorecase is set
>
> I think this is a separate problem. See this thread and patch:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/184094/focus=184148

Thanks,

I'll look at that thread.

-Bernt
