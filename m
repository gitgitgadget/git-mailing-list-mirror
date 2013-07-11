From: Brian Gernhardt <mister.reus@gmail.com>
Subject: Re: t0008 hang on streaming test (OS X)
Date: Thu, 11 Jul 2013 12:13:14 -0400
Message-ID: <DBBE19C0-BEF4-46FC-9CB3-7BAA26F493AC@gernhardtsoftware.com>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com> <20130711133414.GF6015@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJUc-0000cZ-P5
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446Ab3GKQNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:13:14 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:57241 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab3GKQNN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jul 2013 12:13:13 -0400
Received: by mail-qe0-f51.google.com with SMTP id a11so4470698qen.24
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=1DLuur30Jfu3mgVvnAVdboUGXqnIm1MYJNfxp5C4O5c=;
        b=sXfzZb3MlsGlT7rbIB1O9fYLaS5SOzNfrndUur99kWyof86RCtP14CPzbNZ1cgcYjA
         SF2BVLArr5rE3kTiWHVLNCiOvas+vIULJcwvckq80Q0wsOuIreACsN4FY7QoSQoDRJTB
         RWtsb1S5mx5JRYPPkvDyKj8Dbyz03uF3mpNrOfWNGYTAvM6GJRPF189g+2/3bsmEaBXs
         kFHirDCVpa0Qbt/3OMvvBfJOUW5bGDlXup3IVoFWUxIeAdhGfdNkdjZtIKvjX2/nC9Ai
         ctJafPyPE2mVkinM2j2vWbSaECauiGtViV9iCD+JlkVU2+Cuwsy5gEjWMf+YM7OQlfBt
         DpUg==
X-Received: by 10.224.65.202 with SMTP id k10mr33599780qai.69.1373559193126;
        Thu, 11 Jul 2013 09:13:13 -0700 (PDT)
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com. [142.105.190.134])
        by mx.google.com with ESMTPSA id i1sm30399643qas.10.2013.07.11.09.13.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 09:13:12 -0700 (PDT)
In-Reply-To: <20130711133414.GF6015@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230112>


On Jul 11, 2013, at 9:34 AM, Jeff King <peff@peff.net> wrote:

> On Wed, Jul 10, 2013 at 12:36:40PM -0400, Brian Gernhardt wrote:
> 
>> The newest test in t0008 "streaming support for --stdin",

>> Experimentation has led me to find that it is hanging when trying to read the 2nd response from check-ignore.


> Do you know which test it is hanging on? You mentioned that you can
> replicate it outside of "prove"; what does running with "-v" say?
> 
> The last test in t0008, with the fifos, would make me the most
> suspicious.

The 2nd `read response <out` line is where it was hanging, based on a variety of echos added to the test.

~~ Brian
