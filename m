From: Crane Cai <crane.cai@amd.com>
Subject: Re: [question] retrieve some patches from another repository
Date: Wed, 20 Jan 2010 16:09:15 +0800
Message-ID: <20100120080915.GB1965@crane-desktop>
References: <20100120054614.GA1965@crane-desktop>
 <7vljft5m7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 09:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXVgv-0007Os-0C
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 09:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab0ATINY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 03:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969Ab0ATINY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 03:13:24 -0500
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:56050 "EHLO
	TX2EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0ATINX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 03:13:23 -0500
Received: from mail103-tx2-R.bigfish.com (10.9.14.236) by
 TX2EHSOBE010.bigfish.com (10.9.40.30) with Microsoft SMTP Server id
 8.1.240.5; Wed, 20 Jan 2010 08:13:21 +0000
Received: from mail103-tx2 (localhost.localdomain [127.0.0.1])	by
 mail103-tx2-R.bigfish.com (Postfix) with ESMTP id ACB907C84FE;	Wed, 20 Jan
 2010 08:13:21 +0000 (UTC)
X-SpamScore: -13
X-BigFish: VPS-13(zz1432R98dNzz1202hzzz32i6bh43j61h)
X-Spam-TCS-SCL: 0:0
Received: from mail103-tx2 (localhost.localdomain [127.0.0.1]) by mail103-tx2
 (MessageSwitch) id 1263975198682850_24641; Wed, 20 Jan 2010 08:13:18 +0000
 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.235])	by
 mail103-tx2.bigfish.com (Postfix) with ESMTP id 643981110063;	Wed, 20 Jan
 2010 08:13:18 +0000 (UTC)
Received: from svlb1extmailp01.amd.com (139.95.251.8) by
 TX2EHSMHS026.bigfish.com (10.9.99.126) with Microsoft SMTP Server (TLS) id
 14.0.482.32; Wed, 20 Jan 2010 08:13:17 +0000
Received: from svlb1twp02.amd.com ([139.95.250.35])	by svlb1extmailp01.amd.com
 (Switch-3.2.7/Switch-3.2.7) with ESMTP id o0K8E9fI019798;	Wed, 20 Jan 2010
 00:14:12 -0800
X-WSS-ID: 0KWJDHW-04-9BX-02
X-M-MSG: 
Received: from SSVLEXBH2.amd.com (ssvlexbh2.amd.com [139.95.53.183])	by
 svlb1twp02.amd.com (Tumbleweed MailGate 3.7.2) with ESMTP id 2CD471B11991;
	Wed, 20 Jan 2010 00:13:08 -0800 (PST)
Received: from ssvlexmb2.amd.com ([139.95.53.7]) by SSVLEXBH2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 20 Jan 2010 00:13:12 -0800
Received: from storexbh1.amd.com ([10.1.1.17]) by ssvlexmb2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 20 Jan 2010 00:13:11 -0800
Received: from sshaexmb1.amd.com ([10.237.2.11]) by storexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 20 Jan 2010 03:13:09 -0500
Received: from crane-desktop.amd.com ([10.237.82.14]) by sshaexmb1.amd.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 20 Jan 2010 16:13:03 +0800
Received: by crane-desktop.amd.com (sSMTP sendmail emulation); Wed, 20 Jan
 2010 16:09:15 +0800
Mail-Followup-To: Crane Cai <crane.cai@amd.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vljft5m7h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 20 Jan 2010 08:13:03.0382 (UTC) FILETIME=[63591B60:01CA99A8]
X-Reverse-DNS: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137523>

Hi Junio,

Thank you. It's my pleasure to get git maintainer's response.

On Tue, Jan 19, 2010 at 10:23:14PM -0800, Junio C Hamano wrote:
> > * merge point will cause duplicated patch generated, for example repo B has x,
> >   y, z, then accepted by repo A in merge point, and then merge back to repo B
> >   (they are different with commit id), they will generate 2 twice.
> 
> This is inevitable, if 'x' and (say) 'b' corresponds to each other but has
> textual changes due to different context.
So you mean git can not avoid generate 2 twice because they are different
commits. If I need this I will manually do it or add a new feature to let
format-patch can identify the relationship of the 2 repository, and then move
the 'since' point to avoid some point before merge.
Maybe it has value to do it. Many subsystem maintainers will easy to provide
patchset from any repository derived from linus to another repository which also
derived from linus. The patchset will let integration a little easy, you can use
'git bisect' to trace, git comments to understand the code. And all change list
is replayed, there almost no issue for integration.
> 
> 
> You are probably running "format-patch a.. -- path/to/file.c".  Try giving
> it the --full-diff option as well.  We've recently discussed to make it
> the default for format-patch but the discussion thread petered out and
> didn't reach conclusion.
Yes, you are right.

-- 
Best Regards,
- Crane
