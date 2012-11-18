From: arif <aftnix@gmail.com>
Subject: Re: using multiple version of git simultaneously
Date: Sun, 18 Nov 2012 17:04:50 +0600
Message-ID: <50A8C0D2.3000001@gmail.com>
References: <k886on$nn5$1@ger.gmane.org> <1353163831-ner-9354@calvin> <20121117161631.GA18844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 12:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2gl-00047c-H3
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 12:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569Ab2KRLFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 06:05:06 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33901 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2KRLFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 06:05:03 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2775104pad.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Q7tXYw10HfM9n0cykxoJDehqhp3tkhaFwQ+TFGghKLA=;
        b=IQIhPkYfGvXlzx7e9wfxRctGleOjmS6vOhUzOtvMDjnedrsd2JxvRlNvSEnvAFa8Zm
         wlEmpFytTmu0gaCqjkgNPZhm/Xrdtlk5pb4oMsRvjSAuDcU4/pQMGkmW+7JTvx8NnVcg
         WZrSG4No9hPa2BioYRkyKy7ifRqOwuIX7Yy1qRjn5kJzPJmakcbG52MXL2gIuCFYAEat
         +OoxNaMxWSVFImQCU12wK/W8LXcqh8tUsa01NNQY1jSnLyZ8OZ61L9gEpyhDKxzG+jej
         ElcEyr7u6FhbU0E1e59yiH+J+CrBVcRx+rcUXulDt9D7qlbYiUlBCpy0yNPBxpjTGrTP
         gQCg==
Received: by 10.68.197.9 with SMTP id iq9mr30139185pbc.130.1353236702717;
        Sun, 18 Nov 2012 03:05:02 -0800 (PST)
Received: from [192.168.12.23] ([103.23.169.3])
        by mx.google.com with ESMTPS id hc4sm4355293pbc.30.2012.11.18.03.04.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 03:05:02 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20121117161631.GA18844@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210021>

On 11/17/2012 10:16 PM, Jeff King wrote:
> On Sat, Nov 17, 2012 at 02:50:31PM +0000, Tomas Carnecky wrote:
> 
>> On Sat, 17 Nov 2012 20:25:21 +0600, arif <aftnix@gmail.com> wrote:
<snip>
>
>> Install each version into its own prefix (~/git/1.8.0/, ~/git/1.7.0/ etc).
> 
> Once you have done that, you can also symlink the binary from each into
> your regular PATH (e.g., ln -s ~/git/1.8.0/bin/git ~/bin/git.v1.8) to
> make it easy to switch between them. The installed exec-path is baked in
> at compile-time, so it finds the correct git sub-programs properly.
> 
> I keep a couple dozen built versions of git around like this for quick
> regression testing of bugs we see on the list.
> 
> -Peff
> 

So what you are saying that, making a symlink for "git" is sufficient. I
don't need to make symlinks for ever git subbinaries.

Is that correct?


-- 
Cheers
arif
