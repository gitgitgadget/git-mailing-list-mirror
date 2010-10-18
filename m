From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv2 1/5] worktree: provide better prefix to go back
 to original cwd
Date: Sun, 17 Oct 2010 19:05:37 -0700
Message-ID: <4CBBAB71.4010503@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com> <1287185204-843-2-git-send-email-judge.packham@gmail.com> <20101016184259.GB30457@burratino> <4CBA63E2.8030502@gmail.com> <20101017094524.GA6034@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens.Lehmann@web.de, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 04:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7f6J-0000zA-V2
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 04:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab0JRCFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 22:05:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46007 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0JRCFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 22:05:11 -0400
Received: by gwaa18 with SMTP id a18so127799gwa.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=OAnmAoKQJRuWk/zgaMlGBBRbg9Ch1vz+4rNjq2IVmMI=;
        b=FszYegOSS0JFliLganoDQXJmgnmCYl64vBwcyRkH70Qv7qFj0NK+iewo0EhX2lUzJf
         xL+QQpOfrZTDVUXTlZVPTSiRVRNJsTlHQDZL2flFsLnzWIvINHpz1+4fIoE0D8emr++z
         +8H1lX+qOUtqsqCH3hVu+3hBADgn0UH14w06o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=i3wseh3OgZEr1ecfFA+2TFHSKGMNs5jQ8db9vdr6PADlG/mGqYx8+C4JcGEibb4c9j
         Og0NujEX6N9BAJ6/hSMSBY4uA4/VTGR+n8uUy2MHfoptIRW3nS55kERWOlTI8ih3KW/D
         NmymK81NeGVSgLTGIuu4c2whz9yhTclQbQ5UQ=
Received: by 10.100.240.3 with SMTP id n3mr2237057anh.233.1287367510903;
        Sun, 17 Oct 2010 19:05:10 -0700 (PDT)
Received: from laptop.site (m130436d0.tmodns.net [208.54.4.19])
        by mx.google.com with ESMTPS id w32sm19208308ana.17.2010.10.17.19.05.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 19:05:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <20101017094524.GA6034@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159226>

On 17/10/10 03:01, Nguyen Thai Ngoc Duy wrote:
> While at it, have you thought of support --recursive and
> --full-tree [1]? There are issues with --full-tree and prefixes [2],
> which is why it is dropped but I think it's a good idea.
> 
> --full-tree disregards where you stand and greps in whole repo. In a
> repo with submodules, that would mean grep the supermodule and all
> submodules regardless where you stand, even if you stand in a
> submodule.
> 
> [1] http://mid.gmane.org/7vk4xggv27.fsf@alter.siamese.dyndns.org
> [2] http://mid.gmane.org/7vskaqptvj.fsf@alter.siamese.dyndns.org

I haven't looked at those threads yet but it sounds useful to me. I
don't want this series to grow too far in scope so maybe this could be a
follow-up if my series is accepted.
