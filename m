From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 17:48:18 -0400
Message-ID: <53616FA2.2010405@xiplink.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>	<536106EA.5090204@xiplink.com>	<xmqqppjyhnom.fsf@gitster.dls.corp.google.com>	<536152D3.5050107@xiplink.com> <xmqqa9b2egcy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 23:48:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcME-0008Ed-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759601AbaD3Vrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:47:53 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:48563 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759440AbaD3Vrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:47:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 9FF803F08D9;
	Wed, 30 Apr 2014 17:47:52 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp25.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 571813F0902;
	Wed, 30 Apr 2014 17:47:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqa9b2egcy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247793>

On 14-04-30 04:01 PM, Junio C Hamano wrote:
> 
> Maybe I was unclear.
> 
> I didn't mean "replace 'pull' with 'update' everywhere".  I meant
> "Introduce 'update' that lets integrate your history into that from
> the remote, which is to integrate in a direction opposite from how
> 'pull' does".  

That's what I understood.

> Then the downstream people (i.e. by definition, most of us) would
> use "git update" while integrators would use "git pull".  There is
> no workflow assumption if we do so.

Isn't merge-or-rebase a workflow assumption?  I don't think there's a good
rule of thumb for that choice.  Downstream-vs-Integrator doesn't seem like
enough, nor does it seem as simple as "'git pull' should merge" and "'git
update' should rebase" (or vice-versa).

But maybe I'm wrong and there really is only one salient axis (be it that one
or another).

>> I don't think we'll ever be able to create a One "Git Pull" To Rule Them All.
> 
> Yes, that is exactly why I mentioned "git update".

I doubt that a new, additional command with different workflow assumptions
will be any more successful.

> Another way not to make any workflow assumption is to ask the user
> to tell us.

Yes.  But I wouldn't expect a new user to be able to answer.

		M.
