From: =?UTF-8?B?R29uemFsbyBHYXJyYW11w7Fv?= <ggarra@advancedsl.com.ar>
Subject: Re: Git and securing a repository
Date: Thu, 03 Jan 2008 03:08:56 -0300
Message-ID: <477C7BF8.2090406@advancedsl.com.ar>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar> <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com> <477B69ED.3090107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201> <20080103035838.GA24004@spearce.org> <477C7459.3020402@advancedsl.com.ar> <20080103044552.GB24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 06:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAIIk-0008Mm-3s
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 06:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbYACFHE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2008 00:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYACFHE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 00:07:04 -0500
Received: from echunga.terra.com ([66.119.66.230]:43813 "EHLO
	echunga.terra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYACFHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 00:07:03 -0500
Received: from feluga.terra.com (feluga.terra.com [66.119.66.183])
	by echunga.terra.com (Postfix) with ESMTP id A0CD39540EB;
	Thu,  3 Jan 2008 00:06:57 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: dceef211da8b6f5900de0a4e5b50176b
Received-SPF: none (feluga.terra.com: 66.119.66.183 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.183; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.33.238])
	(authenticated user ggarra@advancedsl.com.ar)
	by feluga.terra.com (Postfix) with ESMTP id 953672E295A;
	Thu,  3 Jan 2008 00:06:56 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080103044552.GB24004@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69511>

Shawn O. Pearce wrote:
>=20
> Its a distributed version control system.  All peers are equal.
> Most security in Git is handled by only pulling from sources you
> trust, and never allowing someone to push stuff into a repository
> you own.
>=20

Regarding that... is there a way to control the umask of a git clone=20
independent of the actual umask of the user or directories inside the=20
repository?  Ideally, on the server side?

That is, for sensitive repositories, I would like "git clone" to always=
=20
clone that repository with 0700 permissions, so that the silly mistake=20
of cloning a sensitive repository into a public directory and forgettin=
g=20
to restrict its permissions can be avoided completely.


--=20
Gonzalo Garramu=C3=B1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
