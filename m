From: Scott McPeak <smcpeak@coverity.com>
Subject: Re: git stash while pending merge should not be allowed
Date: Thu, 13 Jun 2013 16:59:21 -0700
Message-ID: <51BA5CD9.7060007@coverity.com>
References: <51B18331.6060302@coverity.com> <7v1u8du5as.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 01:59:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnHQc-0006Kg-Or
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 01:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236Ab3FMX7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 19:59:39 -0400
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:44914
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759227Ab3FMX7i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jun 2013 19:59:38 -0400
Received: from mail17-db8-R.bigfish.com (10.174.8.244) by
 DB8EHSOBE005.bigfish.com (10.174.4.68) with Microsoft SMTP Server id
 14.1.225.23; Thu, 13 Jun 2013 23:59:36 +0000
Received: from mail17-db8 (localhost [127.0.0.1])	by mail17-db8-R.bigfish.com
 (Postfix) with ESMTP id 378C1B40173;	Thu, 13 Jun 2013 23:59:36 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.242.197;KIP:(null);UIP:(null);IPV:NLI;H:BL2PRD0512HT001.namprd05.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -3
X-BigFish: PS-3(zzbb2dI98dI1432Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz8275bhz2fh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1dfeh1dffh1e1dh1155h)
Received-SPF: pass (mail17-db8: domain of coverity.com designates 157.56.242.197 as permitted sender) client-ip=157.56.242.197; envelope-from=smcpeak@coverity.com; helo=BL2PRD0512HT001.namprd05.prod.outlook.com ;.outlook.com ;
Received: from mail17-db8 (localhost.localdomain [127.0.0.1]) by mail17-db8
 (MessageSwitch) id 1371167973607003_20868; Thu, 13 Jun 2013 23:59:33 +0000
 (UTC)
Received: from DB8EHSMHS032.bigfish.com (unknown [10.174.8.235])	by
 mail17-db8.bigfish.com (Postfix) with ESMTP id 9008F240048;	Thu, 13 Jun 2013
 23:59:33 +0000 (UTC)
Received: from BL2PRD0512HT001.namprd05.prod.outlook.com (157.56.242.197) by
 DB8EHSMHS032.bigfish.com (10.174.4.42) with Microsoft SMTP Server (TLS) id
 14.16.227.3; Thu, 13 Jun 2013 23:59:33 +0000
Received: from BY2PRD0310HT001.namprd03.prod.outlook.com (157.56.236.5) by
 pod51010.outlook.com (10.255.233.34) with Microsoft SMTP Server (TLS) id
 14.16.324.0; Thu, 13 Jun 2013 23:59:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7v1u8du5as.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [157.56.236.5]
X-OriginatorOrg: coverity.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227784>

On 06/07/13 11:47, Junio C Hamano wrote:
> Scott McPeak <smcpeak@coverity.com> writes:
>
>> I suggest that this problem could easily have been avoided if "git
>> stash" refused to run with a pending merge (present MERGE_HEAD file),
>> since this is crucial repository state that it does not save.  This
>> seems similar to what "git cherry-pick" does.
>
> Sounds senslbe.  What do we want to see happen in other states, in
> which Git gives control back to the user asking for help before
> moving forward (e.g. am, rebase, cherry-pick, revert)?

If you're asking me, I don't know.  My first thought is if there is any 
pending state that "stash" doesn't save, stash should refuse to run. 
But I don't know know very much about some of those commands.

-Scott
