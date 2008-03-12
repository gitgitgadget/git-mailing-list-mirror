From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v5 2/5] git-submodule summary: show commit summary
Date: Wed, 12 Mar 2008 10:30:35 +0800
Message-ID: <46dff0320803111930r5ffe10b8k49a777ce3481643@mail.gmail.com>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
	 <46dff0320803111908m3f370ebbj89ee0511bb086cb0@mail.gmail.com>
	 <7vwso8adxh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 03:31:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGkN-0004zy-AC
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYCLCah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYCLCah
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:30:37 -0400
Received: from hs-out-0708.google.com ([64.233.178.249]:8985 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbYCLCag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:30:36 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2053656hsl.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ul6I49aBuKUbxUQopT3T2NSlj3KXLM4t7rpnMNOKUxI=;
        b=qCy1bFwbtQAKgyPWXepJ1fZlgcm/qiQ/AjtpmagNVU/Hx6kHqz5DvltmQjkvO2ShWnkaq8q7yMHEwIDSIB5VLgKCQ4CoMYHFt6ja2azpRlCoc0OlaWoDOFqZrk01Qb0vjHJs8N+vkMeUnE3xGZ7mQa/f1rqJ5VGtmKI8+eVd6eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nZn1BpNR2azkZCwLFnoHFg/H5wL3sezonVhFHCVt5oqLHbXkkrqc8dIVyRdPsGEF1JNz0BF7yrlntypHgS8N4lZYXXkBmkHf1agjODgd34YdKLSvMFd4batgn/e5qWXI7XxlOCXkP6MgIU/QsxSfLZZBUl00ZgtgeRubloL7HhU=
Received: by 10.100.153.6 with SMTP id a6mr14675916ane.91.1205289035588;
        Tue, 11 Mar 2008 19:30:35 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Tue, 11 Mar 2008 19:30:35 -0700 (PDT)
In-Reply-To: <7vwso8adxh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76913>

On Wed, Mar 12, 2008 at 10:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > On Tue, Mar 11, 2008 at 9:52 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  >> This patch does the hard work to show submodule commit summary.
>  >>
>  >
>  >> +                       case "$mod_dst" in
>  >>  +                               160000)
>  >>  +                               sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
>  >>  +                               ;;
>  >>  +                               100644)
>  >>  +                               sha1_dst=$(git hash-object $name)
>  >>  +                               ;;
>  >>  +                       esac
>  >
>  > please s/100644/100*/
>
>  How would that help symbolic links?
>

I am not familiar with git core code, could you tell me where to find
all file mod for various types?



-- 
Ping Yin
