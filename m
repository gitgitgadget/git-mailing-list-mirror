From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/18] rebase -i: Improve consistency of commit count
 in generated commit messages
Date: Thu, 14 Jan 2010 10:05:49 +0100
Message-ID: <4B4EDE6D.3070306@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <1e03c6ff51ca0e6da4c19da014523f01a27b1579.1263447038.git.mhagger@alum.mit.edu> <4B4ECD9E.5000707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:06:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLel-0007Sj-S0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 10:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab0ANJGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 04:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592Ab0ANJGM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 04:06:12 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60101 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab0ANJGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 04:06:10 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E95np6016365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jan 2010 10:05:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <4B4ECD9E.5000707@viscovery.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136974>

Johannes Sixt wrote:
> Michael Haggerty schrieb:
>> Use the numeral "2" instead of the word "two" when two commits are
>> being interactively squashed.  This makes the treatment consistent
>> with that for higher numbers of commits.
> 
> Huh? This is just code churn: consistency is not an advantage here.
> 
> Oh...wait... The next patch needs it this way. Couldn't you have justified
> it with "In a subsequent change, we will extract the numeral and use it in
> an expression."

In the non-git universe, consistency in the user interface *is*
considered an advantage :-)  But I will be happy to add your suggested
*second* justification for the change in v2.

Michael
