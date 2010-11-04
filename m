From: Eric Raible <raible@nextest.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 10:43:12 -0700
Message-ID: <4CD2F0B0.5060501@nextest.com>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>	<20101104112530.5c0e444a@chalon.bertin.fr>	<4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <dirson@bertin.fr>, "kevin@sb.org" <kevin@sb.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 18:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3qI-0004Da-BO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab0KDRnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 13:43:14 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:53161 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751740Ab0KDRnN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 13:43:13 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Thu, 4 Nov 2010 10:43:12 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <vpq62wddmc0.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160739>

On 11/4/2010 10:34 AM, Matthieu Moy wrote:

> ... And if we don't find a concise way
> to document it, it may reveal that it's a bad idea ...
> 
> Maybe:
> 
> #  e <commit>, edit <commit> = use commit, but stop for amending
> #  e, edit = stop for amending
> 
> but I find this rather ugly.

How about:

#  e [<commit>], edit [<commit>] = use commit (if present) but pause to amend
