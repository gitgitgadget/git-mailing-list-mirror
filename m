From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH 0/9] Use a structure for object IDs.
Date: Sun, 04 May 2014 11:19:07 +0200
Message-ID: <5366060B.4000301@kdbg.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <5365DF94.9060707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 04 11:19:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgsZu-0006EL-OV
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 11:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbaEDJTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 05:19:16 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:38272 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752753AbaEDJTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 05:19:15 -0400
Received: from [178.114.111.49] (smtpout18.drei.com [109.126.64.18])
	by bsmtp.bon.at (Postfix) with ESMTP id 05D0FA7EB5;
	Sun,  4 May 2014 11:19:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <5365DF94.9060707@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248084>

Am 04.05.2014 08:35, schrieb Michael Haggerty:
> On 05/03/2014 10:12 PM, brian m. carlson wrote:
>> I specifically did not choose "sha1" since it
>> looks weird to have "sha1->sha1" and I didn't want to rename lots of
>> variables.
>
> That means that we will have sha1->oid all over the place, right?

Only during the transition period. When all functions that currently take 
unsigned char[20] are converted to struct object_id *, this additional 
dereferences go away again.

-- Hannes
