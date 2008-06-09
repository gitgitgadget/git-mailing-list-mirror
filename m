From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: squashing patches
Date: Mon, 09 Jun 2008 08:43:08 -0700
Message-ID: <484D4F8C.7030600@gnu.org>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <484D47C9.9050509@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 17:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5jXd-00026Y-Ip
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 17:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYFIPnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 11:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbYFIPnU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 11:43:20 -0400
Received: from main.gmane.org ([80.91.229.2]:46147 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbYFIPnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 11:43:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K5jWd-0003cI-Eb
	for git@vger.kernel.org; Mon, 09 Jun 2008 15:43:15 +0000
Received: from ancc-66-78-193-51.smartcity.com ([66.78.193.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 15:43:15 +0000
Received: from bonzini by ancc-66-78-193-51.smartcity.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 15:43:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ancc-66-78-193-51.smartcity.com
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <484D47C9.9050509@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84394>

Paolo Bonzini wrote:
> the git-squash command would simply do
> 
>   (echo 'mark :1'
>    git-rev-list --reverse $1.. | sed 's,^,pick '
>    echo "squash --up-to :1 $*") | git-sequencer

Nah this makes no sense, sorry.

Paolo
