From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fix compilation with NO_PTHREADS
Date: Sat, 5 Jan 2013 15:40:10 -0800
Message-ID: <20130105234010.GB5686@elie.Belkin>
References: <20130105145229.GA25112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:58:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrddK-0003Zi-5M
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab3AEXqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 18:46:36 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54419 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab3AEXqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 18:46:35 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so9875653pbc.33
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XKTlHygqRYDfDOco//2ZaDMmiWCcbqWzmaQDQavt3n4=;
        b=ObQiAlZwxpX2nmwQ59O9ye4blA/KTgktzS9AZ5L4+BZZAx5x+a1bSmPjou3NRScpjw
         QtOfVhCxlK6hEI7+JXadNNiUpxDo/cOXnD9SqrdW15IfhpGYQ5IklfYcS9yRV8EMRqPM
         5znfxCkvBrROLbZepS0nATeUYkkf+RB066jYkUIwsQCijxyDRnykGWP6pEO+Cumy1234
         JR9z5fWdpre3MNmzpUY+HjqZ/FSsVUhB/yYO67PHIUOcJxkFuLSQ1qSMlRftolidKPOh
         LYDFYDAr6ev9e+xmhzsukGaq/qHZoITp0ZPeQzS5anBwn9p3/3T5PgiN8/G0TimskfQo
         TD9Q==
X-Received: by 10.66.73.2 with SMTP id h2mr619665pav.59.1357429214717;
        Sat, 05 Jan 2013 15:40:14 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id l5sm35795633paz.14.2013.01.05.15.40.13
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 15:40:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105145229.GA25112@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212742>

Jeff King wrote:

> I happened to notice this while looking at the sigpipe topic. I guess
> not many people are building with NO_PTHREADS these days.

Or that those people don't build "next". :)

Thanks for catching it.
