From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] tests: print failed test numbers at the end of the
 test run
Date: Tue, 26 Jul 2011 11:25:21 +0700
Message-ID: <CACsJy8CuqHSoG4PVMiT=5EUv2hn=42y5B+6Rhny2VkXW32WR8Q@mail.gmail.com>
References: <4E2B1DF2.4000003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 26 06:26:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlZDa-00057j-Ia
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 06:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab1GZEZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 00:25:56 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:50730 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1GZEZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 00:25:52 -0400
Received: by eye22 with SMTP id 22so76613eye.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cX77bDeauQkQw0cyULEk9cokRa46yDuHqLQtvvvQTzw=;
        b=RbN3pVnmRj+KjgcnTcQetSzCatCAy4koGW4m0QJPcAx2DqGpMk8ayLSW8Yih11fWCC
         0Gq2tD2hS8CaTo2koWyg+yLuZK8SbXFir1ZeKGOuAHVHmPY0RxVgP20c1tj70pwzLLHL
         ytRpkR5NcUexOFLbXfwopMlP7ayCHXHzp9aFk=
Received: by 10.204.131.213 with SMTP id y21mr872736bks.88.1311654351128; Mon,
 25 Jul 2011 21:25:51 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Mon, 25 Jul 2011 21:25:21 -0700 (PDT)
In-Reply-To: <4E2B1DF2.4000003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177839>

On Sun, Jul 24, 2011 at 2:16 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> On modern multi-core processors "make test" is often run in multiple jobs.
> If one of them fails the test run does stop, but the concurrently running
> tests finish their run.

Somewhat related (or not). I change something. I know it breaks things
and want to know _all_ tests it breaks, but "make test" would stop
early. Is there anyway to make it keep going through all tests even if
some fails? "make -j<big number>" improves the situation but does not
really solve it.
-- 
Duy
