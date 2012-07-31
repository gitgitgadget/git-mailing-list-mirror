From: "Manuela Hutter" <manuelah@opera.com>
Subject: Re: Return code in cmd (git describe)
Date: Tue, 31 Jul 2012 14:54:40 +0200
Organization: Opera Software ASA
Message-ID: <op.wia95es4t21y7h@id-c1003.oslo.osa>
References: <op.wia7q0jqt21y7h@id-c1003.oslo.osa>
 <20120731162715.f1f01a825a7a0f74a2e3b412@domain007.com>
Reply-To: manuelah@opera.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Konstantin Khomoutov" <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwByM-00021V-9C
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 14:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab2GaMyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 08:54:45 -0400
Received: from smtp.opera.com ([213.236.208.81]:37739 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab2GaMyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 08:54:45 -0400
Received: from id-c1003.oslo.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q6VCsXRY030036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Jul 2012 12:54:34 GMT
In-Reply-To: <20120731162715.f1f01a825a7a0f74a2e3b412@domain007.com>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202651>

On Tue, 31 Jul 2012 14:27:15 +0200, Konstantin Khomoutov  
<flatworm@users.sourceforge.net> wrote:

> On Tue, 31 Jul 2012 14:02:50 +0200
> "Manuela Hutter" <manuelah@opera.com> wrote:
>
>> we have some python scripts that are run from Visual Studio, and one
>> of them fails because of a wrong git return code when calling
>> 'git describe --dirty'
> [...]
>> Run from wingw, the return code is 0.
>> Run from cmd, the return code is 1.
>>
>> Why?
> Supposedly, when you run Git from cmd.exe, the git.cmd top-level script
> (which wraps the git.exe binary) gets executed, and it's currently
> affected by this bug [1] (fixed).  When you run Git from Git bash, the
> git.exe binary runs directly and hence the bug is not exposed.
>
> 1. https://github.com/msysgit/msysgit/issues/43

Great, thanks for the info!
/Manuela
