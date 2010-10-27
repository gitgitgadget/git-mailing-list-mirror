From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] Porcelain scripts: Rewrite cryptic "needs update"
 error message
Date: Wed, 27 Oct 2010 20:25:51 +0530
Message-ID: <20101027145548.GA1136@kytes>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <1287499168-26569-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 27 16:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7QQ-0001he-M4
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760919Ab0J0O4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:56:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40723 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760898Ab0J0O4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:56:17 -0400
Received: by ywk9 with SMTP id 9so449340ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2Uwa68IfJ9CEUJSxOLmsZThhFk+sYwwEuOtffs3MfQs=;
        b=e5d4uD8kkedkQj/3ypY5iHec1si/2Qfcw95rlQmvxmbGemsDCfJxHjglaS2i6PwkxI
         80mxCqDOu//89uecP9pMi4Xog+B9LUPmH+vkOm9+Pw4dejQhz6TqN3LENFxClsFyGev9
         CNp+z5+xPM3u6Wri3AO4B7OafUI49j3/DSmhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xeU7lVxG76oLaphlmBXDQKu4nmiesYd+gNOgg4HigXdd9jNCX0c+Tiw+sA4wyTXGvd
         wMGR01gqWoCbW3Jp8pH/yGYJ3Lwtk+fVT2F0gimnFtt3e1Peab1E0SzZq2v5wSHZSkiL
         L+Ra4kscKrrkR9m3eoIxL6xQ7D94NTPkFXk+A=
Received: by 10.150.211.19 with SMTP id j19mr301878ybg.446.1288191376999;
        Wed, 27 Oct 2010 07:56:16 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id z33sm7715134yhc.33.2010.10.27.07.56.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:56:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287499168-26569-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160075>

Hi,

Ramkumar Ramachandra writes:
> Although Git interally has the facility to differentiate between
> porcelain and plubmbing commands and appropriately print errors,
> several shell scripts invoke plubming commands triggering cryptic
> plumbing errors to be displayed on a porcelain interface. This patch
> replaces the "needs update" message in git-pull and git-rebase, when
> `git update-index` is run, with a more friendly message.
> 
> Reported-by: Joshua Jensen <jjensen@workspacewhiz.com>
> Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Ref: <1285877017-8060-1-git-send-email-artagnon@gmail.com> for v2.
>  Ref: <1285514516-5112-1-git-send-email-artagnon@gmail.com> for v1.
> 
>  Thanks to Matthieu for reviewing v1 and Junio for reviewing v2: I've
>  tried to attack the problem more conservatively in this patch. It
>  doesn't list paths, and doesn't print "generic" advice.

Junio: Is this patch alright?

-- Ram
