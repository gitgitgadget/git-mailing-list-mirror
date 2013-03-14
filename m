From: Harring Figueiredo <harringf@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Thu, 14 Mar 2013 18:01:41 -0400
Message-ID: <CAN_hzmomGYpfh1MchCnrSwv3jv201DL2wLEXeYrG+=eNKwX4Yw@mail.gmail.com>
References: <CAN_hzmqrrue8jif3AJv4pZwmyMpQ6u558HaRX6dQKZCF0c_H1w@mail.gmail.com>
 <bcaec5396b50ba47be04d7e99955@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 23:02:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGGEI-0000bK-Kc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 23:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab3CNWCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 18:02:03 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38433 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab3CNWCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 18:02:01 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so3676691ied.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=zmICBqNok+IsFaGH+EMDs72q+57D17mDl+B+TfpSfeM=;
        b=TlAwBuw5gFYKZuuqgxmqx9teKh5rAG3YXrZN02Eai56Rgx76gaMlvyUfDFhEURFA3S
         wThFdWqpr3t4yzCUcmMD9bJvW74Bl7w9S848s+DEJ88/6CNBJMDLT09kDZSWRABqP7Sz
         i//tj1YdiIO5ER2lQo6ToahAplj5foVfNTd6n0x5ktUNjmQwqfpa0oj01FDObor08+Di
         IlLY7LtXtkcYZTqIhyZcSFL+HNdlMFBibJxLEMhSC2aBe5Qi/RkFmlNBrw4C9Yz5kbnO
         ByTST0VW8uMLRDURcZHUy6EZeFJovOoX+LFanttKSmsHl/xzXKJs0UEY2mwdOjPz/TmL
         +3MQ==
X-Received: by 10.50.197.170 with SMTP id iv10mr21547045igc.62.1363298521185;
 Thu, 14 Mar 2013 15:02:01 -0700 (PDT)
Received: by 10.64.38.166 with HTTP; Thu, 14 Mar 2013 15:01:41 -0700 (PDT)
In-Reply-To: <bcaec5396b50ba47be04d7e99955@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218173>

Hello folks,


 Just want to confirm that this is not a bug:

 <code>
 bunde.c: 443

  printf_ln(Q_("The bundle requires this ref",
                                      "The bundle requires these %d refs",
                                      r->nr),
                                   r->nr);

 </code>

 seems to be missing %d parameter on the first message.
 Please let me know if this is a bug or if it indeed should be like this.

 I am not a expert on gettext :-(

 Thank you!
 -hff
