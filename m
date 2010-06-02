From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 4/5] t/t7006: ignore return status of shell's unset builtin
Date: Wed, 02 Jun 2010 09:47:10 -0500
Message-ID: <CdJJyxR1_KnpwZGt1HSeDymxbS1diQ_jjDxyygUO3WI@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfMMZpuKZEHudj8tavRDS41LEhIuAY6Jac5ja0dD0ZRTTyKV_0v7MM6g@cipher.nrlssc.navy.mil> <4C05FD37.1080209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 02 16:48:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpF8-0006L3-0U
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 16:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284Ab0FBOsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 10:48:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50562 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705Ab0FBOsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 10:48:24 -0400
Received: by mail.nrlssc.navy.mil id o52ElBFf018372; Wed, 2 Jun 2010 09:47:11 -0500
In-Reply-To: <4C05FD37.1080209@viscovery.net>
X-OriginalArrivalTime: 02 Jun 2010 14:47:11.0421 (UTC) FILETIME=[7B9E3ED0:01CB0262]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148254>

On 06/02/2010 01:41 AM, Johannes Sixt wrote:
> Am 6/2/2010 2:13, schrieb Brandon Casey:
>>  test_expect_success 'setup' '
>> -	unset GIT_PAGER GIT_PAGER_IN_USE &&
>> +	unset GIT_PAGER GIT_PAGER_IN_USE
> 
> Maybe we should terminate the line with ';' to document that it is a
> deliberate choice that there is no '&&'?
> 
> Just an idea...

I like it.
