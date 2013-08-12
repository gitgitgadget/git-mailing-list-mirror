From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Mon, 12 Aug 2013 11:28:01 -0500
Organization: Exigence
Message-ID: <20130812112801.0aae67a2@sh9>
References: <1376288518-4875-1-git-send-email-stephen@exigencecorp.com>
	<7vpptjz9r1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 18:28:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8uyY-0008SH-PF
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 18:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab3HLQ2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 12:28:07 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:58260 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab3HLQ2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 12:28:05 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so6087623obb.9
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-type:content-transfer-encoding;
        bh=6+fI2qDePezOsJLNmVXlA6eRtp20BH9wCYJIOvS8MYE=;
        b=e655BSxICVIlPXhbtS3UXEyw+CyANM8UIdOpvHX23nvgSNqzCw6DexJ/gBRtRWR7Au
         u4MeTyd4AnLLJ9x7t444vJAi2g3p9O9oI951UdDB1K6CdKWNhIsBIGdpS9GV5EU/6zwa
         yZaoEFTD8zKlEDTJgrRIp0p8QAOKEQW1chq88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=6+fI2qDePezOsJLNmVXlA6eRtp20BH9wCYJIOvS8MYE=;
        b=g6nQq+D2+iH0WlLOYpR7rEcBoxDLm6XuT6uHiVdr7+2MCd8XIt9006IfJAwibkBN7n
         jxeGBaJNS1nvcanqs0lm0yb/+19EclvIaU72oeMT99pypUI3vsUSUmbwWsq0G+pWSIrX
         en6X9csb3ZfSrjHYuvTzhHiw3REoB+r1XfwvVLClkM2pWBbSduvN9aFOhv8H7pWDbE3Q
         GlSUcgu/dJSuvsjG3SErJt6r2VPzroinSqNLllCp5tvf2uXXa3ZMjFY12y8ewPB5DFGs
         IPUYvrSKyGdXNdi5pmMVL1naUhGFfcpvJXRwzhgzsWs5DMPb8BRkrXHuNtyWkZ/2u7U4
         KfcA==
X-Gm-Message-State: ALoCoQmiu0V4dbzF70uH7gFrxnaQHRLwTBCjUOGDDQrIHS8Gb4tLINdGv+2hCj0O/MvCC6F5aFhZ
X-Received: by 10.182.186.66 with SMTP id fi2mr73916obc.98.1376324884058;
        Mon, 12 Aug 2013 09:28:04 -0700 (PDT)
Received: from sh9 (wsip-70-184-197-10.om.om.cox.net. [70.184.197.10])
        by mx.google.com with ESMTPSA id n2sm34091194obo.6.2013.08.12.09.28.02
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 09:28:03 -0700 (PDT)
In-Reply-To: <7vpptjz9r1.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232196>

Hi Junio,

> "-r", even though it happens to be accepted, is not a good idea
> here, as there are other --r* commands that are not --rebase.
> 
> 	[--[no-]rebase|--rebase=preserve]

Cool, I will change that.

> You would want "bool or string" helper function to parse it
> correctly, something like:

Oh, interesting, I had not thought of that--thanks for that
git config --bool snippet, that's really helpful.

- Stephen
