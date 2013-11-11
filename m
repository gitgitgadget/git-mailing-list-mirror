From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 1/7] remote-hg: don't decode UTF-8 paths into Unicode
 objects
Date: Mon, 11 Nov 2013 05:04:56 -0600
Message-ID: <5280b9d87f92c_6841541e786f@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-2-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 12:12:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfpPx-0004CR-W5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 12:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab3KKLMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 06:12:25 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36786 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab3KKLMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 06:12:17 -0500
Received: by mail-ob0-f178.google.com with SMTP id va2so4222809obc.9
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 03:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=AGiq4uQoa2epDjWegfMYEYKS46U4GJH+Ocaya8ZU47Y=;
        b=LSRGEzGCXpw1d8osnwFC4Dqu3rccu9smPvhZwjuxRPd8RiHjk4FLMfASQFqC1RrdPv
         mmSCJNMhuOpsVzjWCJy6cHjVI+PXdNqPnnPRmr9OSHb/SLyyZwOmTQn1NHri0JnM3MP9
         c93ryggXsKEwkt999i1McZ9I6TQLaIq54SYY9ZuCs/GQy9nXbeSI2/LaJYMU7bmq/Xwy
         1MrilHUzrreUNN0fc8Qbd27ermanzvA5zcWxlfZkcIz3zz5YjK/tuLuXj8LN2GK/PAEX
         CelrbplntWgTaGd+NG4Wfj4gjsOZLWE9OfDfBOXzcL4hA4Xc9S9N8BdRreicvf//qAAc
         r42w==
X-Received: by 10.60.144.133 with SMTP id sm5mr17040oeb.103.1384168336798;
        Mon, 11 Nov 2013 03:12:16 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qe2sm25648412obc.1.2013.11.11.03.12.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 03:12:16 -0800 (PST)
In-Reply-To: <1384142712-2936-2-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237608>

Richard Hansen wrote:
> The internal mercurial API expects ordinary 8-bit string objects, not
> Unicode string objects.  With this change, the test-hg.sh unit tests
> pass again.

This makes sense to me, but the tests are already passing for me. How are they
failing for you?

-- 
Felipe Contreras
