From: Avi Kivity <avi@qumranet.com>
Subject: Re: small author mixup
Date: Wed, 30 Apr 2008 11:36:15 +0300
Message-ID: <48182F7F.9000400@qumranet.com>
References: <1209310768-12322-1-git-send-email-avi@qumranet.com> <200804301012.05179.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Carsten Otte <cotte@de.ibm.com>, git@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:38:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7pw-0007Iw-Hm
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbYD3Ih5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 04:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755151AbYD3Ih5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:37:57 -0400
Received: from bzq-179-150-194.static.bezeqint.net ([212.179.150.194]:12127
	"EHLO il.qumranet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbYD3Ihz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:37:55 -0400
Received: from [10.64.7.62] (unknown [10.64.7.62])
	by il.qumranet.com (Postfix) with ESMTP id 3849C2502FE;
	Wed, 30 Apr 2008 11:37:47 +0300 (IDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <200804301012.05179.borntraeger@de.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80810>

Christian Borntraeger wrote:
> Am Sonntag, 27. April 2008 schrieb Avi Kivity:
>   
>> Carsten Otte (4):
>>       s390: KVM preparation: provide hook to enable pgstes in user pagetable
>>       KVM: s390: interrupt subsystem, cpu timer, waitpsw
>>       KVM: s390: API documentation
>>       s390: KVM guest: detect when running on kvm
>>
>> Christian Borntraeger (10):
>>       KVM: kvm.h: __user requires compiler.h
>>       s390: KVM preparation: host memory management changes for s390 kvm
>>       s390: KVM preparation: address of the 64bit extint parm in lowcore
>>       KVM: s390: sie intercept handling
>>       KVM: s390: intercepts for privileged instructions
>>       KVM: s390: interprocessor communication via sigp
>>       KVM: s390: intercepts for diagnose instructions
>>       KVM: s390: add kvm to kconfig on s390
>>       KVM: s390: update maintainers
>>       s390: KVM guest: virtio device support, and kvm hypercalls
>>     
>
> Thats interesting, some of these patches should actually be credited to 
> Carsten - and in fact on kvm.git master they are credited to Carsten.
>
> I think the problem is, that these patches contained multiple From lines. On 
> kvm.git the first line (Carsten) was used. When you transferred these patches 
> to the kvm.git-2.6.26-branch, git used the next From-line as the original one 
> was already removed.
>
> While it is not a typical case, is there a better way of specifying multiple 
> authors to avoid future confusion?

It's probably due to my heavy use of git cherry-pick, rebase, and rebase 
-i.  I couldn't reproduce this with a test that mimics that workflow, so 
either it has been fixed already, or it's a little more subtle.

I don't think you should change anything to avoid this.  I'll keep an 
eye open for this, and if it happens again I'll fix it locally and send 
a proper bug report to the git mailing list.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
