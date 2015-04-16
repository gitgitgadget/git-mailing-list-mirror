From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [bug] first line truncated with `git log --oneline --decorate
 --graph`
Date: Thu, 16 Apr 2015 17:42:34 +0200
Organization: gmx
Message-ID: <7139e45030c23bb642c5fe35e4074c6a@www.dscho.org>
References: <552F8B85.2000908@gmail.com>
 <xmqqwq1chz2s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Robin Moussu <robin.moussu@gmail.com>, git@vger.kernel.org,
	git-owner@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 17:42:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YilwE-0004lv-5m
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbDPPmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 11:42:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:60688 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbbDPPml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:42:41 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MQ6oB-1YmKi01hA3-005EaZ; Thu, 16 Apr 2015 17:42:35
 +0200
In-Reply-To: <xmqqwq1chz2s.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:yhqaBgJGZ/3Eim6rQdNEELJxq4b9ZlazuxXZM0ZQqz+ebGjMyxO
 qLG9JKHz9zT/Ow+KLnCsvKhbNTC4dLdI4J13R5r+lg8lpnYWBCl1KHjg0a5UYHxjkMuLCzf
 rHModWXrEucjjyhW74Pjb3LcjHpNZgIS9QoGhUGxknXqbXpAfyMBY3YxjCM4Bz0AZfQmg58
 7b/nkB/b5WLRIRJ8cGtig==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267299>

Hi,

On 2015-04-16 17:28, Junio C Hamano wrote:
> Robin Moussu <robin.moussu@gmail.com> writes:
> 
>> I have a bug using the following command:
>>
>>     git log --oneline --decorate --graph
>>
>> In short, the first line of the log is often truncated.

I imagine that the pager (`less`) cuts off the lines because we start it with the `-S` option.

Robin, if the pager does not quit right away and you see a truncated line, could you try to press the keys `-`, `Shift+S`, `<Enter>` and see whether they are "untruncated"?

Ciao,
Johannes
