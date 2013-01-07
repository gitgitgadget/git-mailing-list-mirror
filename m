From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] t5002: check if unzip supports symlinks
Date: Mon, 7 Jan 2013 00:52:06 -0800
Message-ID: <20130107085206.GI27909@elie.Belkin>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E9B82D.50005@lsrfire.ath.cx>
 <50E9BB8B.9020101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 07 09:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts8Rc-0007ZR-31
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 09:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab3AGIwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 03:52:12 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41639 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3AGIwL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 03:52:11 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so10608848pad.21
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 00:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SLh7h/jXpzdEwPw0ob2zBLMmeQYh9sDc+bGiXSX/hv4=;
        b=YHWHnHSEG7BBtTkk04LsCLLd1i36oor09ZJK2Qo3H+P92//hwPIdGlFh6Ro46zFElM
         ieXUNx4LvQ223hMOxhEtTp7lS4SVZ8g0Lbryy67MQyV2mrGUkHEnm65aqDZ4zuAUmULM
         aY/DWfW67X6Deezi9sGx5rN1IlIfHBlG2yej1vsVmXk3ztY/VQcF6Lj7UhvOmm7g+py9
         gfJkwGdq9X4t1Kj2i3yxo4RySGp0wlbU8BXu09wZ01lnGkdlxKTii2ghBqWT+QsemxcK
         ef8zZw6ALGKU+glaOKnlTdqOiOMOzu2Y1IEn5RRP/UX/rUc7tBYLwO9k+de5cP5taeoC
         5ARQ==
X-Received: by 10.68.232.101 with SMTP id tn5mr186078716pbc.125.1357548731294;
        Mon, 07 Jan 2013 00:52:11 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ov4sm37283458pbb.45.2013.01.07.00.52.09
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Jan 2013 00:52:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E9BB8B.9020101@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212887>

Ren=C3=A9 Scharfe wrote:

> Only add a symlink to the repository if both the filesystem and
> unzip support symlinks.  To check the latter, add a ZIP file
> containing a symlink, created like this with InfoZIP zip 3.0:
>
>	$ echo sample text >textfile
>	$ ln -s textfile symlink
>	$ zip -y infozip-symlinks.zip textfile symlink

Hm.  Do some implementations of "unzip" not support symlinks, or is
the problem that some systems build Info-ZIP without the SYMLINKS
option?
