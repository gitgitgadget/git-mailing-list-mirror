From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Sat, 28 Mar 2009 12:53:46 +0300
Message-ID: <37fcd2780903280253t189bf437h2948dd451d4d2179@mail.gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <20090327090554.5d6160f2@pc09.procura.nl>
	 <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com>
	 <7v8wmq5t8d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 10:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnVG5-0004nl-J1
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 10:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZC1Jxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 05:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZC1Jxu
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 05:53:50 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55821 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbZC1Jxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 05:53:49 -0400
Received: by fxm2 with SMTP id 2so1314334fxm.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/9od4aCzXzIJtfhSzpBGkT4l2bgwApLIzr3omo37GSQ=;
        b=TaPTVJH7YpfifOCKSTtD1rR0RxuocyIaP0tI8tA+H0qCnxI4QfyEzYHV+/hz5kX9Ys
         hIAcRq9oL8T+NmYvzdkxR3N46Y4mxb2uiY0W2RkGmGp6xGJAXv3p11RNFzZmTwNjASx1
         BWu/CCAHC8xUJM2J6WIxaNhQga8+y5RUPHkv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RrQEodS5H/HMwXsQBTRV7iceoMgtusld1mf4j2uCLo0Br1YrztX2oMMkUV+TY8XMgB
         rI/A2844ALvNznE63iBWaEWqdw54ntQMrQHQ9dUrMFE9Qwl5iSEvx26sMfFeUn2G6n3q
         6VF+QLRSWp5yRGq3dTHMVucQFJmDfwLka3TPM=
Received: by 10.86.95.20 with SMTP id s20mr2712253fgb.77.1238234026334; Sat, 
	28 Mar 2009 02:53:46 -0700 (PDT)
In-Reply-To: <7v8wmq5t8d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114943>

On Sat, Mar 28, 2009 at 4:30 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dmitry Potapov <dpotapov@gmail.com> writes:
>
>> On Fri, Mar 27, 2009 at 12:50 PM, Ulrich Windl
>> <ulrich.windl@rz.uni-regensburg.de> wrote:
>>>
>>> what made me wonder is this (about item 1): I thought I've read tha=
t blobs store
>>> content and attributes, so very obviously I wondered why not store =
thr "right
>>> attributes" (i.e. the time of the file). My reasoning: You make som=
e changes, then
>>> test them (which might last several hours or days). The if I'm happ=
y I'll
>>> "commit".
>>
>> With Git, you usually commit your changes immediately (without waiti=
ng
>> the result
>> of testing), because you can always undo commit until you publish yo=
ur changes.
>
> Heh, "can" and "usually" are somewhat different. =A0I don't.

=46air enough. But I was refering to the situation where testing may ta=
ke
several hours or days. Leaving uncommitted changes in your working tree
for a few days is rarely a good idea if you can undo the commit later. =
Of
course, the situation is different if the testing takes only a couple m=
inutes.

Dmitry
