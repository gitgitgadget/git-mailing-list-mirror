From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitk does not show path file list
Date: Tue, 24 Nov 2009 08:57:16 +0100
Message-ID: <4B0B91DC.1020902@viscovery.net>
References: <33e2b2760911170409q4cbdad8ay83ae5c941bc5ff95@mail.gmail.com> <loom.20091124T060334-836@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Blakeney <markb@berlios.de>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCqH7-000466-6E
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbZKXH5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 02:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757831AbZKXH5O
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:57:14 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45550 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757827AbZKXH5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 02:57:13 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NCqGz-0005CB-GS; Tue, 24 Nov 2009 08:57:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0B1A69F88; Tue, 24 Nov 2009 08:57:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <loom.20091124T060334-836@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133568>

Mark Blakeney schrieb:
> This seems to me to be a straight out bug but given I've had no response here
> and  given this is such a simple issue then I guess it's not a bug and I'm just
> missing something? Please somebody, why does gitk (usually) not show the subset
> list of files affected when you give it a path?
> 
> E.g. If I am in a src dir then "gitk ." does not list files. Neither does "gitk
> $PWD" nor "gitk ../src". However "cd ..; git src" does list files!?

gitk doesn't list the files in your examples because the patterns you gave
are not initial substrings of any files in the list.

-- Hannes
