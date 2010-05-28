From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git push from bare repo
Date: Fri, 28 May 2010 11:15:17 +0200
Message-ID: <4BFF89A5.7020802@op5.se>
References: <3197051701046e645c8ff2ae7dca872a@ns-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?R29yYW4gTWVracSH?= <meka@ns-linux.org>
X-From: git-owner@vger.kernel.org Fri May 28 11:15:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHvfP-0006XP-CV
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 11:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617Ab0E1JPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 05:15:32 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42988 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753893Ab0E1JPW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 05:15:22 -0400
Received: from source ([72.14.220.153]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS/+JqCIFrdyi+ObFpTlqqJo0XkroLfmk@postini.com; Fri, 28 May 2010 02:15:22 PDT
Received: by fg-out-1718.google.com with SMTP id d23so463822fga.12
        for <git@vger.kernel.org>; Fri, 28 May 2010 02:15:19 -0700 (PDT)
Received: by 10.204.83.26 with SMTP id d26mr5170925bkl.157.1275038119638;
        Fri, 28 May 2010 02:15:19 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id h21sm9582427bkh.11.2010.05.28.02.15.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 02:15:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <3197051701046e645c8ff2ae7dca872a@ns-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147919>

On 05/28/2010 08:57 AM, Goran Meki=C4=87 wrote:
>=20
>      I have to push from first server to second (yeah, the names are =
great
> :o) when ever someone pushes to first server. It should be done using
> post-receive hook, for example. The problem is that I can not specify=
 ssh
> key, and even if I could, anything but 600 perm for the key is reject=
ed.
> What would be the best way to acomplish this? Thanx!
>=20

Why can't you specify ssh key, and why can't you set the key to have pe=
rms
0600 and let it reside in a directory with perms 0700?

The post-receive hook is just a shell-script, basically.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
