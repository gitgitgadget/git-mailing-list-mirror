From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Tue, 11 Jun 2013 12:09:32 -0500
Message-ID: <CAMP44s0VksnZmi21u6T79AvMebWA3gXmWbQ6pp=FAHL=D4q6+Q@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
	<20130609191518.GB12122@paksenarrion.iveqy.com>
	<7vhah4d3sk.fsf@alter.siamese.dyndns.org>
	<20130611170815.GA20009@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:12:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmS6w-00052R-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720Ab3FKRJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:09:36 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:38460 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab3FKRJe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:09:34 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so2901755lbd.18
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZVPg39JsUPoMObessR+sRZnD1bIxJRcpY7KB9zLSfbQ=;
        b=gFnjc/hZYSLKEntqMEy2JdUAswMrP3UvXJ9mhOBDCqgsRHgJ2Qtluu0RbZtKgtUst1
         e+DnGNq9V3CXiGRsU4lRCDY7is1ZZ2UzPnsT7Cz/yTMECkq12XN44ZoyzghrQo4f6Rrb
         0Ya9ZbdDCBBRb7KwoMIqqjaFF6E0Oaju2/wdfTEoGwzvkyl/OhgyHrg0wzhvhJtl/pDs
         9yRjZegzEre87Z/QMzwp11Ov7hV6phpX5yxb3S9b3lZW8OcLwESiwJRgl8RHyx1XOF0v
         juNuLhY4bxrtIbvn6i0m/ij2BjblprNsMTy6JX83sU+MLG3HvgkLh1eJS1uviGswB0tQ
         biHA==
X-Received: by 10.152.5.7 with SMTP id o7mr4364478lao.43.1370970572734; Tue,
 11 Jun 2013 10:09:32 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 10:09:32 -0700 (PDT)
In-Reply-To: <20130611170815.GA20009@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227468>

On Tue, Jun 11, 2013 at 12:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Thank you for your reply. Although I agree with everything you say, it
> raised a few more questions.
>
> On Tue, Jun 11, 2013 at 09:12:59AM -0700, Junio C Hamano wrote:
>> Incorrect.  "git rebase" invokes "git am", not dot-sources it, so it
>> does not propagate.
>
> Then git am wouldn't be quite and this patch is doing wrong by removing
> the -q argument from the git am invokation. Correct?

It's not removed. It's simply moved.

-- 
Felipe Contreras
