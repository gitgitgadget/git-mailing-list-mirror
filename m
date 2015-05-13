From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] pull: handle =?UTF-8?Q?--log=3D=3Cn=3E?=
Date: Wed, 13 May 2015 14:23:21 +0200
Organization: gmx
Message-ID: <c8dc145fcc56d38e04fc0e07ceb34999@www.dscho.org>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
 <1431508661-21729-3-git-send-email-pyokagan@gmail.com>
 <vpqlhgszujc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 13 14:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsVhM-0007CS-Py
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 14:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934382AbbEMMX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 08:23:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:64146 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509AbbEMMXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 08:23:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MeQ43-1YYwlh1k2p-00Q9uM; Wed, 13 May 2015 14:23:22
 +0200
In-Reply-To: <vpqlhgszujc.fsf@anie.imag.fr>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:VoZLL7zdA6Mu7dQXoH0/PNFt3ei0UdU+uOLPMbvYy9okQ8hb8gA
 O4BN62oUQQ2VN0zOVOrUddEE3QycijcP/ZBW4/j5MYYmOLQ9MYNmXSb+YiQJvDnQQ/RvteQ
 nJTqo7QLYHWcBDdfQ+4jWhn3b6QpDH8aTLUzLarROdD6fyO8raeYDFXsoCsq+eZF9Fgzx//
 eOgN1BYxmni1IwgF4VF7w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268979>

Hi Matthieu,

On 2015-05-13 11:38, Matthieu Moy wrote:
> Paul Tan <pyokagan@gmail.com> writes:
> 
>> -	--log|--no-log)
>> -		log_arg=$1 ;;
>> +	--log|--log=*|--no-log)
>> +		log_arg="$1" ;;
> 
> I think you actually don't need the double quotes here (var=$value works
> even if $value has spaces IIRC), but they don't harm and I prefer having
> them.

I am far from a shell expert, but IIRC "$1" converts all whitespace to single spaces. In general, you therefore want to quote arguments, just in case.

Ciao,
Dscho
