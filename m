From: Paul Walker <PWalker752@aol.com>
Subject: Re: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 15:15:06 +0100
Message-ID: <8E0CE121-DB2F-4017-AB46-282562B072FB@aol.com>
References: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com> <AANLkTimsGdv-La_poLpdrvuGChD6_sAD77fcjqKn5PAd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 16:15:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHHOY-00037W-Og
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 16:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab0EZOPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 10:15:37 -0400
Received: from imr-ma06.mx.aol.com ([64.12.78.142]:59482 "EHLO
	imr-ma06.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0EZOPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 10:15:36 -0400
Received: from mtaout-da01.r1000.mx.aol.com (mtaout-da01.r1000.mx.aol.com [172.29.51.129])
	by imr-ma06.mx.aol.com (8.14.1/8.14.1) with ESMTP id o4QEFIKx019581;
	Wed, 26 May 2010 10:15:18 -0400
Received: from paulw-laptop.stglab.manchester.uk.ibm.com (gbibp9ph1--blueice4n1.emea.ibm.com [195.212.29.91])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-da01.r1000.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id 7B444E0000E0;
	Wed, 26 May 2010 10:15:18 -0400 (EDT)
In-Reply-To: <AANLkTimsGdv-La_poLpdrvuGChD6_sAD77fcjqKn5PAd@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
x-aol-global-disposition: G
X-AOL-SCOLL-SCORE: 0:2:430068160:93952408  
X-AOL-SCOLL-URL_COUNT: 0  
x-aol-sid: 3039ac1d33814bfd2cf64777
X-AOL-IP: 195.212.29.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147800>


On 26 May 2010, at 14:58, Ramkumar Ramachandra wrote:

> Hi,
>
>> As I could not find any bug reporting information on the wiki I  
>> thought I
>> would mention this here, please let me know if there is a better  
>> forum for
>> bug reports.
>
> Bugs are usually reported on this mailing list.
>
>>  I believe the latest git release (1.7.1.) has an installation
>> bug when building with "NO_CURL=YesPlease".  Looking at the  
>> Makefile line
>> 1999 it reads
>>
>> for p in $(REMOTE_CURL_ALIASES); do
>>
>> which results in "/bin/sh: syntax error at line 1 : `;' unexpected"  
>> as
>> REMOTE_CURL_ALIASES is empty.
>
> I can't reproduce this. How exactly are you building? I'm using
> $ NO_CURL=YesPlease make
> ... and it builds fine for me.
>
> -- Ram

I used:

gmake prefix=<path> NO_CURL=YesPlease NO_PYTHON=YesPlease all

which works fine, followed by

gmake prefix=<path> NO_CURL=YesPlease NO_PYTHON=YesPlease install

which reported the above error
