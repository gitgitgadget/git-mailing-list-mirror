From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 19:59:58 -0300
Message-ID: <4BAD3C6E.4090604@gmail.com>
References: <20100326215600.GA10910@spearce.org> <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
	schacon@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:00:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIVh-0008CR-QC
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab0CZXAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 19:00:06 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:64879 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab0CZXAF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 19:00:05 -0400
Received: by qyk26 with SMTP id 26so6934425qyk.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Tlri8F2PjPBwRNnHvw9I4CkO9nvmO2m88jBHjkVfEoQ=;
        b=AMtdfEE5D5Ahu7SyfAgiuWkZYCJqOv4xm47I6e+jTHrypKJdyxhPNZscw08tdW19cb
         vFS7ycqWYEZ2snDQ3Hyz3JENBV0JaaA/Vs/8WtNLDt9/4r0XI6tDYcvv6FK0hqTUcB+b
         6RnuUi2AxkoLlwPzwJWMHRhpuIzgO6p05up3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=RWIO1tOiKHGwPAkF7op//NtUbrkXY1JmhhpwLlKhw0h3ZEQgH2tQ/fmqr8Tq4g5kpw
         41IXaqMG+5VdBRrGcsffnfY45aYAct1H9FR//Tl3h+Y/GdUwdkddPLCoW8VyQC3BhgbH
         oR2/fhtEUx3+BD0g1N+zTo0N7zrx5muPKdBBM=
Received: by 10.224.33.82 with SMTP id g18mr567998qad.102.1269644404522;
        Fri, 26 Mar 2010 16:00:04 -0700 (PDT)
Received: from [192.168.0.2] (hlfxns0169w-142068217168.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.68.217.168])
        by mx.google.com with ESMTPS id 22sm31062172vws.3.2010.03.26.16.00.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 16:00:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
In-Reply-To: <20100326222950.GB10910@spearce.org>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143295>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10-03-26 07:29 PM, Shawn O. Pearce wrote:
> Something I would assume was the project's source
> tree, not its notes tree.

Yes, it is the source tree. We don't even know what a notes tree is.

Apparently Scott Chacon has some clue about this error:
http://support.github.com/discussions/repos/2566-strange-warning-from-fsck-and-github-repo-using-too-much-diskspace
so I've added him to CC. (Note that changing all SHA1s is not really a
problem for us, there are only 3 copies of the repo, and the project has
only been using version control for 2 days)

Thanks, all
- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkutPG0ACgkQst0AR/DaKHuRtQCdEyy/KIWwpNYUA4EnkHGy2Y3D
chwAoLDzdhD9dmmn5mdkJxGrL5Kjlf4/
=k2Eg
-----END PGP SIGNATURE-----
