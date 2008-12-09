From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 9 Dec 2008 11:57:33 +0100
Message-ID: <8c5c35580812090257w46dc3b75mc8f300ab396c82bd@mail.gmail.com>
References: <1228815240.18611.48.camel@starfruit.local>
	 <8c5c35580812090149lc6dd79cj60a9d23c18089557@mail.gmail.com>
	 <1228817565.18611.54.camel@starfruit.local>
	 <8c5c35580812090231u28076844nf5a9225349c20801@mail.gmail.com>
	 <1228819557.18611.80.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:59:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA0Im-0006Sf-B6
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYLIK5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYLIK5e
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:57:34 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:40061 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYLIK5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:57:34 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1756315wfd.4
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 02:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=LCkwJfYNURd8erxML8g9ugAWn0ESr1VmxpjEQNI/snQ=;
        b=PZBhK75PCd4GM/rQj+kRq2MhxGRHLXGMc8M+9FTa6yIGPEYo6bepCk4H5uvKiFt7pT
         nDXVB9QgpHwbC0pc3MaOgxBH+4PN2hRMW3eE0gkk96TmD2lbfDoRa6seQdEE/7nFc9D2
         7cqNmd0COjYH46S1BGBVkDt0aOYbUIncDArzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=FcXzQQ50SKxDqdYY5N7E8DlY/Zq0HdanWqxSESal3CtI7gfaJ70mS2Sjunb1Hao0W4
         77ldNXaowjSFZTc1N3OUZQ/ISgiLW7dSEyflARvBGNFtvrqg5wc3MibjygGg/OoBlixn
         kfG42Pc0Z8taCIw+tZF9bJrsT1u7L8i15LgV8=
Received: by 10.114.25.3 with SMTP id 3mr3120805way.103.1228820253495;
        Tue, 09 Dec 2008 02:57:33 -0800 (PST)
Received: by 10.115.106.12 with HTTP; Tue, 9 Dec 2008 02:57:33 -0800 (PST)
In-Reply-To: <1228819557.18611.80.camel@starfruit.local>
Content-Disposition: inline
X-Google-Sender-Auth: f61bd3f14f75b52f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102627>

On Tue, Dec 9, 2008 at 11:45, R. Tyler Ballance <tyler@slide.com> wrote:
> Really hate to take this much bandwidth up on the mailing list over such
> a silly problem, but after spending a week trying to /talk/ and educate
> some folks, I feel drastic measures need to be taken ;)

A possible solution could be the "Integration manager workflow" described here:

  http://whygitisbetterthanx.com/#any-workflow

But it has the potential of confusing your co-devs ;-)

--
larsh
