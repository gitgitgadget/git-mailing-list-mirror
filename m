From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Wed, 03 Oct 2012 11:51:51 -0600
Message-ID: <506C7B37.3080804@workspacewhiz.com>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com> <506A9EA6.9010303@gmail.com> <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com> <CACsJy8CUK0g4FhuJxzJqN7qS2apoO2zYdg_SGvWzEN5dGcHhaA@mail.gmail.com> <506C3F23.9000009@web.de> <CACsJy8DRxbjcRpbO30vOCo9D+TK_dDX_oiocZSOtnGAR2jAOFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 19:53:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJT8H-0003Zb-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 19:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965426Ab2JCRv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 13:51:59 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39182 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965422Ab2JCRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 13:51:58 -0400
Received: (qmail 32280 invoked by uid 399); 3 Oct 2012 11:51:26 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@204.238.46.101)
  by hsmail.qwknetllc.com with ESMTPAM; 3 Oct 2012 11:51:26 -0600
X-Originating-IP: 204.238.46.101
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CACsJy8DRxbjcRpbO30vOCo9D+TK_dDX_oiocZSOtnGAR2jAOFw@mail.gmail.com>
X-Antivirus: avast! (VPS 121003-1, 10/03/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206916>

----- Original Message -----
From: Nguyen Thai Ngoc Duy
Date: 10/3/2012 7:42 AM
> On Wed, Oct 3, 2012 at 8:35 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> */foo/bar
>> */*/foo/bar
>> */*/*/foo/bar
>>
>> Using "**/foo/bar" instead would be a great improvement
> If this "**/foo/bar" (i.e. no wildcards except one ** at the
> beginning) is popular, we could optimize this case, turning fmatch()
> into strncmp(), just like what we do for "foobar*"
FWIW, I would like to see this in .gitattributes as well.  I have a 
version of .gitattributes that supports recursive wildcards that I use 
for specifying filters.

-Josh
