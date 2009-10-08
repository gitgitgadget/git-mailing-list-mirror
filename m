From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_git_log_-S_not_finding_all_commits=3F?=
Date: Thu, 08 Oct 2009 14:49:57 +0200
Message-ID: <49efcded.58cfa30b.4acddff5.4d773@o2.pl>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
	<vpqbpkixgea.fsf@bauges.imag.fr> <vpq63aqxflu.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: =?UTF-8?Q?Andreas_Ericsson?= <ae@op5.se>, git@vger.kernel.org
To: =?UTF-8?Q?Matthieu_Moy?= <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 08 14:58:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvsZA-000468-3f
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 14:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbZJHMug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 08:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757187AbZJHMuf
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 08:50:35 -0400
Received: from mailout1.go2.pl ([193.17.41.11]:44707 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291AbZJHMuf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 08:50:35 -0400
Received: from mailout1.go2.pl (unknown [10.0.0.103])
	by mailout1.go2.pl (Postfix) with ESMTP id 5B4EF5D519D;
	Thu,  8 Oct 2009 14:49:57 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.76])
	by mailout1.go2.pl (Postfix) with SMTP;
	Thu,  8 Oct 2009 14:49:57 +0200 (CEST)
In-Reply-To: <vpq63aqxflu.fsf@bauges.imag.fr>
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129689>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > git log -p --format="%s\n%x00"  | perl -0 -ne 'print if(/whatever-you-search/);'
> 
> git log -p -z is better than my --format= indeed.
> 
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> 

Thanks, it's practically what I was looking for.

-- 
Daniel
