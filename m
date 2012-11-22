From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 22 Nov 2012 08:27:46 +0100
Message-ID: <50ADD3F2.6040102@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com> <509B7E6B.1030407@alum.mit.edu> <509BD7E7.2010807@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <mbranchaud@xiplink.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?UTF-8?B?w7AgQmphcm1hc29u?= 
	<avarab@gmail.com>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Thu Nov 22 23:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbfjw-0004tb-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 23:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab2KVW7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 17:59:09 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:52771 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752374Ab2KVW7G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2012 17:59:06 -0500
X-AuditID: 1207440c-b7f616d00000270b-22-50add3f699fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B2.0F.09995.6F3DDA05; Thu, 22 Nov 2012 02:27:50 -0500 (EST)
Received: from [192.168.69.140] (p57A25F2E.dip.t-dialin.net [87.162.95.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAM7RkOH026562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 22 Nov 2012 02:27:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <509BD7E7.2010807@xiplink.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsUixO6iqPvt8toAg/sLuC2OP73OYrH22R0m
	i64r3UwWDb1XmC1WzrjBaHHp83pWi8YnRRarH99ht3h/9j+zA6fHzll32T0mfjnO6nHxkrLH
	501yHgcuP2YLYI3itklKLCkLzkzP07dL4M44P38vW8Fu3ooZbz4xNzC+4+pi5OSQEDCRaHo9
	hQ3CFpO4cG89kM3FISRwmVFi37+bUM5pJolNJy6xgFTxCmhLPL/YygRiswioSsw/3c4MYrMJ
	6Eos6mkGi4sKhEms2XOICaJeUOLkzCdAvRwcIgISEg9e+oPMZBZYyCxxeuFqVpAaYQFniZVz
	djBBLHvOKLH431lGkAQn0LItB7+wgTQzC6hLrJ8nBBJmFpCX2P52DvMERoFZSFbMQqiahaRq
	ASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQSODZwfhtncwhRgEORiUe
	XiaFtQFCrIllxZW5hxglOZiURHkvXAIK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFdVACU401J
	rKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8F4GGSpYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPY+AGnnLS5IzAWKQrSeYnTlmDOz/Qkjx4b1
	IPLOjy4g2fsPRLbv637CKMSSl5+XKiXOe/gCULMASHNGaR7caliafMUoDgwJYd4nICt4gCkW
	bsMroOVMQMvjXVaDLC9JREhJNTC2f7Xzu7aXlXldabPs8w07nHRtniS28rm+P9F6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210219>

On 11/08/2012 05:03 PM, Marc Branchaud wrote:
> I look forward to trying out your updates.  One thing I had to do to the
> original script was override get_envelopesender() in GenericEnvironment to
> use $USER if hooks.envelopesender is not set.  (This is what the old
> post-receive-email script does.)

I was going to fix this, but it doesn't look to me like the old
post-receive-email script does what you claim.  That script only uses
$envelopesender in the sendmail command line

    /usr/sbin/sendmail -t -f "$envelopesender

, but if it is not set then the "-f" option is omitted entirely (it does
not default to $USER as you claim).

My script handles envelopesender the same way with respect to the
sendmail command line.  The difference is that my script also tries to
set a "From: $envelopesender" line inside the emails, which can result
in "From: None" if envelopesender is not configured.

I suppose the correct thing to do is omit the "From:" line if no
envelopesender is known.  But I don't understand your reason for wanting
envelopesender to default to $USER, which is probably not even a valid
email address.  If, in your environment, $USER is the pusher, then you
might want "From: $pusher".  I rather thought it is better to have a
uniform "From" address to make it easy for users to configure email
filtering on the emails.  Instead I set the Reply-To field to the email
address of the person responsible for the change being described (i.e.,
the pusher for reference changes and the author for commit notifications).

Please explain better why you want the behavior changed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
