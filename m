From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable path if using argv[0] fails
Date: Mon, 29 Nov 2010 15:07:38 -0500
Message-ID: <BED9E026-6804-4ABF-A26D-8F20699BAD0B@apple.com>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com> <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com> <20101129171211.GL8037@burratino> <37CD335A-00A7-4074-BD39-4FCDEEB3D083@apple.com> <20101129185030.GB9441@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNA6i-0005p1-RD
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab0K2UNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:13:47 -0500
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:60179 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0K2UNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 15:13:47 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2010 15:13:47 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.outersquare.org (Postfix) with ESMTP id 12FAC53FC9;
	Mon, 29 Nov 2010 12:07:52 -0800 (PST)
X-Virus-Scanned: amavisd-new at mail.outersquare.org
Received: from mail.outersquare.org ([127.0.0.1])
	by localhost (mail.outersquare.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CClCHoshGQl; Mon, 29 Nov 2010 12:07:41 -0800 (PST)
Received: from [192.168.1.100] (c-71-235-225-119.hsd1.ct.comcast.net [71.235.225.119])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jeremy@mail.outersquare.org)
	by mail.outersquare.org (Postfix) with ESMTPSA id 4BF3753F7B;
	Mon, 29 Nov 2010 12:07:40 -0800 (PST)
In-Reply-To: <20101129185030.GB9441@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162419>


On Nov 29, 2010, at 13:50, Jonathan Nieder wrote:

> Jeremy Huddleston wrote:
>> On Nov 29, 2010, at 12:12, Jonathan Nieder wrote:
> 
>>> The section "2) #ifdefs are ugly" of
>>> linux-2.6/Documentation/SubmittingPatches explains the rationale.
>> 
>> I agree, but I don't really see a way around it here since this API is specific to OS X.
> 
> Did you actually read that section? :)

Yes, but I don't have the time to "do it right" right now ... I'm contributing the patch that we are using back to the community in the spirit of OSS development, but I don't have the time resources currently to "do it right" at present.  I'll come back to it once time allows if nobody else picks it up.

Thanks,
Jeremy
