From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] Remove sq_quote_print() in favor of *_buf
Date: Wed, 31 Jul 2013 04:50:35 +0530
Message-ID: <CALkWK0mQx+5J_tGka6psemckvnqzp+jQF9+csN4HWBuwY=eoQA@mail.gmail.com>
References: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
 <7viozsxfcd.fsf@alter.siamese.dyndns.org> <7va9l4xe3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 01:21:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4JEG-00036E-V2
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 01:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239Ab3G3XVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 19:21:17 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:62787 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab3G3XVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 19:21:16 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so49953oag.25
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p56FqJgfLBy09ZnJxaBFlo0wh8bUUcaCNin+8Q1SFoE=;
        b=U/LB1XqmsIppXEoHs+s0TkeuLlFwsxl57N417HY8EW/rxaF/b/P5OE6K/p5bRdkECZ
         qfWRMQjA3oxaFkRH3p0GWBQXOg6X+TwJg/0vmKMDo3owKGdKQsQaW1af7CUlK5gdt43z
         hLPnUrKjVMv+APmHQ99Ej9G/MFkOEPIq3og4+WOrxSXLts6jebpYPfVkFtrEtRFHdfD6
         mznovQ1mqUuGTASaOnrHmuo77YUxJTLJqnhkn5HJfO30uOvIyWUW1eOYxagBBrTcV1nL
         6a4bTF/cjQGTDrssFI5A+IYTSBSsp7VkhCJ3p5xWw+7y2HKzWevTBXsRgcufh3cjJibM
         OAiQ==
X-Received: by 10.50.47.12 with SMTP id z12mr395425igm.50.1375226475970; Tue,
 30 Jul 2013 16:21:15 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 30 Jul 2013 16:20:35 -0700 (PDT)
In-Reply-To: <7va9l4xe3k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231399>

Junio C Hamano wrote:
> Having said all that, the patch texts all look OK, so I'll queue
> them with updated log messages.  It was the usual me reacting to
> unjustified value judgement made in log messages and cover letters.

Thanks.  I'll look at how the log messages are different in the queued
version, and adapt accordingly next time.
