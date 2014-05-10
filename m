From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 20/25] contrib: remove 'contacts'
Date: Fri, 09 May 2014 23:00:21 -0500
Message-ID: <536da4558de17_1ed7ae930412@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-21-git-send-email-felipe.contreras@gmail.com>
 <20140510015958.GA45511@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 06:00:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiySg-0003vR-0v
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 06:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbaEJEAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 00:00:30 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:49719 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaEJEA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 00:00:29 -0400
Received: by mail-ie0-f181.google.com with SMTP id y20so4967541ier.40
        for <git@vger.kernel.org>; Fri, 09 May 2014 21:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=sFN3V2A8J7Tjz2H7gjutt+alIUAnih8MaD9EWPoSRj8=;
        b=CAQw9NEO3gxojKCITFzyg8rDroFmIiiVQ1lPL5RxiCjAmi7N0HwWQtYNGXzAa+PGkJ
         sG5Anunwss2VXvPDcAJK+TfDR5kkl/hvDaTTH+0zlDElJlsx/flBn/3XAYGgoS9CWqHG
         7JdRWmNWwV0t9pPX699BryI4JUmofqBBt9i/c7pCcHbYmX/dlOzx6tMbSM08jgtKvczT
         hu5k9se0Sn0ssXC3JldR49ravuHQDHppSsdRkNqB351/wj7dr2AtO36onnGQBhRFhDRL
         LL38yZ90/FgJNOQgrlwDOozi3QdveSX1U2WQgRrdG/K4TNz4g0HHQSU219TJM22FxZJK
         aZrw==
X-Received: by 10.50.153.49 with SMTP id vd17mr17049567igb.40.1399694429300;
        Fri, 09 May 2014 21:00:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id i16sm3759733igf.11.2014.05.09.21.00.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 21:00:26 -0700 (PDT)
In-Reply-To: <20140510015958.GA45511@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248650>

brian m. carlson wrote:
> On Thu, May 08, 2014 at 07:58:31PM -0500, Felipe Contreras wrote:
> > There are better out-of-tree tools, and this tool is not planned to move
> > into the core anyway.
> 
> I have used this once or twice, and I have seen others indicate their
> use of it as well.  I am not volunteering to maintain this, but if it is
> working reasonably well for people (as it appears to be), I don't see a
> reason to remove it.

If all it took as qualification for contrib is that "somebody" uses it,
contrib would be festered by tools that right now live out-of-tree.

The reasons why some tools are not dropped from contrib, and others are
rejected to contrib are completely arbitrary.

-- 
Felipe Contreras
