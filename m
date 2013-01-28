From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Mon, 28 Jan 2013 01:20:41 -0800
Message-ID: <20130128092041.GA3346@elie.Belkin>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
 <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:21:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzku2-0005vo-BN
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 10:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab3A1JUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 04:20:54 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:64837 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab3A1JUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 04:20:51 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so1167320dad.41
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 01:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HcpfbQvCyVMDFhkUrRcBFW5YpCvV81gCde6osLogRPs=;
        b=eSt5F+NPlFZTxq3rnFu6+jDg3oJJwyxk3BWo9ckG9pwBldIe5ngRhTe4K1GSPM+NzF
         kPqzqVqvbQlILxWY8RT9O++bxt15EyCkvND508HOIa9zI7CH0mMcw00UzOwzXdFKPs1u
         qPMTGIKp1zsNLApMZYcVSV7kvQvuGYIOGRBNwJuCFOn3oASAK6YIZXeKKz7muKc2+hhZ
         uE6QmzpX0eWqZINaRVAQuxT9Dl1zxAv1byYd5nGN7DEGuovCkRbXvnzESMeOdBPVvKfy
         HQti2S9kcnREAflizvDvFC73iUwr3lqAXC7h9ZNJPd9vaEq1qQaL8LrAriN39hhP3H5w
         +5+g==
X-Received: by 10.68.194.6 with SMTP id hs6mr35916625pbc.77.1359364851291;
        Mon, 28 Jan 2013 01:20:51 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ty4sm5975423pbc.57.2013.01.28.01.20.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 01:20:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214824>

Matthieu Moy wrote:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Looks good to me.

At some point we'll want to have tests for this case, but that's not
particularly urgent until it's time for the warning() to turn into a
die().

Thanks.
Jonathan
