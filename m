From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: gitweb: how to name main "action" subroutines?
Date: Mon, 31 Jul 2006 10:26:25 -0700 (PDT)
Message-ID: <20060731172625.48437.qmail@web31811.mail.mud.yahoo.com>
References: <eal2ic$14o$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Jul 31 19:27:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7bXD-0005m3-9Z
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 19:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWGaR01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 13:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWGaR01
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 13:26:27 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:6008 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030277AbWGaR00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 13:26:26 -0400
Received: (qmail 48439 invoked by uid 60001); 31 Jul 2006 17:26:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4ZUfR9dZiy4Smo0cz5MYz4hFBsYw6k8PLqdNiyTuE0qztjo30MGc7UGaOuHk7ZSpT48uy34bYucF8z1F/WvyEfzO1YP9sCAvh3aPjmNGx1tUpGKzGdL8teZUMEFeAH76f9v8U053blrdLBmkQHrMUtRwdr8Re5V/3ZdpRxPr9G4=  ;
Received: from [71.80.231.253] by web31811.mail.mud.yahoo.com via HTTP; Mon, 31 Jul 2006 10:26:25 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <eal2ic$14o$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24530>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> I'm going to rename some gitweb subroutines to better correspond to what
> given subroutine does. I have problem: how to name main "action"
> subroutines? Currently they use git_ prefix, e.g. git_logo.
> git_project_list, git_rss, git_summary, git_heads,...
> 
> I have thought about do_logo, or gitweb_logo, or out_logo etc., but somehow
> none is best.

"git_<noun>_<verb>" ?  So then you'd have, for example "git_logo_show".

   Luben
