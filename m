From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any
 file, fail properly
Date: Tue, 17 Dec 2013 23:28:25 -0500
Message-ID: <CAJYzjmdscmEVuT29wMVoeUoUag=0H-XDq2tkLPRtHEr51kOk5Q@mail.gmail.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
	<CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
	<xmqqsitrmkhe.fsf@gitster.dls.corp.google.com>
	<CALWbr2zXNF-aJHHnBnW1q1yaCmWt-rmMWypBWFanTBAK1pMWiQ@mail.gmail.com>
	<xmqq4n67m8og.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 05:29:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt8lE-000321-Le
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 05:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab3LRE2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 23:28:46 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:65197 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab3LRE21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 23:28:27 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so7549819oag.25
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 20:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=907lenSB889W/M9FUyYcrtYleXsaktQoQmL3Fr48m90=;
        b=s9kZS6ime1VNCH2VmlFlu/sB4Hd2usHQCmOGw5wK0ECSDHZjnSZtAxagsc00alH0+O
         YVCndbdGVxQxwBHBFU+7uHJ0GadZIHiHBRsftFycMRMGLUJvoONgg/sIM/z68n8wcBPY
         z4h9tNu1fgBd9j260RalaWM3+pezVaE8GfyRhwB3Q3rasOI2Vm3ViUJV26VEcH3Nufwr
         FCgHlr7wu7sFW0UTkM9OcJJge8NKJ0CbBfizzeZf0XtefZtUOwLSu/FBjXzHaOtcT14l
         TBoAk/piU/ahugHc+JfYdWPYBDz1PgXTXXk1alzEM86mwLoZVzF0Qplq70nV9+tFLs9i
         0COA==
X-Received: by 10.60.51.161 with SMTP id l1mr65253oeo.69.1387340905967; Tue,
 17 Dec 2013 20:28:25 -0800 (PST)
Received: by 10.182.135.3 with HTTP; Tue, 17 Dec 2013 20:28:25 -0800 (PST)
In-Reply-To: <xmqq4n67m8og.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239421>

On Tue, Dec 17, 2013 at 5:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> My point was that I did not see much value in reading the orderfile
> data from anything but a file.  At that point, you are not testing
> the "diff -O" orderfile option, but if strbuf_readline() reads from
> a non-regular file.

Oh, good point, now that you state it explicitly.  I'll remove it.
