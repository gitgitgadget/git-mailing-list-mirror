From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 4/4] Re-implement 'git remote update' using 'git 
	fetch'
Date: Sun, 8 Nov 2009 19:43:53 -0500
Message-ID: <76718490911081643w46e34858kd82270be0482f8b9@mail.gmail.com>
References: <4AF6E865.1030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 01:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7IMS-0008Eb-SP
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 01:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZKIAnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbZKIAns
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 19:43:48 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:55867 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZKIAns convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 19:43:48 -0500
Received: by iwn10 with SMTP id 10so2034591iwn.4
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 16:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UVBVnhRa2/rGbV9Gew2jhF3GRvfKCxcQhHwINHZipMQ=;
        b=kYvzOsKXm0UZCzugFctqI0etrL9SZzAobyduiJ40+5dW6nUp/5FRMaKQozjJuM9cf4
         gvpP5JvaVn+S39cgsYGJDZy3gy2AIPRU2sgMwthAnmGGZV2GxL0Wp2bXJTj6e+njTlli
         vPLQU7J5ap3Z7CHZMtaht5HcBg44oAGe16FBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iYui5LqaHEiXP+jEawzFTpzfKWjde6Q7wZ/ufufL/drbB4X48HJe86QuvasJSMWKb0
         km3uqPehDVLwtvbt7MD2+u3sWfV5FtiMszJgX7fpAVPZovKpzJNFe/OGj3a5aaRCE7/x
         AryTTlF7J14+ZT92WD2hoLGefziacWJWKj2vs=
Received: by 10.231.168.131 with SMTP id u3mr3752348iby.26.1257727433540; Sun, 
	08 Nov 2009 16:43:53 -0800 (PST)
In-Reply-To: <4AF6E865.1030900@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132432>

2009/11/8 Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>:
> In order to not duplicate functionality, re-implement 'git remote
> update' in terms of 'git fetch'.

Junio, I guess I'll wait for this to hit pu and then rebase my fetch
--prune changes on top of it?

j.
