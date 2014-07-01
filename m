From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 3/3] cache-tree: Write index with updated cache-tree
 after commit
Date: Tue, 01 Jul 2014 15:58:04 -0700
Organization: Twitter
Message-ID: <1404255484.3109.7.camel@stross>
References: <1404242075-7068-1-git-send-email-dturner@twitter.com>
	 <1404242075-7068-3-git-send-email-dturner@twitter.com>
	 <xmqqlhscvgts.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 00:58:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2709-0002DA-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 00:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbaGAW6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 18:58:09 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:36543 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461AbaGAW6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 18:58:07 -0400
Received: by mail-qc0-f182.google.com with SMTP id m20so9291552qcx.13
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 15:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=DX7Jf2X9Gg5j0poUdgyvFT4ATxO1ms0M2S1CH62Z8MY=;
        b=L0NAg2CuBNt/wtZ4DXxP3gSnxbC/hUpa3S2c3YHAmV7tE/5i06CTr8SabErB03rv1g
         DS+HNLQmbL3iItRjAq0xUyhF2OeEOeVUnJ5TNAKgsOg9znKNon/L8ufv+yM6j96u0DeI
         tE6Qnd83h52JVt2hWCfZDLWuXwP6OtdW4MY/J/ccIHCKTeYK3HV1YwB8aACg2e4C3Q2u
         hejMB0H/WWsUME+KmeEiwVcEyufjBwD44Oujc3xDiugvCcQbmoGLAgoeEU8WU6z7cz96
         diLzHnWqPoRlvnkAvmJlK2JRCteTh/tOokRB16p3La8vs2uwWTJUNeJ8j3g0EHzaZ9n9
         Q0XA==
X-Gm-Message-State: ALoCoQmdsglTmJig2qYBMQFb3Rc0LfAhNUtp+kmI9mageN/m2hV2OVKd5z41nc0rnd33UYoOjgrJ
X-Received: by 10.224.172.10 with SMTP id j10mr67817992qaz.46.1404255487108;
        Tue, 01 Jul 2014 15:58:07 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id r2sm39620945qam.35.2014.07.01.15.58.05
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:58:06 -0700 (PDT)
In-Reply-To: <xmqqlhscvgts.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252754>

On Tue, 2014-07-01 at 15:45 -0700, Junio C Hamano wrote:
> I didn't notice it when I gave the previous review comment but while
> reviewing this round, we already do the cache-tree population for
> "commit -a" in this function, which suggests me that it is the right
> place to do these changes.  Modulo minor niggles, I like this
> iteration much better than the previous one.
> 
> Thanks for working on this.

Thanks for all your comments.  I'll send out a v4 when I can, but I
probably won't have more time to work on this until next week. 
