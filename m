From: Markus Elfring <Markus.Elfring@web.de>
Subject: Clarifications for merge workflows
Date: Thu, 11 Mar 2010 12:12:21 +0100
Message-ID: <4B98D015.40401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 12:12:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpgJe-0008UB-E0
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 12:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495Ab0CKLM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 06:12:29 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:57892 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084Ab0CKLM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 06:12:28 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7F3AA14C7B2A8
	for <git@vger.kernel.org>; Thu, 11 Mar 2010 12:12:26 +0100 (CET)
Received: from [78.48.136.139] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NpgJW-0006NQ-00
	for git@vger.kernel.org; Thu, 11 Mar 2010 12:12:26 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.8) Gecko/20100228 SUSE/3.0.3-1.1.1 Thunderbird/3.0.3
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/HHEiu5KOQ9VpCpa5lobtvfKZl4vRcqyvmmO/q
	qS+qFwpymkX1PxdRuvek3L2XGlUop28U22Cna7BJ3Cyy9buQnx
	uobxw/EMmfBMPpz1055A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141953>

Hello,

Some informations are available in the manual about distributed content
management workflows.
http://kernel.org/pub/software/scm/git/docs/gitworkflows.html#_merge_workflow

I find that a few details are missing to achieve a better understanding for the
merging of branches.

Use case:
A contributor pushes an update suggestion from the personal repository "ABC" to
a topic branch in a public repository "SHARE" on a separate server. An
integrator reviews the proposed changes. If they are accepted, the integrator
will choose a repository where the merge should be performed next.
- Log-in to the server and integrate the updates there.
  or
- Fetch the remote topic branch into the integrator's own local repository
"XYZ", merge there and push the result back to the server.

Which ways do you recommend to select the storage location where a merge will be
applied first?

Regards,
Markus
