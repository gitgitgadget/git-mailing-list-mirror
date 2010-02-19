From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: 16 gig, 350,000 file repository
Date: Fri, 19 Feb 2010 10:27:03 +0100
Message-ID: <40aa078e1002190127m4c9d5565obb792c77e29baf28@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <20100214011812.GA2175@dpotapov.dyndns.org>
	 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
	 <201002181114.19984.trast@student.ethz.ch>
	 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
	 <19325.40682.729141.973125@blake.zopyra.com>
	 <alpine.LFD.2.00.1002181556320.1946@xanadu.home>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 10:27:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiP8q-0005sk-6h
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 10:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0BSJ1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 04:27:12 -0500
Received: from mail-ew0-f216.google.com ([209.85.219.216]:48327 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab0BSJ1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 04:27:06 -0500
Received: by ewy8 with SMTP id 8so10480839ewy.29
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ELLNi0tWZR4RDxAfcuSX1sS4pcCnnmMIuRqxXy/QEgk=;
        b=s+fxJBMOtO/IFUlbDu8nzL7swcBCHeJI+XLPlWxpiFo4DtiLf6yLw/Fn3IBW4jHNxG
         lGRio99KavkpW2kKP3Cv4p68/agS4gGgu+WT5NaWhe/9MzCGbfzYLBaoByHvAbywQlqY
         mB0dr1KYutqbXyXEp4aYH91IoDnHcINiQjjtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=lJ0iE8g/GUdDtWbBREY1x14jl4YwZjkmehjc4/IyGf+gl46+j4YffFGZPxCe+e4s9C
         ilzUw8px9ni9nue0R23/krdZZfYhf+klJhJ28Bvx5AixGOU6i/EkGMmo/EaB3TjkGv3L
         zQoo0ENCLaGXfUnCl22kO9Gc7KFlRiRZlWqi8=
Received: by 10.216.88.207 with SMTP id a57mr949766wef.200.1266571623171; Fri, 
	19 Feb 2010 01:27:03 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002181556320.1946@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140438>

On Thu, Feb 18, 2010 at 9:58 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 18 Feb 2010, Bill Lear wrote:
>
>> I'm starting a new, large project and would like a quick bit of advi=
ce.
>>
>> Bringing in a set of test cases and other files from a ClearCase
>> repository resulted in a 350,000 file git repo of about 16 gigabytes=
=2E
>>
>> The time to clone over a fast network was about 250 minutes. =A0I co=
uld
>> not verify if the repo had been packed properly, etc.
>
> I'd start from there. =A0If you didn't do a 'git gc --aggressive' aft=
er
> the import then it is quite likely that your repo isn't well packed.
>
> Of course you'll need a big machine to repack this.

Something like this? http://www.gadgetopia.com/images/big_machine.jpg

--=20
Erik "kusma" Faye-Lund
