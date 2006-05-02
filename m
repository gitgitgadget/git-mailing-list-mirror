From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Features ask for git-send-email
Date: Tue, 02 May 2006 14:53:15 +0200
Organization: At home
Message-ID: <e37km0$vav$1@sea.gmane.org>
References: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com> <1146573417.14059.21.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 02 14:52:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FauMj-0006Sf-S5
	for gcvg-git@gmane.org; Tue, 02 May 2006 14:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWEBMwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 08:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWEBMwa
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 08:52:30 -0400
Received: from main.gmane.org ([80.91.229.2]:33491 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964798AbWEBMwa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 08:52:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FauMd-0006Qg-5c
	for git@vger.kernel.org; Tue, 02 May 2006 14:52:27 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 14:52:27 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 14:52:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19419>

David Woodhouse wrote:

> On Sat, 2006-04-29 at 15:30 +0200, Bertrand Jacquin wrote:
>> Could it be possible to add a features in git-send-email.perl to
>> accept a differrent charset as iso-8859-1 ? I would like to send
>> fr_FR.utf8 mail as I use git to manager a latex files tree which are
>> written in utf8.
>> 
>> Any objection ?
> 
> Seems reasonable. I think we just forgot to include the Content-Type:
> header. This fixes it...

Doesn't 
        Content-Type: text/plain; charset=$charset
header need also
        MIME-Version: 1.0

-- 
Jakub Narebski
Warsaw, Poland
