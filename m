From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: forcing a user@ into the URL if not present
Date: Tue, 05 May 2015 15:59:50 +0200
Organization: gmx
Message-ID: <231730bb9947a6ddbbd8f3bda36c89f2@www.dscho.org>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
 <CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
 <20150430202342.GC5015@vauxhall.crustytoothpaste.net>
 <CABU7BdcuJp3f6_cN8TpJX-brDUWL6-0Q5M0Yvpg2ND-k--yEbw@mail.gmail.com>
 <CABU7BddLGe-+b4cEiPi9MCd6xY5kpBU6aZuy4Vn7j+NgPdLwuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Dan Langille <dlangille@sourcefire.com>
X-From: git-owner@vger.kernel.org Tue May 05 16:00:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpdOK-0006NH-4k
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 16:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992945AbbEEN76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 09:59:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:57322 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992942AbbEEN74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 09:59:56 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1AIu-1Z4okq21zE-00tBDZ; Tue, 05 May 2015 15:59:52
 +0200
In-Reply-To: <CABU7BddLGe-+b4cEiPi9MCd6xY5kpBU6aZuy4Vn7j+NgPdLwuA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:H1qdOnobp0JH1qNNWtQ4EWKH7v/bVkSgZhOGJDsMfa5QINJGXXb
 mKazyk24jakLZh+QawWzO7XhTk5I7E1qX+riInSDez3ufI1LBqaPPFjmSeqNmYJcK7LHhQY
 Q7y6CsQBcq++SZzaCn/sK3QOpaZd9thJxb4A+kZ+WGgxRw2M9hivn5J6SIO4AD4TlHQMeaI
 gKdXzOP4aFNAAAjzcboXA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268394>

Hi Dan,

On 2015-05-05 14:35, Dan Langille wrote:

> As I understand it, in order to invoke Kerberos Authentication, a
> username must be in the URL, but that username is not involved in the
> authentication process.

Having stumbled over [this ticket](https://github.com/git-for-windows/git/issues/92) recently, it appears to me as if the following should work for you:

git clone https://:@repo.example.org/

Ciao,
Johannes
