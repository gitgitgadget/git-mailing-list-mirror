From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Mon, 22 Aug 2011 01:13:19 +0100
Message-ID: <20110822011319.0a013117@fenix.utopia.dhis.org>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
	<1313712590-26876-3-git-send-email-vitor.hda@gmail.com>
	<20110820191203.GC7135@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 02:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvI96-0001Mo-LS
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 02:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab1HVANg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 20:13:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48700 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab1HVANf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 20:13:35 -0400
Received: by wwf5 with SMTP id 5so4685899wwf.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=3U3KMJTj5k0vXdPaUWGuYqUgY9cu9YvKBVcqtep2E94=;
        b=BJ17nrwydOWaIfCtk4PL0rIxXWZP0Bs7PdDoZLLQB00vg543asu/mQvE1IwBG9rMH0
         cSfsx18dxwgnWjM899w9PboZTUQguRtcy2FYM1GPsPVwSlDlOCla/s94gJtNhl6/dfbf
         BeTPkrxsd7i2UuXTzPOmVgAMCCjqn7nbeU7lY=
Received: by 10.227.153.6 with SMTP id i6mr1475085wbw.67.1313972014072;
        Sun, 21 Aug 2011 17:13:34 -0700 (PDT)
Received: from fenix.utopia.dhis.org (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id ew4sm4425028wbb.8.2011.08.21.17.13.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Aug 2011 17:13:33 -0700 (PDT)
In-Reply-To: <20110820191203.GC7135@arf.padd.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179828>

On Sat, 20 Aug 2011 15:12:03 -0400
Pete Wyckoff <pw@padd.com> wrote:

> Style edits.
> 
> 		-- Pete

I still need some help on the code part of this RFC patch. I really do
not like the way it is implemented. Do you see other possible ways of
achieving the same algorithm?

Thanks,
-- 
Vitor Antunes
