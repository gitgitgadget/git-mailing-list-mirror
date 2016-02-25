From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv18 00/11] Expose
Date: Thu, 25 Feb 2016 15:39:52 -0800
Message-ID: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com> <1456441708-13512-1-git-send-email-sbeller@google.com>
 <20160225231904.GT28749@google.com> <CAGZ79kYUkgbHSXYmOXRKhju1QQwiw9EU+VoO-AMZL_nMCf0NNg@mail.gmail.com>
 <20160225233513.GV28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:40:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5WB-0002e2-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbcBYXkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:40:15 -0500
Received: from mail-yk0-f196.google.com ([209.85.160.196]:34095 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbcBYXkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:40:13 -0500
Received: by mail-yk0-f196.google.com with SMTP id z7so1708351yka.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sHDGd/Cpba6nVzc7JjBUCBN4XpDpPbWTu4LDjPqHiTo=;
        b=szgIq3l7H0WdzbCnjmCQWi2SBMWFR5a0BdPui1tKIYxrgdZD+8upY6pBams2jY8vrq
         VBmHr+tIaGyBYpEEyMYWc4xUrEnBAnFiik53UUthQ/eLTH56EnwakcArIEL5nfXJR1D9
         Ps/53meH4X7TXrm4UW5gnxVbNOHR1r1pZwbF017FhSPEPWoOEsmyskFQP8YyFFX/xUA+
         sw9OQZ0FLZYB4Ixe1w4z3NGYq8+4spsmDoUcV2LkcZTe8UbT4PVJrPnvx+KYdulCIQH8
         sOz6CiDiBhvnxlYEVCyvTzGOJfIJiUmo5Pszp5XzhuJgcNpGP7CgYAxL9tFYCji8Nx1V
         8SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=sHDGd/Cpba6nVzc7JjBUCBN4XpDpPbWTu4LDjPqHiTo=;
        b=g9BG2o0XmkEtVW0+yEYl7Kc6WkLReKQveJyWgK1A4dTzxAeJKg67n4dY9G4Q3Aquzh
         Oj5BqznbK9NiXGi7AGWK9jF3Je9ifHrpfjB4sA2x8gb2lTkBEhhRr1pB00ZLmpjjnl/x
         U4Xzg+bFPlRCqaqxr37HbbgRdL37zLuDanIRRyjCDS0lVrMq3Q9q7t8tSQ791lZtR3h5
         ithgUfbdHwU7zDwqLwTSAspuyGrI4xLsymYg/3vbsxRlKsD903Tet707zDq9BVDuBABZ
         RGPGstrdTyz9Cd8AtIcgtKbVaOGzUdIxWjuGp36k/qqT4ri0p5vzjy2tuNkBAIYv9x+U
         5ZYg==
X-Gm-Message-State: AG10YOR+ehsIZuP/z094q+M2ih8aD9rsQPwjAaTga54sAxYM1zks/2+f3VCsGB83BvS3JsttDn/ipPyJawa+qw==
X-Received: by 10.37.36.196 with SMTP id k187mr26019074ybk.80.1456443612219;
 Thu, 25 Feb 2016 15:40:12 -0800 (PST)
Received: by 10.129.116.131 with HTTP; Thu, 25 Feb 2016 15:39:52 -0800 (PST)
In-Reply-To: <20160225233513.GV28749@google.com>
X-Google-Sender-Auth: SU1VHs92r7KbWDC-_kqlaJtecDo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287494>

On Thu, Feb 25, 2016 at 3:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Interesting --- git sets a GIT_PREFIX environment variable (in the
> same spirit as GIT_WORK_TREE) but doesn't read it.

I think that is because it is meant for helping end-user scripts that
are called by us;
they would not know where the end user started the process in, as one
of the first
things we do is to find the top of the working tree and go there.
