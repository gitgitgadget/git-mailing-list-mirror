From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] git-p4: ignore P4 changelists that only touch files
Date: Tue, 22 Dec 2015 10:18:09 +0100
Message-ID: <8EC36E87-CEC6-4E30-B606-4F4AC572B1DB@gmail.com>
References: <1450623579-17013-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: luke@diamand.org, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 10:18:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBJ5H-0005R3-8o
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 10:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbbLVJSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 04:18:13 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36338 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbLVJSL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 04:18:11 -0500
Received: by mail-wm0-f52.google.com with SMTP id p187so100591420wmp.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1rc0w2ps1DaZmT8fFGonr1MRU2N5gXsQ7kw4U5SZMWo=;
        b=o3GylHgsNACL82/8WKT/TB/aR4R1TaSiYG0BDRwPEvs1fjodcEXxNpv/giwUzChfCx
         IzKGCuBTce68MYkNqfRgMy3i+dxBL6SzsuoYviKy/7mHtAvrXdKFj/g8RAHOncekUv9a
         YunuaGIQjEkCdmR9t5yFagW2AIYwVTA4dcQwAENJStKxoMqKTRXECMtB75JTTcgdyU1j
         HlpwyOZE0+nFO8TcKNBfhEggY4w2ps9Pu5A/X5pzPVjB7zzhhQIeA7zIlrapRupk5u+3
         oyePL8VuLeTmjRhXNvdwq3UjgqbB0bCn4uv3g7ubepmq6cLuXd/0p9mc50i/z6H3wH3h
         lWkw==
X-Received: by 10.28.88.5 with SMTP id m5mr27123687wmb.54.1450775890240;
        Tue, 22 Dec 2015 01:18:10 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB452E.dip0.t-ipconnect.de. [93.219.69.46])
        by smtp.gmail.com with ESMTPSA id kb5sm31985039wjc.20.2015.12.22.01.18.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Dec 2015 01:18:09 -0800 (PST)
In-Reply-To: <1450623579-17013-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282838>


On 20 Dec 2015, at 15:59, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Hi,
> 
> this patch improves "git-p4: add option to keep empty commits" (4ae048e)
> and therefore should be applied on master.
> 
> Thanks,
> Lars

Junio just made me aware of the inappropriate phrasing here.
This is what I wanted to express:

This patch is based on master as it depends on "git-p4: add option to keep empty commits" (4ae048e)"


Sorry,
Lars