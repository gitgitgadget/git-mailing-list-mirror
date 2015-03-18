From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug in git-verify-pack or in its documentation?
Date: Wed, 18 Mar 2015 19:31:19 +0700
Message-ID: <CACsJy8B=S9ajzj9N-JoCou6_FVj9VgCHEkZ2AiQ=zR=aCLKXuw@mail.gmail.com>
References: <20150316080558.GA30234@glandium.org> <CACsJy8AXvYCje0-smbNdfGtjsdYieKyxxiHCGf32Jpi3seDrvA@mail.gmail.com>
 <20150316131808.GA19353@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 13:31:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYD8e-0000yc-KS
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 13:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbCRMbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 08:31:52 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36195 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717AbbCRMbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 08:31:51 -0400
Received: by iegc3 with SMTP id c3so36910212ieg.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xfjthK5FW5rhUyRXdfwzqxmDIgG+cuKSed4MUdTB1mM=;
        b=Qcd0e2yWWvHx+wsijVEMXIi2RYU9obw3DGyUWa5cFXcQr1Bjn7Xic3IQ65JmQQLBob
         lkZ0bwRHJNHo4+1qv9h/YvsdX6LZ7CTTBlRfK56Ler+B3TezqqSwrkr+3V67UePDmZrG
         we+0J0K8DW20qiXvESJfryMC132mRcMOrWLVqJfEu52pebBT+oVuFVQ+STgkg9sRA0IV
         Yi8NHD8nfyCJb22k6UhHSkZlHAEEj1VL2ZUkDF/8PABO+ztNVqcaX8PmDCyfG7W2qLj8
         nAG1RXT3/sohmHXy36Ru3sRuT9IvaXxB4xETh8tGPAniPZG2iJD1ha92yd4xK6EGghYK
         2akg==
X-Received: by 10.107.16.158 with SMTP id 30mr33096580ioq.2.1426681910937;
 Wed, 18 Mar 2015 05:31:50 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 05:31:19 -0700 (PDT)
In-Reply-To: <20150316131808.GA19353@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265725>

On Mon, Mar 16, 2015 at 8:18 PM, Mike Hommey <mh@glandium.org> wrote:
> On Mon, Mar 16, 2015 at 05:13:25PM +0700, Duy Nguyen wrote:
>> On Mon, Mar 16, 2015 at 3:05 PM, Mike Hommey <mh@glandium.org> wrote:
>> > Hi,
>> >
>> > git-verify-pack's man page says the following about --stat-only:
>> >
>> >    Do not verify the pack contents; only show the histogram of delta
>> >    chain length. With --verbose, list of objects is also shown.
>> >
>> > However, there is no difference of output between --verbose and
>> > --verbose --stat-only (and in fact, looking at the code, only one of
>> > them has an effect, --stat-only having precedence).
>>
>> There is. very-pack --verbose would show a lot of "<sha-1> <type>
>> <"random" numbers>" lines before the histogram while --stat-only (with
>> or without --verbose) would only show the histogram.
>
> Err, I meant between --stat-only and --verbose --stat-only.

Yeah --verbose is always ignored when --stat-only is set. This command is funny.
-- 
Duy
