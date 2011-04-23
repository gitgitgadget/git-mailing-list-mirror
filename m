From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 5/5] Date Mode: Tests
Date: Sat, 23 Apr 2011 03:59:11 +0000
Message-ID: <634e602c-d8cf-469d-a241-bda689715ade-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 06:04:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDU57-00005t-3g
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 06:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828Ab1DWEEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 00:04:13 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43193 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab1DWEEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 00:04:12 -0400
Received: by pvg12 with SMTP id 12so545990pvg.19
        for <git@vger.kernel.org>; Fri, 22 Apr 2011 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=SX4PRSpUtl9BQuersAWCtl8ZkvQtIE3QoSm8UoMe1cY=;
        b=ak9LMoAGOF4a6lFYjJC3jAKYLWEQlZO8tk5JkN8U3Y9SAIpGoAzHNlV2RlzFosQlF5
         3hnzkSL72wyNgJpuMMrUqqv3rHlT8pUPKaUSvsTZiuBwYdmNHiwNkZpd+t0P4dEtONLA
         dexzyVvcGQxwbji6kgICKvPsqAnO/2YaAqS4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=WzrfGHN03uklpqFywh++n07ocQZ6bDZZ7EjaLAVZ3jTvd9Q13hXQH4QVEGMmeA093F
         YKEZZURSKDKGcopf6Sip6SazeF9UhcC5h+3gQ1jaSrlru0VBJqmrlChnEvOC5PY5Op0p
         XJrjhRjUI+zLSqILWQ45ClE7LGoCp9XMDQD8I=
Received: by 10.143.137.6 with SMTP id p6mr1014812wfn.305.1303531451937;
        Fri, 22 Apr 2011 21:04:11 -0700 (PDT)
Received: from gmail.com (tor-exit-router36-readme.formlessnetworking.net [199.48.147.36])
        by mx.google.com with ESMTPS id o1sm4704677wfl.21.2011.04.22.21.04.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2011 21:04:11 -0700 (PDT)
In-Reply-To: <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171951>

On Wed, 20 Apr 2011 02:45:23 +0000, Michael Witten wrote:

> +	foreach (@formats) {
> +		$expected{''} = $expected{$ARGV[2]};
> +	}

Woops!

Well, I guess nobody read through this patch (including myself) :-P
