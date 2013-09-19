From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: git issue / [PATCH] MIPS: fix invalid symbolic link file
Date: Thu, 19 Sep 2013 14:36:47 -0600
Message-ID: <523B605F.8090402@wwwdotorg.org>
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com> <20130919133920.GA22468@linux-mips.org> <523B555E.2070508@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree@vger.kernel.org, git@vger.kernel.org,
	steven.hill@imgtec.com, mmarek@suse.cz, swarren@nvidia.com,
	linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
	james.hogan@imgtec.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: linux-kbuild-owner@vger.kernel.org Thu Sep 19 22:36:56 2013
Return-path: <linux-kbuild-owner@vger.kernel.org>
Envelope-to: glkd-linux-kbuild@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kbuild-owner@vger.kernel.org>)
	id 1VMky7-0005mB-2F
	for glkd-linux-kbuild@plane.gmane.org; Thu, 19 Sep 2013 22:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab3ISUgx (ORCPT <rfc822;glkd-linux-kbuild@m.gmane.org>);
	Thu, 19 Sep 2013 16:36:53 -0400
Received: from avon.wwwdotorg.org ([70.85.31.133]:33476 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3ISUgx (ORCPT
	<rfc822;linux-kbuild@vger.kernel.org>);
	Thu, 19 Sep 2013 16:36:53 -0400
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by avon.wwwdotorg.org (Postfix) with ESMTPS id 25BE52200C;
	Thu, 19 Sep 2013 14:36:52 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by severn.wwwdotorg.org (Postfix) with ESMTPSA id 3BDEEE461B;
	Thu, 19 Sep 2013 14:36:49 -0600 (MDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <523B555E.2070508@kdbg.org>
X-Enigmail-Version: 1.4.6
X-Virus-Scanned: clamav-milter 0.97.8 at avon.wwwdotorg.org
X-Virus-Status: Clean
Sender: linux-kbuild-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kbuild.vger.kernel.org>
X-Mailing-List: linux-kbuild@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235030>

On 09/19/2013 01:49 PM, Johannes Sixt wrote:
> Am 19.09.2013 15:39, schrieb Ralf Baechle:
>> The original patch that introduced the symlink with the \n is kernel
>> commit 3b29aa5ba204c62b3ec8f9f5b1ebd6e5d74f75d3 and is archived in
>> patchwork at http://patchwork.linux-mips.org/patch/5745/  The patch
>> file contains a \n at the end - but one would expect that from a
>> patch file that has been transfered via email, so I'm not sure how this
>> is supposed to work with emailed patches?!?
> 
> The mbox file I downloaded from this link looks like this:
...
> but it should look like this:
...
> Whoever or whatever moved the '\ No newline at end of file' line above
> the patch text is to blame.

That sounds like a patchwork problem; the original copy of the message I
received looks correct.
