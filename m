From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] add: check return value of =?UTF-8?Q?launch=5Feditor?=
Date: Wed, 13 May 2015 10:12:31 +0200
Organization: gmx
Message-ID: <4de553a1564152cc951be8675214f7f7@www.dscho.org>
References: <CAA8EjDS9HePk6ZFa0kOy7GDa9_c_TsJ7uv7t+N9RL-3z=ZrQFQ@mail.gmail.com>
 <20150513012158.GA3066@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Russ Cox <rsc@golang.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 10:12:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsRmg-0006pQ-A1
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 10:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbbEMIMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 04:12:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:54777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932505AbbEMIMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 04:12:41 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MRjd7-1YlgOO0BgH-00SzCL; Wed, 13 May 2015 10:12:33
 +0200
In-Reply-To: <20150513012158.GA3066@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:iqi9Q6lmo+W/3sey/kJ+z2PKv1T1gcUTiO66QEvf+X5vAEJjkqE
 8nqrrP3dIr1VrCPjDS99ZRQMOP9PZAiHeIgaDzF/GS4axbmkP3rUTOYSnViPy+2yOJim8gB
 fy3Ig8JW+DXpBPck8IQKMYohONh9p/wgz1OwR8QMgzpVevoFjLW+u6UmlS6Ts+kY+tjh4TM
 GV2hzmjOfzfyUzzrlV7pw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268946>

Hi Peff,

On 2015-05-13 03:21, Jeff King wrote:
> On Tue, May 12, 2015 at 08:31:26PM -0400, Russ Cox wrote:
> 
>> The root cause seems to be that builtin/add.c's edit_patch does not
>> check the result of  the launch_editor call. It probably should.
> 
> Yes, definitely. Patch is below.

Thanks for cleaning up my mess!

Ciao,
Dscho
