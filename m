From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead
 Of Pull Requests
Date: Fri, 02 Mar 2012 15:18:46 +0100
Message-ID: <4F50D6C6.3080909@op5.se>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com> <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino> <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org> <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino> <4F505F8C.70802@gmail.com> <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:18:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3TJr-0005TW-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 15:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab2CBOSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 09:18:47 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44191 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751283Ab2CBOSq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 09:18:46 -0500
Received: by lahj13 with SMTP id j13so2084697lah.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 06:18:45 -0800 (PST)
Received-SPF: pass (google.com: domain of exon@op5.com designates 10.152.131.9 as permitted sender) client-ip=10.152.131.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of exon@op5.com designates 10.152.131.9 as permitted sender) smtp.mail=exon@op5.com
Received: from mr.google.com ([10.152.131.9])
        by 10.152.131.9 with SMTP id oi9mr8867711lab.6.1330697925230 (num_hops = 1);
        Fri, 02 Mar 2012 06:18:45 -0800 (PST)
Received: by 10.152.131.9 with SMTP id oi9mr7271318lab.6.1330697925148;
        Fri, 02 Mar 2012 06:18:45 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id hv2sm8228036lbb.9.2012.03.02.06.18.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 06:18:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQk8vC7Q4TquJ/v8SwPay2hV8n149TMqtcKO1LML5rKDqCEH61l8LW4YIDHZVR06hPS2kRut
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192044>

On 03/02/2012 08:03 AM, Junio C Hamano wrote:

... a very concise and exact response.

> 
> In any case, any solution that demands more things to be done by people
> near the core developers than they currently are already doing will make
> things worse by exacerbating the problem that comes from a bottleneck in
> the process.  I do not think your "The maintainer triages and assigns
> issues to other developers" or "The assigned developer marks the issue as
> 'done' after fixing it" will fly very well, regardless of the use of any
> bug tracker.
> 

It works very well when there's the incentive of roof over one's head
and food on one's table to take care of the assigned issues. However,
nothing stops a git developer from saying "sorry, I'm busy" when being
assigned really, really boring tasks that they really don't feel like
doing.

One thing I could see a bugtracker would be good for is to get companies
that use git to vote on issues or features using real money. Developers
can then pick up the issue and do something with them.

Apart from that, I doubt there's much incentive for the people who do
any of the work to pick up issues nobody cares about. The number of bugs
falling through the cracks is too small to go through a lot of work just
to keep track of them, and the ones that do are ones that are primarily
of the bikeshedding variant or such weird corner-cases that they don't
happen in 99.999% of all use-cases git was designed for and is bid to
handle.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
