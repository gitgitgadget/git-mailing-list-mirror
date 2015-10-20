From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] Makefile: link libcurl before libssl
Date: Tue, 20 Oct 2015 13:20:18 -0700
Message-ID: <xmqqsi5570n1.fsf@gitster.mtv.corp.google.com>
References: <1444073043-24618-1-git-send-email-repk@triplefau.lt>
	<20151005194134.GD11993@google.com> <20151005201619.GA386@cruxbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:20:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZodOT-0000e6-Et
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 22:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbbJTUUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 16:20:21 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34031 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbJTUUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 16:20:20 -0400
Received: by padhk11 with SMTP id hk11so30948406pad.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4jLXZxhsJVs2a/leNMFXK5R5+wUENnOhIOdv1cvMl+I=;
        b=PcBGrgVTvGViGaGM1WIPdMGpdx/sDHSL83sav/zzv/Nqe1MfCwXzr+iME4yxfg8kP9
         uuG+qQDh51hnt7miO0MdhosfJQrTfZEfzsvoX1SOEMEEfuDTH8cgTtke/az7DfNuCDz6
         hM6ADdQyN9a4PTdZx/p8skxivCRh2TQgi8zK9Xe5ACiykathPr4SGegIxSatBwnlrhE3
         kwJJgnSRwMtKfVp0w/QuY6wLJ8lVh/rJni3LFdvJ+XALCLlOM6DOR4eiWs4rHPmjCN4b
         a5hylg7kOmDnzA/lS5ac9kocFmPoof8nOKXEGVd8HaWqLWXJw7LcxbSATtYI4Rqo7a+q
         p5bQ==
X-Received: by 10.66.100.165 with SMTP id ez5mr5859862pab.63.1445372419731;
        Tue, 20 Oct 2015 13:20:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id yz3sm5280349pbb.37.2015.10.20.13.20.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 13:20:19 -0700 (PDT)
In-Reply-To: <20151005201619.GA386@cruxbox> (Remi Pommarel's message of "Mon,
	5 Oct 2015 22:16:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279938>

Remi Pommarel <repk@triplefau.lt> writes:

> On Mon, Oct 05, 2015 at 12:41:34PM -0700, Jonathan Nieder wrote:
> ...
>> To protect against a value that might leak in from the environment, this
>> should say
>> 
>> 	IMAP_SEND_LDFLAGS =
>> 
>> [...]
>
> Oups my bad.
> ...

So, what's the status of this patch and other two patches (I
consider them as a three-patch series)?

Thanks.
