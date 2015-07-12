From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation clarification on git-checkout regarding ours/theirs
Date: Sun, 12 Jul 2015 09:36:33 -0700
Message-ID: <xmqqd1zxjpta.fsf@gitster.dls.corp.google.com>
References: <1436516877-21064-1-git-send-email-simon.eu@gmail.com>
	<xmqqy4inkc9c.fsf@gitster.dls.corp.google.com>
	<55A0A8EF.4080701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Simon A. Eugster" <simon.eugster@eps.ch>
To: "Simon A. Eugster" <simon.eu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 18:36:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEKF8-0005x5-HG
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 18:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbbGLQgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2015 12:36:37 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:32838 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbGLQgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 12:36:37 -0400
Received: by igcjr9 with SMTP id jr9so4811006igc.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=/qz0/W1TH+6/n5wczz1wJplYKbMebOBS4v1mCgGLHdc=;
        b=1GYliU6wxjaoxOuwCfvP8jBOfHAl+COnGxj7pXKLvd0Yanj9NkCpM0bQXHB72Vc1U7
         j4NzGf4Fr1DLCnNDnmrh04LFxPZlA6wwEBQOGqPrUfajErj/dvg2w9iS5jKgT/B2nGiL
         K6DfCmYqh4PRKULSfw+0BTjV6Uf/3HNNPT8kjEDqmxHDVbjPAPnArj3sey7xFBYhq9db
         6m1FwA9327weUU7tgTs/6MZMFO6I35U3jgUBstR+i1gkdjIUPKfGoErIBNGvyk+zoGYl
         P4j+FlNzmYP4IeHqQRFPahH5KeZlsK+Vtb29LxBw5F7w76cHhGBhG7L6RptRccElP5yE
         OB8Q==
X-Received: by 10.50.72.98 with SMTP id c2mr8528781igv.72.1436718996433;
        Sun, 12 Jul 2015 09:36:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b9be:d9fd:18d2:4319])
        by smtp.gmail.com with ESMTPSA id k2sm3798549ige.1.2015.07.12.09.36.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 09:36:34 -0700 (PDT)
In-Reply-To: <55A0A8EF.4080701@gmail.com> (Simon A. Eugster's message of "Sat,
	11 Jul 2015 07:26:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273895>

"Simon A. Eugster" <simon.eu@gmail.com> writes:

>> +...  As the keeper of
>> +the canonical history, you need to view the history from the remote
>> +as `ours` (i.e. "our shared canonical history"), while what you did
>> +on your side branch as `theirs` (i.e. "one contributor's work on to=
p
>> +of it").
>>
>>   -b <new_branch>::
>>   	Create a new branch named <new_branch> and start it at
>
> I think there is an =E2=80=9Cs=E2=80=9D missing in =E2=80=9C=E2=80=A6=
 and treat the work done on
> the branch =E2=80=A6=E2=80=9D, but not quite sure.

Thanks, you are right.  Will fix.
