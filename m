From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/5] git-request-pull.sh: remove -e switch to shell interpreter
 which breaks ksh
Date: Wed, 02 Jun 2010 09:21:04 -0500
Message-ID: <DuKPgjmjtglLvPhY13WXeTqBXfxpYQxJ0HN4KDdE6zz0PBeoa6gTbg@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfP4zZEkPwPt44bpwlkuoHdyyNRTiITmTBE-eGA_-F-7NiaN6W4MRrlA@cipher.nrlssc.navy.mil> <20100602043046.GB8245@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 16:21:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJoow-00019L-Gb
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 16:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296Ab0FBOVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 10:21:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54808 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067Ab0FBOVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 10:21:20 -0400
Received: by mail.nrlssc.navy.mil id o52EL5IV015686; Wed, 2 Jun 2010 09:21:05 -0500
In-Reply-To: <20100602043046.GB8245@progeny.tock>
X-OriginalArrivalTime: 02 Jun 2010 14:21:05.0471 (UTC) FILETIME=[D63D3CF0:01CB025E]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148252>

On 06/01/2010 11:30 PM, Jonathan Nieder wrote:
> Brandon Casey wrote:
> 
>> When git-request-pull was originally written, it did not do any error
>> checking and it used this shell feature to exit when an error occurred.
>> This script now performs proper error checking and provides useful error
>> messages, so this -e option appears to be merely a historical artifact and
>> can be removed.
> 
> Also, the MinGW port ignores -e on a #! line, so we should not rely on it.
> 
>> --- a/git-request-pull.sh
>> +++ b/git-request-pull.sh
>> @@ -1,4 +1,4 @@
>> -#!/bin/sh -e
>> +#!/bin/sh
> 
> To maintain the old behavior, I think we would need something like
> this:
> 
> -- 8< --
> Subject: request-pull: more explicit error handling

works for me.
