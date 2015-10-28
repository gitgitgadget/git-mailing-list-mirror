From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Wed, 28 Oct 2015 23:35:04 +0100
Message-ID: <9A4A2FFA-BCF0-46B6-A3A5-69D7F197FDA5@gmail.com>
References: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com> <56273197.3010505@diamand.org> <F77F291C-89D1-48B6-9E9F-AD7220CE0141@gmail.com> <562E8FA2.9050507@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:42:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZPx-00086E-5v
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbbJ1WmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:42:00 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35630 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbJ1Wl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2015 18:41:59 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2015 18:41:59 EDT
Received: by wmll128 with SMTP id l128so13722672wml.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w5xTEzSWtYwIMPilpE0dk6A76TcYdSC8qStTwqOMaXc=;
        b=Q4/me+0IpVsTsGrN+917lB3w10x1aDM0Ad8oViRJze3Yrfm1w4aUTMgTKHcMb7tt3C
         f8CA1lOWsBaamVvAM6/PyxD6OuchsU7XviPv92QDIffdD8y6rOsL2uB0WiPLThqcKVEo
         +Z5iCOT91yY9I16p6z74ERw2psoOsC6wGXTXNZXlLX/0QuzT8JFtQ3/hWTNfc09nfbmF
         IA0W7n0cU0AAVJb+sW9a3eAPS1kTtGXQe4r4qsEuI2YugSqD7n3GxRR2hiUZDLRoKHcb
         XmYQmDvrRbqtB34rS/gqLdtwhIZdkJS7fYchgqLyhI3ZI1r0fxbf4uTFyajf3IRd5Ah/
         t/vA==
X-Received: by 10.28.87.208 with SMTP id l199mr2833893wmb.43.1446071701537;
        Wed, 28 Oct 2015 15:35:01 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB72B9.dip0.t-ipconnect.de. [93.219.114.185])
        by smtp.gmail.com with ESMTPSA id jt9sm36612550wjc.24.2015.10.28.15.35.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Oct 2015 15:35:01 -0700 (PDT)
In-Reply-To: <562E8FA2.9050507@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280418>


On 26 Oct 2015, at 21:40, Luke Diamand <luke@diamand.org> wrote:

> On 24/10/15 19:08, Lars Schneider wrote:
>> 
>> On 21 Oct 2015, at 08:32, Luke Diamand <luke@diamand.org> wrote:
>> 
>>> On 19/10/15 19:43, larsxschneider@gmail.com wrote:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> 
-- snip --
>> 
>>> Also, could you use python3 style print stmnts, print("whatever") ?
>> Sure. How do you prefer the formatting? Using "format" would be true Python 3 style I think:
>> print('Ignoring file outside of client spec: {}'.format(path))
> 
> Will that breaker older versions of python? There's a statement somewhere about how far back we support.
The "format" method requires Python 2.6 according to the Python docs:
https://docs.python.org/2/library/functions.html#format

Luckily this is also the version we aim to support according to Documentation/CodingGuidelines

Thanks,
Lars
