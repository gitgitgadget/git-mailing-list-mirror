From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Date format in 'git log' should be in local timezone
Date: Fri, 17 Jan 2014 16:28:48 -0800
Message-ID: <20140118002848.GC18964@google.com>
References: <52D9C69C.2020006@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 01:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4JmU-0001dw-Of
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 01:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbaARA2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 19:28:55 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:44587 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbaARA2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 19:28:54 -0500
Received: by mail-yh0-f46.google.com with SMTP id 29so1605662yhl.33
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 16:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pKw1AYjYs+gpaT+2ltX6Uj0dG91kG2ovMb8YB1NLl/c=;
        b=pW7wS7VNUDYBEV4gTdphIJxE/+EiR846305Yofn8gIBOPmta4RzkTa1Lx+q+haMe4r
         WC+8Pm38xNkWwVqaiOoXNlbmg/0Lxens8+Lq11jC6q2rsTQttzDEuEuTa4BmkJU7vcnZ
         ZC1tVkkfcOzjdDEJ/a6daD8X6PVP8Gf80SNZLWVX4pYzqfhlHhg4MHv4QjXSBV1He9Nk
         F0gh4Kd/qNvTLqO3VyFAWf/22Vg5ONZ7wDQFAADNsfgReOH0BtSb9VPaHifGVw/TIbZs
         E5aj+PyKemTzS5PXpZmMBpDCSzpoaKlD4P46QZeTGwjHsl7xnULBzMhibnb8gq88RcD+
         sFWQ==
X-Received: by 10.236.87.1 with SMTP id x1mr4514356yhe.51.1390004931782;
        Fri, 17 Jan 2014 16:28:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h80sm21164716yha.23.2014.01.17.16.28.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 16:28:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52D9C69C.2020006@rawbw.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240640>

Hi,

Yuri wrote:

> Timezone here doesn't help the log reader at all. It doesn't even
> reflect the actual location of the submitter. Instead, it should be
> converted to the local TZ of the client. This will make it easier to
> read and understand the time.

Does "git log --date=local" or "git log --date=relative" do what
you're looking for?

If so, you can set that permanently by setting 'date = local' or
'date = relative' in the [log] section of your ~/.gitconfig.  See
log.date in the git-config(1) manpage for details.

I wonder if 'date = relative' would make a better default.

> Even further, timezone shouldn't even be stored by the git server.

I've found it very useful and would consider that a regression, at
least.

Thanks and hope that helps,
Jonathan
