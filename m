From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: [PATCH] git-remote.txt: describe behavior without --tags and
 --no-tags
Date: Mon, 02 Mar 2015 14:36:24 +0100
Message-ID: <54F46758.4070207@gmail.com>
References: <54F431E8.3050009@gmail.com> <932c9cd452718ad5e88677fc90985ef7fafd5078.1425301543.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 14:36:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSQWO-0005Cy-S0
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 14:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbbCBNga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 08:36:30 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:43352 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbbCBNg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 08:36:27 -0500
Received: by wesu56 with SMTP id u56so33332397wes.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 05:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=JA8OhVdy5hbOWxhq+O4KOMQBpCWCai4VGi1hhDFAq9o=;
        b=fx7I3ztDRDr1gbNHNbCSTEI9rQW8H/D4JNZxdKrSljB1d72ZWzRXyhaLgwDDMY12Hw
         MHPmAahGTidFLtlYNueGNIaLrMZN3Fz06Mu6WhMEqbOKXXnoHWxtWLimWRwKANbWteH/
         Of+dqlvFatIuL1X4oDk3iLtSi6lmLLAvYR2UE3KWz+IMEGKKx9WiqItDSmFWsA8RIQXz
         zvSraHARVrYBakvLqYjtSG0PV4xVXDjnrvQl2D8Q45Lcv44z2m5FUvtQpgiESzSPoIdR
         p4djsQh/+elFwTw9kzsxqQmA3g9D0WT6PrmvmNdESuUx2lc2ynYPCuktA+zG61+aT9PF
         ijgw==
X-Received: by 10.194.61.244 with SMTP id t20mr56342642wjr.83.1425303385816;
        Mon, 02 Mar 2015 05:36:25 -0800 (PST)
Received: from [192.168.0.17] (gem13-1-78-228-1-221.fbx.proxad.net. [78.228.1.221])
        by mx.google.com with ESMTPSA id g1sm974419wjy.24.2015.03.02.05.36.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 05:36:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <932c9cd452718ad5e88677fc90985ef7fafd5078.1425301543.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264594>

Hi,

On 03/02/2015 02:08 PM, Michael J Gruber wrote:
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-remote.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index a77607b..f3f6f0d 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -56,7 +56,10 @@ With `--tags` option, `git fetch <name>` imports every tag from the
>  remote repository.
>  +
>  With `--no-tags` option, `git fetch <name>` does not import tags from
>  the remote repository.
> ++
> +By default, only tags on fetched branches are imported
> +(see linkgit:git-fetch[1]).
>  +

So the default is neither --no-tags nor --tags ?

Thanks.
