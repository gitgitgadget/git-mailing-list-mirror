From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Deciding between Git/Mercurial
Date: Tue, 29 Sep 2009 03:55:41 +0200
Message-ID: <4AC1691D.5050600@gnu.org>
References: <h9nlhj$heq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Tue Sep 29 03:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsRx6-0004uG-Um
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 03:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbZI2Bzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 21:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbZI2Bzl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 21:55:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:15545 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbZI2Bzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 21:55:40 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1648264fge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 18:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=uarwyviqlr7hisTMUKovPiGZlA3P6Cc1OAnH/1oAImc=;
        b=m0ng41uTZDxPka9oBFlrEOewFtPyJMAhCTvn+wvq5bM/yWG1dbClzg0cu2bOCznyxa
         lfbfNmdNGYdh9mfXDS3NIRbILa8IkxDdwJB/pKcGFnpbn2ekbiTuXdm6g/uNUThd8PKm
         NUFQrGSgRxeuyX1x3x3hJVZFb7TVBLQYTtUvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nJuNgjoV7KZ8HLibnuRE9491ZpsqCuA/ppQmMUFGz4/kfvaftF9uFyQcBF00I3c8LZ
         g8nCweZPkFf987+l6awyZbMITtjqogc34RdgMm2JdgTFGKKhAHBbJuuUqFIRbqT59Goq
         BfzTVbbDyDJl7ELyNN1nA6+z9dYehZV2INyig=
Received: by 10.86.227.1 with SMTP id z1mr3793473fgg.56.1254189343637;
        Mon, 28 Sep 2009 18:55:43 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 12sm117432fgg.14.2009.09.28.18.55.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 18:55:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <h9nlhj$heq$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129280>

On 09/27/2009 02:24 PM, Anteru wrote:
> What's
> the rationale behind this decision for git, and is it possible to
> emulate Mercurial's behavior somehow?

While not exactly the same thing, 'git describe' is very helpful in 
comparing versions (if you know that one is an ancestor of the other).

Paolo
