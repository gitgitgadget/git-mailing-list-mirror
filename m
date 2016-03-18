From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHV2 1/2] rebase -x: do not die without -i
Date: Fri, 18 Mar 2016 07:46:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603180745370.4690@virtualbox>
References: <1458251060-311-1-git-send-email-sbeller@google.com> <1458251060-311-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	Matthieu.Moy@grenoble-inp.fr
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:47:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agoBW-0005pq-RQ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 07:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbcCRGqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 02:46:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:52326 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbcCRGqy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 02:46:54 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MDFB2-1abIPX3VvA-00GY3a; Fri, 18 Mar 2016 07:46:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1458251060-311-2-git-send-email-sbeller@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Y/TbgDlOOEuHEpEw2W7gsSv0uEGW9u8NqRAmvS1vfagTdaSJ6js
 8fgoKLP3vGnEA+ZT13cqaTFVbOnEe5hpw1QgzWCHi5O8saGA0QGCb74724Bud3aoHGY4ohy
 HU3CSWC/42KOUmdyXMyEs8zcZ0AahKx3H/jmFUwU/zSgyV6HvsaS85B/3yGcOUr/lq3l9O9
 b/BkCi7E+ZBNoczcqrnEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:whBo3XRPFJs=:6Rt5xejmiu/cYHR2e5izCn
 TVY8g8WOnN2ndQPAHgDim6f8IzxpG/EVxbOllGV/WaQK8tF+Dqq2XPqX5H8M+Y2FWbWs+85Gy
 RM6MJnk1UTEzFl+oTiGyZLu2gagPTT7QJ5rgwSjO6hg+esQ3Jg3q13K+bxLW5iTQKxy/eko95
 wX28jh6JEB5os5sX+5aR4dG2nHfkmYNpYL3ERiZ9LZP/gQn+IES8j9GvR176ApydLn14Wn/cQ
 0vSD2eJfmw5SJDM6oHwjmeWilC60pzaYWiM9WWh4PojLXQhWa9e8PMh5O0KVmS8IwUgs+tHND
 TjRFabCHOcPkJDz7VinShNhg5VYoFr1+h3IaYW/H70LlJqSVhmz7KWpFhbeZkmV75k7+QNxll
 NUyxz6QtdijJGG1mtjiqid8JbLk9N0xUnVIuo1xmYa+uQmHSq9amZIJdtdkehS4/Lnncz/4Jq
 ub882hsxlxU6G3kdUBlxXKeg5a5B97ptudodJECyp/eXYKAcVg9NXWFS1DUfxZmzudZvPdnxK
 KO8ya0nMH8jTfRxLcMMFXvewcuDAwEI2tvlSoA0ohdRX8JzAaUuWbkJhaaR7UveuaimFS1+NZ
 VEvDEcoUn6XuLqPvjJSw1axFgeRYwQ4ALMoZwDagik8I03QfmNDHo89VIVWbX1Ry2QwmY00Z/
 yXhz8wbXxCmE2xO1aIZTLjFNN5eRlQsq8GfyJs/ZhYTikAaBSPQqa5MwGJx5T9GmN+twjwNWv
 PXGan0IfYWYCqprlYy4Hou2HpRP/s7IfyOiR9T8sWO6LWisEfDT+149QJAST9ptAIz0KsC4n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289205>

Hi Stefan,

On Thu, 17 Mar 2016, Stefan Beller wrote:

>         git rev-list old...new |
>         while read rev
>         do
>                 $command || break
>         done

As Junio pointed out, there should be only two, not three dots.

Ciao,
Dscho
