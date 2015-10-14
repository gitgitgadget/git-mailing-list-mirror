From: Junio C Hamano <gitster@pobox.com>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 13:48:29 -0700
Message-ID: <xmqqtwpt6usi.fsf@gitster.mtv.corp.google.com>
References: <561E5C5B.3090207@alcatel-lucent.com>
	<vpq4mhtbjma.fsf@grenoble-inp.fr>
	<xmqqoag18i6w.fsf@gitster.mtv.corp.google.com>
	<vpqmvvl8fb1.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyY-0003i0-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbbJNUsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:48:33 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33272 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbbJNUsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:48:31 -0400
Received: by pabrc13 with SMTP id rc13so64201087pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GWN9U+4SjBrAuAHd+LGw7cSmSOIJijUTXRnx85LBB50=;
        b=n4jR676uY/eR+nMeUxGoQedM6u+xJFvC/ePMWWVfkiBJafASZpdWElZfrlg3FH47hO
         cA2msiwQ+sY61UDL60ojj+Nc5jD6F+N07Z7xXkagJE2QWIfkranZAplD1bDW/jzNNqK1
         Xoc1G3iExP11XfbJ8k7/sQ3U33woDMCjFK/rA16i6gnRh0yHIv5PkBrP2LRhSZYsjm1b
         DRnlBCyy119b9EPoa2odDnvt7jnG035/CiaMRraxWqpQdLifJ3t/fRgtmTcxQMjDyG3B
         EGjUcUs+QqyeLjVB+0L4dG8wenC/pXXg/TnTImFEqOIdl4jrL7qruYWl8QL66l8Iw6yE
         9h9w==
X-Received: by 10.68.164.98 with SMTP id yp2mr5579582pbb.125.1444855711272;
        Wed, 14 Oct 2015 13:48:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id ah2sm2470364pad.10.2015.10.14.13.48.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:48:30 -0700 (PDT)
In-Reply-To: <vpqmvvl8fb1.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 14 Oct 2015 20:40:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279622>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Looks good to me. I think the same should be added to git-prune.txt
> under --expire.

I thought about it, but decided against it, as the command is not
even recommended to end users.
