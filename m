From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/2] gitk: fix --full-diff handling
Date: Fri, 19 Oct 2012 15:12:00 +0200
Message-ID: <508151A0.3050505@viscovery.net>
References: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:12:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPCNA-00024a-D5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 15:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab2JSNMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 09:12:08 -0400
Received: from so.liwest.at ([212.33.55.24]:13492 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166Ab2JSNMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 09:12:07 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TPCMr-00061P-G7; Fri, 19 Oct 2012 15:12:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4075E1660F;
	Fri, 19 Oct 2012 15:12:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208045>

Am 10/19/2012 12:56, schrieb Felipe Contreras:
> I find usel to do 'git log --full-duff -- file' to find out all the commits
> that touched the file, and show the full diff (not just the one of the file).
> 
> Unfortunately gitk doesn't honour this option; the diff is limited in the UI.

There is Edit->Preferences->General->Limit diff to listed paths. Doesn't
it do what you want if you switch it off?

-- Hannes
