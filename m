From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Features ask for git-send-email
Date: Tue, 02 May 2006 17:35:18 +0200
Organization: At home
Message-ID: <e37u5r$4pi$1@sea.gmane.org>
References: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com> <1146573417.14059.21.camel@pmac.infradead.org> <e37km0$vav$1@sea.gmane.org> <1146579255.17934.8.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 02 17:35:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FawuO-0006La-U7
	for gcvg-git@gmane.org; Tue, 02 May 2006 17:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWEBPfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWEBPfG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 11:35:06 -0400
Received: from main.gmane.org ([80.91.229.2]:39569 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964856AbWEBPfD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 11:35:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fawth-0006AX-2O
	for git@vger.kernel.org; Tue, 02 May 2006 17:34:45 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 17:34:45 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 17:34:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19424>

David Woodhouse wrote:

> On Tue, 2006-05-02 at 14:53 +0200, Jakub Narebski wrote:
>> Doesn't
>>         Content-Type: text/plain; charset=$charset
>> header need also
>>         MIME-Version: 1.0
> 
> Maybe. The use of Content-Type: actually predates RFC2045, and if we
> include a MIME-Version header then we should make 100% sure that we also
> conform to the rest of RFC2045, which I hadn't actually looked at. In
> particular, we should take care of Content-Transfer-Encoding.
> 
> I'd prefer to leave MIME-Version out for now, I think.

If I remember correctly _some_ mail applications or news (Usenet) agents 
did not respect Content-Type without MIME-Version, I think according to 
standard. Perhaps that have changed.

As to the other MIME header:
        Content-Transfer-Encoding: 8bit

-- 
Jakub Narebski
Warsaw, Poland
