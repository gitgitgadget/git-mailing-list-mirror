From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Mingw: verify both ends of the pipe () call
Date: Thu, 27 Aug 2015 18:09:58 +0200
Organization: gmx
Message-ID: <a65c938c29ac361fbd056d9e284f1aa9@www.dscho.org>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 18:10:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUzkg-0006bY-3b
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 18:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbbH0QKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 12:10:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:51479 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbbH0QKB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 12:10:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MCcE2-1ZdCxY3MBu-009SvZ for <git@vger.kernel.org>; Thu,
 27 Aug 2015 18:09:58 +0200
In-Reply-To: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:bcH9GOg1XUsUZdLiFn0PSbi0Gj1mytOL+z9h4vTU8O0+hCDngm9
 GEcQLJscsIPlv98rSACeSPkj8Nr292F4eQWWQ8htA2hIr045HamLrrDKOgBdvZOcEOBqpRd
 +oEijtEF7n9raWHJmlMLEJuXZQ9+MJyDrdQjVP/yxODSaD5BgGyBDlnvjqI6QzJgdORLe8h
 Q6R9+3UPycjHi9vKL2g+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QHnIbS3Bids=:2Er/5jecWxhL2cyLnpv8/V
 /EvZfahmi9gnV4Drdf8WK65ganFFUg21hIbkKUSFMQnXQI1tVX03Zov0FvyKsltRCtMPOjLBF
 u9xK3M3oeDWOaHuXOP85Nb7xTY1bfwZ+LBVPwFtqGX4TXxLujdOowstanMuHUubdo1QnO3+vz
 syqFFcgV6DrZos4FmJ9NpXjRKi3rl0Pzll4mi3aD29Bbre4jtb/MuQrVR97jmnB+Sj8QM1erw
 Xz8q0DmgaVRUHomvU+Q0g5j3yufpsDSnmuk1k6CkR0nwIuc84POkSvmK15xQoM4Mekzu+v8Bn
 yUp6BvM6qFb7k2v1CoEP1MAbqmev5IshDxl5+0v+WeadLB28RRJn7N9OWLzHwZ5YGmhuu5NuS
 onyvMTAHsTYKSp4qqmxCK5twBndP4MWUeN04Z++2QJwYYW9X+KSYg353mz7brjPrLIVqG2oN/
 RDnPfFLUp0PLoNi6OWG2pIuJgGIiytyPwFuljdbY444HoyLUHMPV3rXIdv0Wm06ZVhIHWjZxa
 hEbqt1iAifVKiGCnkwsC7FMA7L0YDz9xbV6PQ9qBY3QfnovVRlVyKLvvyaH5n62bBY2yJSwoZ
 4KAnJzgxmbBOU9ypW7ET+JfRbb2zuKvcaPIJHknCmHYJ2vY7sn/qCWRsKTjUMxh4PHZIZL7dc
 9RakuvMvjch3/bT3otfEp4uo98XmhD8iLna82wRNdI7ZeDLEavxQPls4xgdjaUJu1vofzM1LW
 /zqFj6JGkOMSAF9K56p+BnGhZkE6dldxRvCRwGlhDdQNCQm2DG7/gSZCy1MwmNWJIqKn14vW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276682>

Hi all,

On 2015-08-27 17:55, Johannes Schindelin wrote:
> From: jfmc <jfmcjf@gmail.com>
> 
> The code to open and test the second end of the pipe clearly imitates
> the code for the first end. A little too closely, though... Let's fix
> the obvious copy-edit bug.
> 
> Signed-off-by: Jose F. Morales <jfmcjf@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

For what it's worth: this is my first submitGit submission! ;-)

Ciao,
Dscho
