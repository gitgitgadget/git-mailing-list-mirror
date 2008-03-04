From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC] git reset --recover
Date: Tue, 4 Mar 2008 02:42:13 -0500
Message-ID: <76718490803032342k18f05d4dte76aacd9292a1233@mail.gmail.com>
References: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
	 <20080303170242.GA30361@hashpling.org>
	 <46dff0320803032121v54612b40ke953348e86daf1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Charles Bailey" <charles@hashpling.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWRnY-0003Rj-Nu
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbYCDHmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 02:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYCDHmP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:42:15 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:20852 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYCDHmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 02:42:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so662233wah.23
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GvhOlsyk+TSQ4j08vfAfFM08LgQ0zaajy98a2etNPnw=;
        b=RkGjH7lMJolms+hNPdgQgqewxvppH1YMvYSMoTL0+siA84GiT6cMOWnGoVT4KBuREvcmI6vqAoT7vxcV17V5AysprS9ltXNGopAeMUIdYf+XF7ssdRSJxYy28IS77Oh2mMC5KNU8ou6GXUKnP3dGb2zFK05db8oXP7dYY8Bf1N0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iMgudY/kZRcrKOfUmjdoV0v3Z37csdtibCdkDdpAdPIpL+WO6jlFEUfM1fWMfJ5X428Asep+5Zy6Yd9XvYY5YfZh6bkPUydV0J0pMJRVBVAkmJLBo+ubMG08d1JUBX4eLUxe3eU5dfl6EFNtXFRVu6LQPxd7UwktUqjavvqw5pw=
Received: by 10.114.195.19 with SMTP id s19mr1564126waf.58.1204616533385;
        Mon, 03 Mar 2008 23:42:13 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Mon, 3 Mar 2008 23:42:13 -0800 (PST)
In-Reply-To: <46dff0320803032121v54612b40ke953348e86daf1f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76043>

On Tue, Mar 4, 2008 at 12:21 AM, Ping Yin <pkufranky@gmail.com> wrote:
> On Tue, Mar 4, 2008 at 1:02 AM, Charles Bailey <charles@hashpling.org> wrote:
>  >
>  >  Does 'git fsck' report some dangling blobs?  If so (some of) them
>  >  should be the content of your missing files.
>  >
>  Good news. So can "--recover" help me find the lost blobs?

git fsck --lost-found. Look under .git/lost-found/other for your blobs.
Anything that's not 41 bytes is a file.

j.
