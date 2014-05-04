From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 11:21:47 +0200
Message-ID: <536606AB.1020803@kdbg.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net> <5365D91E.70207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 04 11:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgscN-0003Eq-1U
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 11:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbaEDJVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 05:21:51 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:16040 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752753AbaEDJVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 05:21:50 -0400
Received: from [178.114.111.49] (smtpout18.drei.com [109.126.64.18])
	by bsmtp.bon.at (Postfix) with ESMTP id 3E28810011;
	Sun,  4 May 2014 11:21:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <5365D91E.70207@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248085>

Am 04.05.2014 08:07, schrieb Michael Haggerty:
> On 05/03/2014 10:12 PM, brian m. carlson wrote:
>> Introduce a structure for object IDs.  This allows us to obtain the benefits
>> of compile-time checking for misuse.  The structure is expected to remain
>> the same size and have the same alignment requirements on all known
>> platforms, compared to the array of unsigned char.
>
> Please clarify whether you plan to rely on all platforms having "the
> same size and alignment constraints" for correctness, or whether that
> observation of the status quo is only meant to reassure us that this
> change won't cause memory to be wasted on padding.

I think that a compiler that has different size and alignment requirements 
for the proposed struct object_id and an unsigned char[20] would, strictly 
speaking, not be a "C" compiler.

-- Hannes
