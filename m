From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule 
	working directory in git gui and gitk
Date: Thu, 7 Jan 2010 01:22:37 +0700
Message-ID: <fcaeb9bf1001061022j57981a90x249f82c6dfd2f92d@mail.gmail.com>
References: <4B3F6742.6060402@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
	 <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
	 <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
	 <4B4498BC.5040400@web.de> <7vbph7181x.fsf@alter.siamese.dyndns.org>
	 <fcaeb9bf1001060923m6559f00bp794bb5fdd4af704c@mail.gmail.com>
	 <7vljgbw21x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:22:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSaWv-0003zv-R5
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 19:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539Ab0AFSWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 13:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540Ab0AFSWj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 13:22:39 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:48375 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530Ab0AFSWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 13:22:38 -0500
Received: by pxi4 with SMTP id 4so611447pxi.33
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=pGahInQJctu4izwstm8+4r4zTznM51CzGZWWRLdpRz8=;
        b=om209v7TL13LdnFcZ9itAjGGfd5ODJ0zKSUUQ0Bwa0uEA5Pkdu26Oo59Un8nblzRcs
         xfbXHQ6C9YkQ+HYOqRNjEeDmsTYlf+GpeT41Ul6uiBYcqT+Deo/xlYZys8pSuNiRyCIG
         2ulC/8oKLJZ/lI6IhgPJDJBDt//ExaZTalDi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DJ6YE34exlNOdu6tpMKyYqRGSrVHtD4XegxuOLprLLHJVc7jlnUk+r4eu74kvUOJiP
         iT3DwlTUmfbCDvFBXlGfs9/D5PBqaXQdfT4voNfIp7pi+DmNe9ayUY5CnbMd0U1GyAcR
         Yluyn4AzizDPEXesfXD+U7V3hIYwJt470JmZ4=
Received: by 10.114.248.33 with SMTP id v33mr33823wah.77.1262802158232; Wed, 
	06 Jan 2010 10:22:38 -0800 (PST)
In-Reply-To: <7vljgbw21x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136284>

On 1/7/10, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>  > You would need to rewrite file paths so that files in submodules are
>  > also relative to the same directory as files in supermodule (I tried
>  > to do that with GIT_WORK_TREE and needed to change a bit). Or you
>  > could show each "git status" output separately, which does not look as
>  > nice as the former in my opinion.
>
>
> You could show output separately if you want, but I think that is a
>  separate issue.
>
>  I was envisioning that the "git status" in submodule will be run with its
>  recent --porcelain option, and "git status" or "git commit" would read it
>  to postprocess and incorporate into its own output.

Nice option! I had to call a few "git diff" for that just because I
did not catch up with recent Git development :-(
-- 
Duy
