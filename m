From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] builtins: do not commit pager choice early
Date: Mon, 5 Apr 2010 23:16:51 -0500
Message-ID: <20100406041651.GD30403@progeny.tock>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
 <1270492888-26589-44-git-send-email-pclouds@gmail.com>
 <20100406040145.GA30403@progeny.tock>
 <20100406040612.GC30403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:16:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz0DE-0003aU-GG
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948Ab0DFEQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 00:16:24 -0400
Received: from mail-yx0-f200.google.com ([209.85.210.200]:48725 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0DFEQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 00:16:22 -0400
Received: by yxe38 with SMTP id 38so1059047yxe.22
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 21:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uPjCcWWosxVwRLcJxWIUgBjq49y9ybtWa2HEMLzvAOM=;
        b=dY5HI8Ob78BIW1BMfBPCNkvPbLw1CB3pglpy8nlzjkzfJ0GDuGNYq8ebH85yAoqEvx
         DZrcSgLwYy1vYYWtcdKEJkPWO7mfZ/DaZ6ZB9XkPRsGICcddN1+raNylM1en7urpxRVH
         ApFLJ0rpbcS7O45J4aWq/MRNgWEqvWUnoutw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SRt0FZdh3lQ/n0Q2kc2vdmcUXJMcRoriKXvb2zMKSkiZPkG45kl31oVF4SpFsyhZZ2
         8iI8/f5MqhXJk4e/TDDTAwhkLfUOjJiPUAuYfnReUD5EJXpmRkpFBu0CUrUixaR7m16U
         s7SlBx79n9an7I36mMraSuRmqWpBbXCbp570Q=
Received: by 10.100.51.15 with SMTP id y15mr15463408any.30.1270527382155;
        Mon, 05 Apr 2010 21:16:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4090417iwn.6.2010.04.05.21.16.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 21:16:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100406040612.GC30403@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144094>

Jonathan Nieder wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

I forgot a pseudo-header field:

  From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Sorry for the trouble.
