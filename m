From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] ls-tree: migrate to parse-options
Date: Mon, 16 Nov 2009 22:28:35 -0800
Message-ID: <4B024293.5090000@gmail.com>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com> <1258173248-31059-3-git-send-email-bebarino@gmail.com> <7vpr7hisc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHYT-0008FS-Gj
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbZKQG2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbZKQG2e
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:28:34 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45093 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbZKQG2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:28:33 -0500
Received: by yxe17 with SMTP id 17so576404yxe.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 22:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lSAg80hdjme9OCkbnaajM5sgH1rWSdTj037V6R5slmA=;
        b=lc5SefbLH+/HehWbZIg3pvJsW60E77DxM0Yxre+lk7L7YgeLEazrAS7ayS4z9SdivL
         wOkCFYk/CHCyf3GO4PgKNPGlXeo/XER/1/0tdiwMpS/VyfrdWGPeQG2+HYxsFJdFotPE
         ilqM8eIKRhmOY35cbL6/W2VVL9QRmSaQ7o6x4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kv2ujvMKAEZxL0EtEsYDENEF2j4YjaSO4NTEkKjvTuUHLpjWMYlS86qYvwrTeMbDI2
         JDzrCIF3eKtxDVEjV/+H7o6GUeZvjYlixrIZmggdFCMqhL772OHtBVq5Mmv2guInAcKQ
         uL0X0Rgixgyic8RCskeUcDzd6QkjsQUuTjFNA=
Received: by 10.90.16.35 with SMTP id 35mr401796agp.54.1258439319231;
        Mon, 16 Nov 2009 22:28:39 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 36sm1947468yxh.49.2009.11.16.22.28.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 22:28:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <7vpr7hisc7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133065>

Junio C Hamano wrote:
> Thanks.
>
> As parse-options infrastructure gives much better per-option help text,
> there is not much point to keep the list of options that can go stale
> in the usage text.
>
> I'd squash this to yours.  Ok?
>

I like this style too. Less usage update patches are better. Thanks.
