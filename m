From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Mon, 11 Oct 2010 00:23:57 +0200
Message-ID: <AANLkTin-P1Q8n-+weSODiLGVfUQYae6m3MzW51Yms68X@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-3-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com>
 <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
 <4CB22FF3.5070503@gmail.com> <AANLkTinBE14dWCecXvpH=8N1b0H=9j9tc=t07d_MHEFF@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 00:24:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P54Jo-0004MY-Fv
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab0JJWYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 18:24:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44654 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0JJWYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 18:24:18 -0400
Received: by gyg13 with SMTP id 13so566806gyg.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=xG9ltiPG7E+yQRGvFY3gq93fZoSsnWVrK7684zRqK6o=;
        b=r47El9ZwhEifrIE6WB66orfR16FMnn8VByofkFl0NxWkCmolFf7VtiKoWJJVSnJVSW
         raF3w+AtBrjA40yQ1CGg5NIlyxIWCGnIJlZsySF5Kl5ljc6oiFKGAvX3RzAZv8CfFC84
         ww4J10gnJR6e7//8Q+E4euvN98NtSGv2zy1zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=wyG3YpVVJuk+6ny1nIFNWT1gJ4V81uXfNm4Sys3VoAiIvxTpWdjqlFaqzaoUVufgkw
         YgbRr4uQoc898sj7VukEyKT1gpszM7k88sfapDEla/JB3d02Zxf47eqZyr1l7Awc/Tmh
         IplHE+Y5mjeQbQez/+Cgqtseit9Fr2nBuOgsE=
Received: by 10.236.109.170 with SMTP id s30mr10417314yhg.3.1286749458232;
 Sun, 10 Oct 2010 15:24:18 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 15:23:57 -0700 (PDT)
In-Reply-To: <AANLkTinBE14dWCecXvpH=8N1b0H=9j9tc=t07d_MHEFF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158727>

On Mon, Oct 11, 2010 at 12:16 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Sun, Oct 10, 2010 at 11:28 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
>> On 10/10/2010 4:37 PM, Erik Faye-Lund wrote:
>>> Are you suggesting that we report an error when we can't report the
>>> string correctly? We could do that, but I'm not sure how the end-user
>>> would benefit from that. ReportEvent is used to report errors (unless
>>> the --verbose flag has been specified), and reporting that we can't
>>> present an error message strike me as a bit confusing... Even the
>>> corrupted error message is probably better :P
>>
>> I am not suggesting reporting an error. As a first-time reader of the code,
>> I was trying to understand the presence of the comment which did not really
>> seem to relate to the code. Perhaps adding a "FIXME" to the comment saying
>> that the condition should perhaps be handled in the future would help to
>> explain the comments presence.
>>
>
> A FIXME would certainly a good idea, if I don't just end up supporting
> varargs here.
>

Uhm, excuse me for confusing the different comments :P

Yes, a FIXME should definitely be added. And I definitely need to seep now! ;)
