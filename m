From: Sami Boukortt <samiboukortt@gmail.com>
Subject: Re: Failed assertion in pathspec.c
Date: Sun, 14 Jun 2015 12:21:58 +0200
Message-ID: <20150614122158.4f8042ca@SaMobile>
References: <20150613191839.3585effd@SaMobile>
	<CACsJy8DX9ZnUiFvyLwrhG=BDtXr333WpK5y0Axd0-6grOOf6aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sami Boukortt <samiboukortt@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 12:22:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z453Q-0002Lm-Pm
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 12:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbbFNKWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 06:22:12 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35893 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbFNKWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 06:22:10 -0400
Received: by wigg3 with SMTP id g3so50780778wig.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tWlh+L8KNommZxAtrib34OdhXDwHnLMSLyHy+7g44gY=;
        b=FPlHHlxVX6X5SoA6LihfBMxZrRe+EutzzHaiaPAflE0nXWZ13Aeau5f10Sqh0J0sxx
         aR6AUM6PfYEd8vyVe1QUUbMecL9YqwXdEhkSMIDdBnWV877iHdWRNa8wkF66Y/PMgaol
         c0mbdhxjE3VKZHfS4RgyuLTghYaFQV+eQfvtn2oqizozvtXzDcw7UGy9JpPOIL9tvt1Y
         dyfr7wREY3ub+pc/sE9dn2PK2D+b6jyQ4jXkS4/4dEzub7JvCbWaUkGokZ5ZGthYChzz
         PyEAeafoIjpQuZ0HpqVv4fAYXyk6BUmH3u1u8pGGPfa+NYXoWFKVxEW9d345fq489BbK
         eStA==
X-Received: by 10.194.10.165 with SMTP id j5mr20826751wjb.147.1434277329372;
        Sun, 14 Jun 2015 03:22:09 -0700 (PDT)
Received: from SaMobile (mtg95-10-78-219-27-149.fbx.proxad.net. [78.219.27.149])
        by mx.google.com with ESMTPSA id n3sm11427888wix.1.2015.06.14.03.22.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2015 03:22:09 -0700 (PDT)
X-Google-Original-From: Sami Boukortt <sami.boukortt@gmail.com>
In-Reply-To: <CACsJy8DX9ZnUiFvyLwrhG=BDtXr333WpK5y0Axd0-6grOOf6aA@mail.gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.28; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271634>

> On Sun, Jun 14, 2015 at 12:18 AM, Sami Boukortt
> <samiboukortt@gmail.com> wrote:
> > git: pathspec.c:317: prefix_pathspec: Assertion
> > `item->nowildcard_len <= item->len && item->prefix <= item->len'
> > failed.
> 
> Known issue, but no one stepped up to fix it yet
> 
> http://thread.gmane.org/gmane.comp.version-control.git/267095

Oh, I see. Sorry for the duplicate report.
