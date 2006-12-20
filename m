X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Change in git-svn dcommit semantics?
Date: Tue, 19 Dec 2006 19:07:30 -0800
Message-ID: <m2vek76z9p.fsf@ziti.local>
References: <m2mz5jegka.fsf@ziti.local>
	<94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 03:07:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=odAzew1jZmy35jVK1oKuPC60OoAmnAhLiQhf7pqGvBpBs2kYtqtIhZ74ViFf6HqdGl7qXNsXSsTXSHoMwEyPqYzdtVM0/5edj9tNKEdq8vo94TOW+DfhUWA1KEXO//C+LLiIh2cY+ncFGp3AFdmvhxElOR1e7Az00O+rqSXRouY=
In-Reply-To: <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com> (Brian Gernhardt's message of "Tue, 19 Dec 2006 18:02:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34904>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwrnu-0005F2-3f for gcvg-git@gmane.org; Wed, 20 Dec
 2006 04:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964799AbWLTDHf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 22:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWLTDHf
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 22:07:35 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:5152 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964799AbWLTDHe (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 22:07:34 -0500
Received: by nz-out-0506.google.com with SMTP id s1so808099nze for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 19:07:33 -0800 (PST)
Received: by 10.65.188.4 with SMTP id q4mr8438664qbp.1166584053631; Tue, 19
 Dec 2006 19:07:33 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 f14sm9399858qba.2006.12.19.19.07.32; Tue, 19 Dec 2006 19:07:33 -0800 (PST)
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Dec 19, 2006, at 4:12 PM, Seth Falcon wrote:
>
>> git version 1.4.4.2.gee60-dirty
>> (the dirty is a hand edit to Makefile for prefix)
>
> Just FYI:  You can save Makefile variables in a "config.mak" file
> instead of having to dirty your working tree (and dealing with
> conflicts, etc).  For example:

Hey, thanks, that's much nicer :-)

