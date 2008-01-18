From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 20:46:49 +0100
Message-ID: <47910229.90700@gnu.org>
References: <4790BCED.4050207@gnu.org> <20080118190509.GA3411@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:47:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFxBV-0000Ky-84
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 20:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760441AbYARTq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 14:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761077AbYARTq4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 14:46:56 -0500
Received: from hu-out-0506.google.com ([72.14.214.224]:42736 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759741AbYARTqz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 14:46:55 -0500
Received: by hu-out-0506.google.com with SMTP id 19so374438hue.21
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=v0M/ONh0zghAyKFUhmbHk81x0sY3usn4YLxJ9yayv+0=;
        b=ckkTqLS2xChjvRb1Hzx3xSfFRfq+Zu36x05D4AL+53qbMq7TRDBFJkY6U0OMVsk6exzfbV3qwTqHOZJoWEcxvb0w43Q74LFruV8TsQOj+jqCCO3q1CZva4gKyQeuDGBVxEQ4os47kpGT6zQiLZk/QvkHq0hIDe2CgGO3x0iQPwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=vUKUEirRUyJPXs2LC8XPHZupDcAjin6LBtralzS2cyx8doff1WKytnobAB2Xzv0KExZCTbYuyJ1V9HrOHitGLQRWU7h4F5RQcUVsNmx/vGgEw8+gbS/HmZ39do0kbld8VmpfrqfRU9wMZBPD5hH/Ft83zSz74dGYeCCveK38Iyk=
Received: by 10.86.36.11 with SMTP id j11mr3418170fgj.34.1200685610650;
        Fri, 18 Jan 2008 11:46:50 -0800 (PST)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d4sm4646251fga.2.2008.01.18.11.46.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jan 2008 11:46:50 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <20080118190509.GA3411@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71054>

Alex Riesen wrote:
> Paolo Bonzini, Fri, Jan 18, 2008 15:51:25 +0100:
>> +		if (!edit_message) {
>> +			run_hook(index_file, "prepare-commit-msg", git_path(commit_editmsg));
>> +		}
>>  		launch_editor(git_path(commit_editmsg), NULL, env);
> 
> "preedit-new-commit-msg", perhaps. A "prepare-" suggests it is called
> every time, even if no editor is specified, which it is not.
> 
> And it really does look like a template...

It is, but quite a powerful one. :-)  template-commit-msg?

Paolo
