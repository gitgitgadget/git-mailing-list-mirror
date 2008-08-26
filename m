From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 22:58:37 -0400
Message-ID: <48B3715D.7020608@gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 04:59:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXomc-00060v-0H
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 04:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbYHZC6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 22:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbYHZC6p
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 22:58:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:1942 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbYHZC6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 22:58:44 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1036281yxm.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eZka90DcEpSLHdhaWx6OQmTYJsbd3OhpdBEST721X08=;
        b=EcqhzYfT5QDv4+Js6aN16o8YXqqLwYO5D9adgRreWlojjon05Vc5Hov8jfOuMnCB9v
         nMB1avaqmFVrxM3MRKh/nq9iOJHTQjPRLyJDx554faS6j6e29l+ebXR1n4UgbcJVzaxk
         9+9s4R6ePfmdR7foguVAdmO7oHPS1ejr3J0LA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=X7ooAFFTxL7OffDfNfaGNJ3z1UmUQi0KyO57gbKkCiHHmfmLJTWOXGZU+K3JQ9qGzh
         vBKBRhtqGUjTFT6+D0QJKowkf5CMePzZKTqexbnWQN1KuzPiKS9C+sbtWNucVVDSrhGm
         igUFszcTzOjWljSJKBVXxTv+u0PS9KtWWfzJA=
Received: by 10.151.108.17 with SMTP id k17mr8349022ybm.51.1219719523789;
        Mon, 25 Aug 2008 19:58:43 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id q26sm6248198ele.8.2008.08.25.19.58.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 19:58:43 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <1219664940.9583.42.camel@pmac.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93702>

David Woodhouse wrote:
> 
>   (C) Just don't do it. Leave the git-foo commands as they were. They
>       weren't actually hurting anyone, and you don't actually _gain_
>       anything by removing them. For those occasional nutters who
>       _really_ care about the size of /usr/bin, give them the _option_
>       of a 'make install' without installing the aliases.

Acked-by: A Large Angry SCM <gitzilla@gmail.com>
