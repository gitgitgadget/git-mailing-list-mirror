From: Jon Forrest <nobozo@gmail.com>
Subject: Re: A Basic Git Question About File Tracking
Date: Mon, 03 Oct 2011 18:14:24 -0700
Message-ID: <4E8A5DF0.6040003@gmail.com>
References: <j6dlhf$dp3$1@dough.gmane.org> <20111004011035.GA13836@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 03:16:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAtcV-0004mR-TO
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 03:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab1JDBQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 21:16:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51578 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab1JDBQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 21:16:27 -0400
Received: by ywb5 with SMTP id 5so4015794ywb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 18:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0zXyo7AROz7ylFJAcMBWaH5H5+1DnpcyFgy81U9ygEw=;
        b=TQ/grlapxDldfEWzumSgJtMIpH6/EnT0ujr1bCd8fPuG1E55U80MKuTWq0MGycre2i
         Lft/S+KaF1K0fUo1N0nImCmQ8t8uErckw9b8WuJ2atfaw1mFv5ILGM082znAYUEcRvhZ
         9Yp2xHzGWXwBZOzitAiRtMRpXRHYbZk6Psics=
Received: by 10.68.31.132 with SMTP id a4mr5463847pbi.26.1317690986372;
        Mon, 03 Oct 2011 18:16:26 -0700 (PDT)
Received: from [192.168.0.107] (c-24-6-237-93.hsd1.ca.comcast.net. [24.6.237.93])
        by mx.google.com with ESMTPS id e7sm31505760pbq.1.2011.10.03.18.16.25
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 18:16:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <20111004011035.GA13836@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182721>

On 10/3/2011 6:10 PM, Jonathan Nieder wrote:
> Hi!

Thanks for the quick reply.

> Jon Forrest wrote:
>
>> The Pro Git book says "Untracked basically means that Git sees a
>> file you didn=E2=80=99t have in the previous snapshot (commit)".
>
> Yep, that's a bug in the Pro Git book.  "Untracked" means "not in
> the index", nothing more, nothing less.

But your definition doesn't include files that
have been committed. In the following trivial case
in a new git repository

cp /etc/passwd x
git add x
git commit -m"fooling around"

is "x" tracked? Your definition says it isn't
but "git status" makes me think it is.

Sorry to be so pedantic.

Jon
