From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 20:53:41 -0600
Message-ID: <4CC8E5B5.7050404@workspacewhiz.com>
References: <20101027173644.GB15657@burratino> <0016e645b8c87a160804939cdc5e@google.com> <20101027180541.GA20527@burratino> <4CC87DE6.9090604@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Euguess@gmail.com,
	git@vger.kernel.org
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 04:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBIch-0007Hv-Pv
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 04:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932820Ab0J1Cxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 22:53:41 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:53287 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803Ab0J1Cxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 22:53:41 -0400
Received: (qmail 16253 invoked by uid 399); 27 Oct 2010 20:53:37 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Oct 2010 20:53:37 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <4CC87DE6.9090604@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160153>

----- Original Message -----
From: Eric Raible
Date: 10/27/2010 1:30 PM
> One frustrating aspect of branch.<name>.rebase is that AFAIK
> there's no way for it to preserve merges.
>
> I would much prefer if branch.<name>.rebase was allowed to
> specify the arguments to be passed to rebase:
>
> 	git config branch.mybranch.rebase "-i --preserve-merges"
>
> Anyone else see the value of something like this?
When --preserve-merges actually preserves the merges (perhaps the 
rebase-i-p branch is on the way to finishing this feature??  I couldn't 
get it to apply...), I would like this facility very much.  By default, 
I think rebase *should* preserve merges, and the current flattening it 
does now should be an option.

Josh
