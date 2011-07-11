From: Illia Bobyr <Illia.Bobyr@ronin-capital.com>
Subject: Re: git remote show origin (URL)
Date: Mon, 11 Jul 2011 12:34:17 -0500
Message-ID: <4E1B3419.8020107@ronin-capital.com>
References: <1310400505376-6571492.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: frankkany <frankkany@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgKck-0001lK-KU
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349Ab1GKRuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:50:18 -0400
Received: from spam01.roncap.com ([64.95.232.121]:60736 "EHLO
	spam01.roncap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab1GKRuQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 13:50:16 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jul 2011 13:50:16 EDT
X-ASG-Debug-ID: 1310405680-474119da0001-QuoKaX
Received: from psys-sltc-exhc2.ronin.roncap.com ([10.106.240.22]) by spam01.roncap.com with ESMTP id F1zFzWo88cyKkTUX (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Mon, 11 Jul 2011 12:34:40 -0500 (CDT)
X-Barracuda-Envelope-From: Illia.Bobyr@ronin-capital.com
Received: from psys-cltc-excl1.ronin.roncap.com ([fe80::6131:9de3:c24c:5b2d])
 by psys-sltc-exhc2.ronin.roncap.com ([::1]) with mapi; Mon, 11 Jul 2011
 12:34:18 -0500
X-ASG-Orig-Subj: Re: git remote show origin (URL)
Thread-Topic: git remote show origin (URL)
Thread-Index: Acw/8MKU42QLQObXRVGcRRV1zSJ+LQ==
In-Reply-To: <1310400505376-6571492.post@n2.nabble.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20110624
 Thunderbird/5.0
acceptlanguage: en-US
X-Barracuda-Connect: UNKNOWN[10.106.240.22]
X-Barracuda-Start-Time: 1310405680
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://spam01.roncap.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at roncap.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176881>

On 7/11/2011 11:08 AM, frankkany wrote:
> On box (A), when using "git remote show origin", I'm used to seeing something
> like the following next to the FETCH/PUSH URL:
> "git@somegitrepo.com:somefolder/someproject.git"
>
> The URL is actually pingable.
>
> On box (B), when using "git remote show origin" on an unfamiliar project,
> the FETCH/PUSH URL is: "hidden-repos:repositories/mysteryproject.git".
>
> How can I find where the actual url/directory where "hidden-repos" is
> pointing?

There might be a "Host hidden-repos" entry in your .ssh/config or 
/etc/ssh_config that maps the name to the actual hostname.

Ilya Bobyr