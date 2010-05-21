From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Changing indents
Date: Fri, 21 May 2010 12:12:05 -0400
Message-ID: <B8479D8D-5A73-4801-BD15-9E787EA3272A@kellerfarm.com>
References: <C0CDDC0A-A813-41C3-8CEC-40EFADFB5A4A@kellerfarm.com> <AANLkTikWhkX5mJT1f-3oIeLEVwttRhUm0MbGI-0W08b_@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 21 18:12:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUpb-0001E0-6y
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab0EUQMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 12:12:08 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:48914 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754169Ab0EUQMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 12:12:07 -0400
Received: from 13-141-14.client.wireless.msu.edu ([35.13.141.14])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OFUpM-0002YW-Nq
	for git@vger.kernel.org; Fri, 21 May 2010 12:12:00 -0400
In-Reply-To: <AANLkTikWhkX5mJT1f-3oIeLEVwttRhUm0MbGI-0W08b_@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147479>

On May 21, 2010, at 12:05 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Fri, May 21, 2010 at 16:01, Andrew Keller <andrew@kellerfarm.com> =
wrote:
>> Is it possible to change the indent of a line (or multiple lines) wi=
thout rewriting the whole line?  Or, more specifically, can a commit ex=
ist that modifies the leading whitespace of a line but still allows you=
 to trace the origin of the line to a previous commit?
>=20
> Maybe you want: git blame $sha^ file ?

Oh, there we go!

Thanks,
Andrew Keller
