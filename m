From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: idea: pruning stale tags
Date: Fri, 11 Mar 2011 09:48:31 -0500
Message-ID: <4D7A363F.7090206@xiplink.com>
References: <4D790618.9000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 15:50:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py3fN-0000yr-Vz
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 15:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab1CKOuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 09:50:01 -0500
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:45271 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347Ab1CKOuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 09:50:01 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp54.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 3032E2B0C39;
	Fri, 11 Mar 2011 09:50:00 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp54.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F1C582B0CC4;
	Fri, 11 Mar 2011 09:49:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <4D790618.9000302@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168904>

On 11-03-10 12:10 PM, Adam Monsen wrote:
> My idea is to add functionality to git-remote to prune stale tags
> (those which no longer exist on the remote). Add a new ui:
> 
> git remote prune --tags [-n | --dry-run] <name> [<remote>]
> 
> I think it is not possible to know which remote tags originated
> from, yes? That's why I suggested adding the [<remote>] parameter;
> one would be required to specify the remote to sync with if more
> than one remote is configured.

I agree with this idea, but in the context of Johan's proposed overhaul of
ref namespaces:

http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165885

		M.
