From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Commit to wrong branch. How to fix?
Date: Fri, 4 Sep 2009 19:11:18 +0200
Message-ID: <40aa078e0909041011s7639cccbqa758f17a56c61863@mail.gmail.com>
References: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>
	 <4AA13DF4.4050604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Howard Miller <howardsmiller@googlemail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 19:11:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjcJs-0006cb-KK
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 19:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933714AbZIDRLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 13:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933655AbZIDRLS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 13:11:18 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:41358 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933599AbZIDRLS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 13:11:18 -0400
Received: by qw-out-2122.google.com with SMTP id 8so285808qwh.37
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=uE8KOUNwLKgmAHP6moiGs6eZrawIRyK9Gid9+lShOtk=;
        b=sjZOsZCFFXMJtU0TdQwWpZ3+kxLjmjpabQh/zybXccEJPsO0dZ9xCJOglaf5uWEdFQ
         5nucK6Sbn/qKIuXR7z57eK+N/257L4I+Eg3tm8MAqhJFf2/uC47KM85Uo4EPG5npfoZv
         XM7glFdWGqMZsCxqi92o4xI6zu9hf26EeCW7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vCn5jTS9QQXNyQN+h2N9YXrKTkhzPNhMZFeVm1/YrtjIlTKbpEt2sJMZTOAJBWFU0j
         T5OoPMO5Hr1vNGOQC9kr/Pps5hk1FS5bH2Ds+xRdX4htYjnIbhkfoz+P3izS0Wv6+7cT
         eD9gV/6CYdF3m9MYly+/7sXQrjWR7Bw7GFm/w=
Received: by 10.224.95.196 with SMTP id e4mr7643452qan.180.1252084279083; Fri, 
	04 Sep 2009 10:11:19 -0700 (PDT)
In-Reply-To: <4AA13DF4.4050604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127748>

On Fri, Sep 4, 2009 at 6:19 PM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
> Let's say "geesh" is the branch on which you committed by mistake, and
> which you have reset.
>
> git reflog geesh

That should be "git reflog show geesh", no?

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
