From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sat, 3 Nov 2007 07:50:51 +0800
Message-ID: <46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	 <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 00:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io6IA-0000re-Qf
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 00:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbXKBXux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 19:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbXKBXux
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 19:50:53 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:28167 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbXKBXuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 19:50:52 -0400
Received: by py-out-1112.google.com with SMTP id u77so1813043pyb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0mxdYPX+ppAgWj2t7ZkVTD5whv8DwXDOxAbbSefV0o4=;
        b=jW7bzWT6MzQJ7pREM5DuAstsYx627K2oPJDyr5QTw43DrB9sTXROXAewOmE3IcrtT9vgA9r8lHXYSidv//EOQmUogQe4JAKwaLBSAjs4w+MivinA/PjpkVygH2cYU4KhpS2xFhKv28Jkv+ZPGTdE9iJSFHXmO3AnwKqEf8Z6i2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qqsd52iSVyCDFGFA+ywa/zwWWlm/N3gFn0K65Tcnk/F5h7/9Vc/c5TSFzsPR0b87kZ488OzFueBD7yjz7+oQ8sgh+KgQMeFANg/j9EQvZl7T3g8KkP75hweH+25qcndwwjxP9LK7WtAwxWzCHuVNznxLzj6n86B5uLZQ6AsS7Ts=
Received: by 10.35.116.12 with SMTP id t12mr2645336pym.1194047451863;
        Fri, 02 Nov 2007 16:50:51 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Fri, 2 Nov 2007 16:50:51 -0700 (PDT)
In-Reply-To: <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63193>

On 11/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> How does this work when you are a toplevel developer and do not
> have the submodule cloned and checked out?
>
> Our code should treat having the submodule directory and not
> having it when there is a mode 160000 entry in the index equally
> likely.  Cloning and checking-out is _not_ the norm (nor the
> exception).
>
When submodule is not cheched out, it is never modified. In this case
modules variable will be empty ( since git diff --cached is used) and
the corrosponding module directory will not be checked. So the output
will be the same as the original output.



-- 
franky
