From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/2] completion: Add sequencer function
Date: Mon, 01 Jun 2015 17:06:03 +0200
Message-ID: <20150601170603.Horde.iiRpDlRNsOoCFFaHVSBOwg1@webmail.informatik.kit.edu>
References: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
 <1433001710.5113.8.camel@virtuell-zuhause.de>
 <20150530210103.Horde.YoJthfdQJy5oq9wT_oOl3Q1@webmail.informatik.kit.edu>
 <xmqq6177a3zk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzRIa-0002K1-79
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbbFAPGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 11:06:41 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37926 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232AbbFAPGe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 11:06:34 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YzRIM-0004h1-0J; Mon, 01 Jun 2015 17:06:30 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YzRHv-0001tE-Jv; Mon, 01 Jun 2015 17:06:03 +0200
Received: from x590c2d02.dyn.telefonica.de (x590c2d02.dyn.telefonica.de
 [89.12.45.2]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 01 Jun 2015 17:06:03 +0200
In-Reply-To: <xmqq6177a3zk.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1433171190.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270422>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> I don't see the benefits of this change.  This patch adds more than
>> twice as many lines as it removes, and patch 2/2 adds 8 new lines
>> although it could get away with only 5 without this function.  To
>> offer sequencer options we currently go through a single if statemen=
t,
>> with this patch we'd go through a case statement, an if statement an=
d
>> finally an &&.
>>
>> G=C3=A1bor
>
> Perhaps, especially given that I'd imagine we won't be adding 47 new
> commands that drive the sequencer in the near future ;-)
>
> I presume that you are OK with Thomas's original version, then?

Yes, definitely.

It's a shame all these sequencing commands have different sets of =20
sequencer options.  Perhaps something to clean up for, say, v3.0 :)


G=C3=A1bor
