From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v4 2/5] git-submodule summary: show commit summary
Date: Tue, 11 Mar 2008 09:52:13 +0800
Message-ID: <46dff0320803101852j421646e6t5b8c71b656c72935@mail.gmail.com>
References: <1205171657-16216-1-git-send-email-pkufranky@gmail.com>
	 <1205171657-16216-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Ping Yin" <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 02:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYtg9-0006FL-7q
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 02:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYCKBwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 21:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbYCKBwP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 21:52:15 -0400
Received: from hs-out-0708.google.com ([64.233.178.241]:43685 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbYCKBwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 21:52:15 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1643749hsl.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 18:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dxcTnAGJXmeq5G6DRX/o763WdUSZmnaJ9/BIS201pLE=;
        b=R7JF0oVzPJIaZkhSJwcjeiOSEPqKWogHyT9VVwYhdTchrljP0dN1zOxe1Qr5qK87KPM05RKRBHppMslId8gjM+JiuRZh/0e5OV/EVZyHx+IKjkMZo5v095+bfWnUU5DbkEDuiQ2cSgYIfSQpH/MrXVrV3d6SEdzedikbv2Tr09M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwIEl3ct5ZtMgVxfvyJzeJVUY3PnHlCGrpAp1FpLlsygx+0pbSv99s3I9BDhANHoQRADkin988H6y8KOaoJABDEUviKjhOhOPrmutIqO1xz7dCOQhDewkurGqC8mOk8/vxFcCqwE5GXOxKjhGdq9y7kAyRavUxxTKhLdP1RDpJE=
Received: by 10.100.168.18 with SMTP id q18mr12130284ane.55.1205200333948;
        Mon, 10 Mar 2008 18:52:13 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Mon, 10 Mar 2008 18:52:13 -0700 (PDT)
In-Reply-To: <1205171657-16216-2-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76782>

On Tue, Mar 11, 2008 at 1:54 AM, Ping Yin <pkufranky@gmail.com> wrote:
> This patch does the hard work to show submodule commit summary.
>
>  For a modified submodule, a series of commits will be shown with
>  the following command
>
>         git log --pretty='format:%m %s' --left-right \
>         --first-parent sha1_src...sha1_dst
>
It seems that --left-right makes no sense when combined with
--pretty='format:%m %s'

I originally thought --left-right will make left-side commits always
appear before or after right side commits, but that's not the case.
Actually it seems that --left-right doesn't influence the commit
order.

Is my understanding right?

>  where the src sha1 is from the given super project commit and the
>  dst sha1 is from the index or working tree (switched by --cached).
>




-- 
Ping Yin
