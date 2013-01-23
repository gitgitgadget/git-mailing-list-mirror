From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 16:32:54 +0100
Message-ID: <CABPQNSb89h28O_a3uVoVrNisZqPcHHVFm8nP7GdFGCb=PVdcsQ@mail.gmail.com>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca>
 <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca>
 <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
 <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
 <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
 <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
 <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
 <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca>
 <878v7keuh3.fsf@pctrast.inf.ethz.ch> <CABPQNSad1EKbmt3Gjs+uB9fud4YBqmk++5GMqF2s047Lcc8GwQ@mail.gmail.com>
 <87d2wvc3v0.fsf@pctrast.inf.ethz.ch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty2Ks-0001wO-Km
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 16:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab3AWPdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 10:33:37 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43167 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab3AWPdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 10:33:36 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so13842397iea.22
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 07:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7FBDt4NBQi94HVhQgd+ntEEjYRxc/stIs6+xNU6/Ku8=;
        b=Oe8xgssBZA63J650cx/B3QrHMOQFT+HZhSCQHBtkn+5YzEKimQ3iFNnzoPvxEg7Ae6
         yFElJ/NP2fA5tMRMRlyq0zIleESVki90agWTTDtq1SDb21G261VKesiiyfIlACZ5uZ1k
         0K8sanHJNgPTKfK3mav4GsoqSFy4e17tDP2nb05+Q74oK4hO4NV1osCdnwzfzv6vLGof
         R7aKd/IjZBalp00YJTD0F1LAC62KlYljq1euWv1PRuL9NquBCKTzWdYcsp6vSLcBwupq
         9GeLhD5pXWrO/KohOk7s+z8jeL5e19R7YOj/FHCaW+eC76l8MrxWD8azMlMFOjLN2epD
         7olw==
X-Received: by 10.50.184.232 with SMTP id ex8mr15384385igc.30.1358955215886;
 Wed, 23 Jan 2013 07:33:35 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Wed, 23 Jan 2013 07:32:54 -0800 (PST)
In-Reply-To: <87d2wvc3v0.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214328>

On Wed, Jan 23, 2013 at 4:32 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Tue, Jan 22, 2013 at 11:14 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>>> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:
>>>
>>> Other than that I agree with Junio, from what we've seen so far, Lustre
>>> returns EINTR on all sorts of calls that simply aren't allowed to do so.
>>
>> I don't think this analysis is 100% accurate, POSIX allows error codes
>> to be generated other than those defined. From
>> http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html:
>>
>> "Implementations may support additional errors not included in this
>> list, *may generate errors included in this list under circumstances
>> other than those described here*, or may contain extensions or
>> limitations that prevent some errors from occurring."
>
> That same page says, however:
>
>   For functions under the Threads option for which [EINTR] is not listed
>   as a possible error condition in this volume of IEEE Std 1003.1-2001,
>   an implementation shall not return an error code of [EINTR].

Yes, but surely that's for pthreads functions, no? utime is not one of
those functions...
