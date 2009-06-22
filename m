From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: push.default???
Date: Mon, 22 Jun 2009 19:55:30 +0200
Message-ID: <4A3FC592.10401@gnu.org>
References: <h1nks1$vdl$1@ger.gmane.org> <7vws74cjrl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 19:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MInkE-0006QU-3g
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 19:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZFVRzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 13:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbZFVRzj
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 13:55:39 -0400
Received: from mx2.redhat.com ([66.187.237.31]:52572 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbZFVRzj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 13:55:39 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5MHte4G005354;
	Mon, 22 Jun 2009 13:55:40 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5MHtdEJ030197;
	Mon, 22 Jun 2009 13:55:39 -0400
Received: from yakj.usersys.redhat.com (dhcp-lab-149.englab.brq.redhat.com [10.34.33.149])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5MHtcRA024994;
	Mon, 22 Jun 2009 13:55:38 -0400
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <7vws74cjrl.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122051>


> You cannot do anything "in 1.6.3"; The ship has already left the port.

Yes, that was me reasoning out loud.

>> 4) in 1.6.4 or 1.7.0, make "git push" fail outright if there is no
>> push line, with text suggesting
> 
> This was already part of one possible option for push.default (change the
> built-in default to 'nothing-and-warn') when it was introduced, wasn't it?
> Instead of suggesting to configure remote.$name.push, it would suggest to
> set push.default to a desired value, which I think is a more sensible
> thing to do.

Yes, that was also reasoning out loud.  It makes sense.

Anyway, suggestion will be helpful for the "tracking" behavior refspec 
syntax.

Thanks for the remarks,

Paolo
