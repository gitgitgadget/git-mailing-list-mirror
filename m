From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 0/3] Bye bye fnmatch()
Date: Wed, 19 Dec 2012 20:21:28 +0700
Message-ID: <CACsJy8CO7PdcVtK+CvmFn=BX-PBQUh8wwo=Y8Mk1-dZ+TGq7kA@mail.gmail.com>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 14:28:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJgw-0004mE-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab2LSN1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 08:27:53 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:62177 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2LSN1w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2012 08:27:52 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 08:27:52 EST
Received: by mail-oa0-f43.google.com with SMTP id k1so2005800oag.30
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SWngzeh70IJZL7oYc2s4xAPAkXrxHUkPzDj9hKGCVdM=;
        b=wDmwfEOcVSAR03Hl0VfOJexHjkSimtD0SlJ17KVStq4pdXotF565gdakOegjtNR0o1
         4lqduPunQtCzgSkWVRU6KtO3Fl88OQo3g7Wlobh+m3qDN0NsXcgb0da90J0CC7EXf95Y
         8Dbk2eQv4ytu0H0vpJdRIMn6BcEKo+lrN0mqqsKYEQRrMTtPeaHCswfODlE6upvSB6fF
         X/uKaGTrubLqZoStqIqi1YvcSo4MQM/dnyVSR/aDPHRfEaNbx/yeLlxOA43JWX82/swA
         YlYTUE1QqkOl1wXD34h7nE3goNlULJgT9uyc9GvfQmzxsxU25BerDQmpvEH15QPtzYmL
         N9yQ==
Received: by 10.182.212.2 with SMTP id ng2mr4667718obc.81.1355923318347; Wed,
 19 Dec 2012 05:21:58 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Wed, 19 Dec 2012 05:21:28 -0800 (PST)
In-Reply-To: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211822>

On Wed, Dec 19, 2012 at 8:08 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> For those who have not followed, nd/wildmatch brings another
> fnmatch-like implementation which can nearly replace fnmatch.
> System fnmatch() seems to behave differently in some cases. It's
> better to stay away and use one implementation for all.

Oh I forgot. Case-insensitive matching will be available to everybody.
On the other hand it'll be a lot more work to (implement and) use
other FNM_* flags like FNM_PERIOD.
--=20
Duy
