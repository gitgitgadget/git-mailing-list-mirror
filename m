From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 5/5] grep: use parseopt
Date: Sat, 16 May 2009 02:44:15 -0700
Message-ID: <4A0E8AEF.3000704@gmail.com>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain> <1241725608.4772.11.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 16 11:44:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5GRf-0003g1-Lx
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 11:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbZEPJoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2009 05:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbZEPJoS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 05:44:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:22704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbZEPJoR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 05:44:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1276918rvb.1
        for <git@vger.kernel.org>; Sat, 16 May 2009 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hS2MMMpFCn/P06v/51qvexe1qTAvxdQyq/CCuhBDO9k=;
        b=hT7/CJDwxNEJ2tKrtOhpVqIoElEQcxnxuNG/bhUz5RZ0GQaRgEaMD0lhHO62KZ4ySC
         NoJIx73c5XmcscmmxiW59Pu2HiLQqsKnzKoIendEcBU8t42KU2RnZmP2jPWg5/NgPZmh
         SjQ3a7cSYhSJbtwKkA54tQq/yg+qTY7nT/ErU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RK6UTcxt+c9N9DUHf5y1jzwtt6MXVceFI4j4pcDXqmMdb5SH8s9L0Y2+DZQ3LfoXhP
         qUAJy5RnXlDN2De8wJFBLVK2B+zBAx5zpVcBGol57jqWrcXYvy6j9oOuU9hBzp0VFMbx
         Z1U2KNNVOaxOtPuiRxHcI/RQghucPdVsoPMzs=
Received: by 10.140.247.13 with SMTP id u13mr1909780rvh.288.1242467059016;
        Sat, 16 May 2009 02:44:19 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id g31sm6482911rvb.43.2009.05.16.02.44.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 02:44:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1241725608.4772.11.camel@ubuntu.ubuntu-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119349>

Ren=E9 Scharfe wrote:
> +int context_callback(const struct option *opt, const char *arg, int =
unset)
> +{

Shouldn't these callbacks be static?
