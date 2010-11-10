From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase: allow -X for non-recursive strategy
Date: Wed, 10 Nov 2010 19:55:01 +0100
Message-ID: <AANLkTi=v+KUHDXYDWQXfpar+_jgMJgCn+TRuq1pPNKwB@mail.gmail.com>
References: <1289336299-28282-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101110085554.GA10282@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 19:55:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGFpV-0003an-2J
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 19:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681Ab0KJSzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 13:55:25 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52818 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613Ab0KJSzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 13:55:23 -0500
Received: by yxt33 with SMTP id 33so83455yxt.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=b3fdKkj6DWbXBnTlS788DnhTOLgMzjSIvKYFVjBS9vU=;
        b=jo2Jpn8CwYXCYwcgqbpwy5dbIp1wOzdMkKJpovDdg+cYvViSfpsRackYSUxKPZA0KN
         ajQvAanLvGWcLlL6/DXlRmt8HKzsYLIi3IIpQoCZI8nmIe54bb0FscCM4qeoi7uuPFiA
         ZQC6IDHltHcbU9SIMlmo7wq5dCjvvO+Tr0k/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jIIAI04pKVZva7zSl8JZ8ZsS1SjGHH23+Pz7FvoaePO3qCNIqvkaIppKH8WaGlZfhG
         FOg3LkV+QJAhN//59Q7gupTLZXf6n/MtRwDiPFC0L23BPcPypCNj/vnk8MD/ISTlEpTY
         MD5eQW4likf2aa6FWnZUqdQzThBgqQwMmOmPI=
Received: by 10.150.178.2 with SMTP id a2mr37133ybf.255.1289415321344; Wed, 10
 Nov 2010 10:55:21 -0800 (PST)
Received: by 10.150.158.17 with HTTP; Wed, 10 Nov 2010 10:55:01 -0800 (PST)
In-Reply-To: <20101110085554.GA10282@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161168>

Heya,

On Wed, Nov 10, 2010 at 09:55, Jonathan Nieder <jrnieder@gmail.com> wrote:
> This fixes a regression introduced in v1.7.3-rc0~67^2 (2010-07-29).

Can has test?

-- 
Cheers,

Sverre Rabbelier
