From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Wed, 02 Jun 2010 09:46:14 -0500
Message-ID: <771D_fbE1nXD6XdR0EsexE96n7NZJ1WvuJ__1wNJTGHLKi4dsHGk0g@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil> <4C05FC18.4090402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 02 16:48:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpEt-0006Bi-OE
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 16:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab0FBOsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 10:48:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50559 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0FBOsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 10:48:08 -0400
Received: by mail.nrlssc.navy.mil id o52EkFCC018197; Wed, 2 Jun 2010 09:46:15 -0500
In-Reply-To: <4C05FC18.4090402@viscovery.net>
X-OriginalArrivalTime: 02 Jun 2010 14:46:15.0404 (UTC) FILETIME=[5A3ABAC0:01CB0262]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148255>

On 06/02/2010 01:37 AM, Johannes Sixt wrote:
> Am 6/2/2010 2:13, schrieb Brandon Casey:
>> +if ! test_have_prereq PYTHON_2_5_OR_NEWER
>>  then
>> +	say 'skipping git remote-testgit tests: requires Python 2.5 or newer'
> ...
>> +++ b/t/test-lib.sh
>> +if test_have_prereq PYTHON && "$PYTHON_PATH" -c '
>> +import sys
>> +if sys.hexversion < 0x02050000:
>> +    sys.exit(1)
>> +'
>> +then
>> +	test_set_prereq PYTHON_2_5_OR_NEWER
>> +fi
> 
> Please don't burden all test script invocations with this check when the
> result is used in only one place.

Very good point.
