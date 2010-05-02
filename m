From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sun, 02 May 2010 09:50:55 +0100
Message-ID: <1272790255.4258.11.camel@walleee>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
	 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
	 <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 10:51:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8UtH-00088D-P3
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 10:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab0EBIvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 04:51:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59046 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab0EBIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 04:50:58 -0400
Received: by wye20 with SMTP id 20so1053204wye.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=C5ucLyH1xukNbkMM7SEQ+dlu6DpjX7dYiuJbbo+hwdU=;
        b=NZ0BmFLOZB4iYoBJsp4nrl2yMshDWy6jzsz7URo5PZxiXEvv/D+CjrKCeM92GgE2J3
         FbKdH7dpO9Qc4RivHOFXRqlNIjXzlK7vdB8NXUiuePvpPVfpY4bKuc8TS0YJJk7FKWUr
         +Q+zKFQ1qJorrATV4ByRqSBywHdERscCiMXRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=FOBf6HgEW2/vfNQlkIMO3BoePp+yKlQcTDhhj/0PxrBYLDgaQWprXiEAwG/0Pe9CKb
         4UrIz35WiHLaWilaCb8wE7gB/a4Nc4vKDCulWeXykPcL+ODL9g3Sy9TiiY3QWdDSMioI
         QO6C7IBNJ0xdqQxnDRUlK/31eKnjFSvj9uSQ8=
Received: by 10.216.89.202 with SMTP id c52mr6929343wef.84.1272790257005;
        Sun, 02 May 2010 01:50:57 -0700 (PDT)
Received: from [192.168.0.4] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id u8sm30891721wbc.23.2010.05.02.01.50.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 01:50:56 -0700 (PDT)
In-Reply-To: <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146144>

On Sat, 2010-05-01 at 20:13 -0700, Junio C Hamano wrote:
> I think it is a good change to make %h follow --abbrev, but %H should stay
> the full length no matter what (otherwise why would anybody use %H not %h?).

I could just as easily say "why would anyone pass --abbrev-commit unless
they actually wanted an abbreviated commit?". Synonyms are confusing,
but ignored parameters sound more confusing to me.

While I disagree that --abbrev-commit should have no effect whatsoever
when %H is involved, I agree that the link between %h and --abbrev is
more solid, so I will split %h respecting --abbrev into a separate
patch.

If the current behaviour is actually intentional, we should at least
update the documentation to say that %H is the "full commit hash",
rather than just the "commit hash".

-- 
-- Will
