From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: [PATCH] staging: brcm80211: SDIO/MMC cleanups
Date: Fri, 6 May 2011 18:44:18 +0200
Message-ID: <4DC42562.5080308@broadcom.com>
References: <20110504165947.40EED208186@grundler.mtv.corp.google.com>
 <4DC3B086.90802@broadcom.com> <7viptn3neo.fsf@alter.siamese.dyndns.org>
 <4DC41B06.5040500@drmicha.warpmail.net>
 <7v39kr3j8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"\"Grundler <grundler\"@chromium.org <Grundler" 
	<grundler@chromium.org>, "Greg Kroah-Hartman" <greg@kroah.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"Dowan Kim" <dowan@broadcom.com>,
	"Henry Ptasinski" <henryp@broadcom.com>,
	"Venkat Rao" <vrao@broadcom.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIO8u-0006uU-UL
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 18:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab1EFQog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 12:44:36 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:1560 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab1EFQof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 12:44:35 -0400
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Fri, 06 May 2011 09:48:05 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 6 May 2011 09:44:21 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 2738074D03; Fri, 6 May 2011 09:44:22 -0700 (PDT)
Received: from [10.240.253.69] (svpn-10-240-253-69.broadcom.com
 [10.240.253.69]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 F275220501; Fri, 6 May 2011 09:44:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <7v39kr3j8r.fsf@alter.siamese.dyndns.org>
X-WSS-ID: 61DAF9CF1IC1883585-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172988>

On 05/06/2011 06:07 PM, Junio C Hamano wrote:
> Michael J Gruber<git@drmicha.warpmail.net>  writes:
>
>> Junio C Hamano venit, vidit, dixit 06.05.2011 16:37:
>>> "Arend van Spriel"<arend@broadcom.com>  writes:
>>>
>>>> The git documentation on the git am command is not very elaborate. I
>>>> investigated the issue and checked following:
>>>> 1. line 135 in dhd_sdio.c in the patch does match line 135 in my
>>>> checked out branch.
>>> Does it exactly match, or does it merely visually match if you ignore tabs
>>> and spaces munged by somebody between the state of the file submitter
>>> committed and grunder.eml file you stored?
>> Junio, he reported the hashes to match! Puzzling. Or a MUA doing things
>> to the .eml.
> The latter is exactly what I meant.  The mailchain leading to the
> receiver's mailbox would not adjust the hash recorded in the patch when it
> munges whitespaces.

Tried patch -p1 < grundler.eml. That gives info at which line it fails. 
I believe we have to blame Thunderbird here as you suspected. It placed 
a line break because to line was too long. Crap! Why do tools have to be 
"smart"?

Gr. AvS
