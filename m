From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [PATCH] Make filter-branch work with many branches
Date: Wed, 20 Jul 2011 06:34:33 -0700
Message-ID: <E7EC8C9A-DB1C-4C75-A860-7132E36C9369@apple.com>
References: <E186982C-71AE-4C08-B857-A67BDCD21E3D@apple.com>
 <4E25C78A.1090600@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 20 15:34:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjWvS-0007lo-31
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 15:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab1GTNew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 09:34:52 -0400
Received: from honeycrisp.apple.com ([17.151.62.51]:49789 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1GTNeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 09:34:50 -0400
Received: from relay15.apple.com ([17.128.113.54])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTP id <0LOM004VFWBX8V01@mail-out.apple.com> for git@vger.kernel.org;
 Wed, 20 Jul 2011 06:34:33 -0700 (PDT)
X-AuditID: 11807136-b7c35ae000001055-a2-4e26daf2ed86
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay15.apple.com (Apple SCV relay)
 with SMTP id C3.1F.04181.2FAD62E4; Wed, 20 Jul 2011 06:41:06 -0700 (PDT)
Received: from 67-218-102-134.cust.layer42.net
 (67-218-102-134.cust.layer42.net [67.218.102.134])
 by cardamom.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPSA id <0LOM009HRWDJUVA0@cardamom.apple.com> for git@vger.kernel.org;
 Wed, 20 Jul 2011 06:34:33 -0700 (PDT)
In-reply-to: <4E25C78A.1090600@kdbg.org>
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsUiON1OVffTLTU/g/lT5Cy6rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJWx4fpSloIXzBV35+xnamBsZu5i5OSQEDCR2LdwMyOELSZx4d56
	NhBbSKCVSaLxUzmIzSsgKPFj8j2WLkYODmYBeYmD52VBwswCWhLfH7UChbmAys8wSSw/8IQF
	JCEsYC/x5vkqJhCbTUBD4tOpu2C7OIHstbMmMIHMYRFQlXhwIgNijrjEurnn2bsY2YFW2Uh0
	c0McECWx8dQasEYRAQWJA/sWskIcKS+xuOUz4wRGgVlIbpuFcNssJLctYGRexShYlJqTWGlo
	qpdYUJCTqpecn7uJERRuDYVmOxh3/JU7xCjAwajEw5u4WdVPiDWxrLgy9xCjBAezkghvyyE1
	PyHelMTKqtSi/Pii0pzU4kOM0hwsSuK8mr+AqgXSE0tSs1NTC1KLYLJMHJxSDYwlKrvc06vr
	Xr78Z/dZrr/6a77jid2FVWa3OXgy+xaKSs+Pc3kkFvOI7ZHSTJHtW+07g3SFVFk/bVlav+dl
	jmNOvebaP4aCs9cu1GbVfDF1al/v6tjY6Im5Ma1Wsbedc3Pe8Pyq8eHR6rfwl9JgzPixWfDT
	mWvCjndcTm//NsV3y8Etu87/s1ZiKc5INNRiLipOBAB5CxyhMwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177538>


On Jul 19, 2011, at 11:06 AM, Johannes Sixt wrote:

> Am 19.07.2011 18:29, schrieb Dave Zarzycki:
>> -rev_args=$(git rev-parse --revs-only "$@")
>> -
>> case "$filter_subdir" in
>> "")
>> 	eval set -- "$(git rev-parse --sq --no-revs "$@")"
> 
> This line in the hunk context changes what "$@" will produce. Therefore,
> the "$@" that you removed above will not produce the same thing...

Thanks. My shell scripting is rather rusty these days. I'll send a new patch.

davez
