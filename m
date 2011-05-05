From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: t5541: Bad file descriptor
Date: Thu, 5 May 2011 13:59:36 -0400
Message-ID: <BANLkTi=y+34s+yO9LVuiUxB5Xz3v7Pc2Mw@mail.gmail.com>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
 <7voc3hbtgu.fsf@alter.siamese.dyndns.org> <20110505054611.GA29033@sigill.intra.peff.net>
 <20110505061634.GB29033@sigill.intra.peff.net> <BANLkTin8YUwoMmxXLske=5nuvW+idBOuig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:00:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2qI-0000cD-Lt
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab1EER75 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 13:59:57 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61202 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258Ab1EER74 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 13:59:56 -0400
Received: by qyg14 with SMTP id 14so1833725qyg.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=fJQNhUTS0tkKRWbmX6JVG70PaPfJ2eTWOu/bkx80rd8=;
        b=vEk3OBHLNrAFsN1SSByBLCNb0roxxdE5ZhFIpU8xQO8nSGWFjjEkr/qKfI5HRsHLY2
         jSHBa56Ck2XJ30OK0G6Jx40vgTwd6oe2p1V3Uyq7O5Hg9i46n/OqvnL74S0aFGPLbPxG
         JYo4hPy2zxZYE+0Sl3saVoF0S32HdvxHC8BXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FfbSS7l1mrQS7VynTMi1AWFRy5A3D+JaSBCWM4agIfLJt84C3/nd6wBN45KTU9ZgSL
         tDtjP5skKZEdSQc+99eZ3ba/Z/rJK2gtSJ8buAYhXItBJN5ICGovO5dBUvRzj35iML89
         2m5TKT/VeOX3O7+Jk0vT63OB32fHSlM6WLxsk=
Received: by 10.229.77.12 with SMTP id e12mr1790061qck.147.1304618396132; Thu,
 05 May 2011 10:59:56 -0700 (PDT)
Received: by 10.229.188.141 with HTTP; Thu, 5 May 2011 10:59:36 -0700 (PDT)
In-Reply-To: <BANLkTin8YUwoMmxXLske=5nuvW+idBOuig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172861>

On Thu, May 5, 2011 at 7:18 AM, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
> On Thu, May 5, 2011 at 08:16, Jeff King <peff@peff.net> wrote:
>> OK, embarrassing. 09c9957 completely breaks smart http pushing. My
>> testing of Johannes' patch was completely focused on the error case,=
 and
>> I didn't have a single test for the non-error case. And on top of th=
at,
>> we _have_ nice tests in the test suite to catch this, but obviously
>> neither I, nor Johannes, nor Junio were running them (because they n=
eed
>> apache installed and GIT_TEST_HTTPD set).
>
> Wasn't someone, I _think_ =C6var, or maybe Avery, (I could be totally
> wrong) running a buildbot of git.git on various platforms? If so,
> maybe they can turn on these tests since they aren't often run?

I was running one, didn't think anybody cared about it though.  Please
point me at the necessary docs for this test and I can set up a new
one in my copious spare time (tm).  I can't promise to monitor it
though, so that might be more of a problem :)  gitbuilder does produce
rss feeds that are easy to track.

Have fun,

Avery
