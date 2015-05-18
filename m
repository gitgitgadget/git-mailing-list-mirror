From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] pull: handle =?UTF-8?Q?--log=3D=3Cn=3E?=
Date: Mon, 18 May 2015 17:26:18 +0200
Organization: gmx
Message-ID: <8db56697772d5d5a4a01268e47db2bfe@www.dscho.org>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
 <CACRoPnQKge+3gCnO79yTZHxyPE=XgCONApWPF7Ue7DSxr0E7Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:26:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMw3-0005i5-0A
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbbERP0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:26:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:64601 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbbERP0W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:26:22 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LdpcB-1ZcGXQ0rJr-00j3Zm; Mon, 18 May 2015 17:26:19
 +0200
In-Reply-To: <CACRoPnQKge+3gCnO79yTZHxyPE=XgCONApWPF7Ue7DSxr0E7Og@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:NRd/ZdN0Mg16WKt/t0xR3un9hq/+uKVX6TMgmcSexoXomXnJ2pD
 9TYXu2qV4PQqwqHypVX5XOGRvNqlom9Ix3B4hYea/aq1LAIi/FInQ1xZs+pQzR9wxMvWNO5
 B36h8CcCSkOAV8+gJAwJ9Fm/IgrPQbnZ1YuSvDM/eRKEnCMp2rCISShB6I5ecUY+4j+d9oV
 4cZ1rLpTWwHJWnTN3DofA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269279>

Hi Paul,

On 2015-05-18 17:15, Paul Tan wrote:
> Just a mental note to myself,
> 
> On Mon, May 18, 2015 at 9:39 PM, Paul Tan <pyokagan@gmail.com> wrote:
>> diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
>> index 8cccecc..eebb8c9 100755
>> --- a/t/t5524-pull-msg.sh
>> +++ b/t/t5524-pull-msg.sh
>> @@ -17,6 +17,9 @@ test_expect_success setup '
>>                 git commit -m "add bfile"
>>         ) &&
>>         test_tick && test_tick &&
>> +       echo "second" >afile &&
>> +       git add afile &&
>> +       git commit -m "second commit" &&
>>         echo "original $dollar" >afile &&
>>         git add afile &&
>>         git commit -m "do not clobber $dollar signs"
>> @@ -32,4 +35,18 @@ test_expect_success pull '
>>  )
>>  '
>>
>> +test_expect_failure '--log=1 limits shortlog length' '
> 
> Ugh ><
> 
> s/test_expect_failure/test_expect_success/

Heh, I missed that one myself.

> Will respond to the other reviews tomorrow (it's bedtime in SGT).

That was quite some stuff you sent to the list, indeed. Good work!

Ciao,
Dscho
