From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option
 bypasses the type check
Date: Mon, 2 Sep 2013 14:55:45 -0700
Message-ID: <20130902215545.GA2668@elie.Belkin>
References: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley>
 <20130901.134900.829124962244710553.chriscool@tuxfamily.org>
 <29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley>
 <20130902.081157.986549849748779440.chriscool@tuxfamily.org>
 <66A16BF0137D40568A34C316DDA6D32E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	git@vger.kernel.org, trast@inf.ethz.ch, j6t@kdbg.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Sep 02 23:55:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGc6I-0005l2-Je
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 23:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759019Ab3IBVzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 17:55:54 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:39268 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758979Ab3IBVzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 17:55:53 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so5606859pac.31
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ucxc/LhvkJ3NrIsNxCzlNTR8Hpp1OKU8l+jOvY8yLe4=;
        b=k31gsNQC3kfOqiunp2i8wyCOHnaGAJK+GjQ9a8xjFrRsVKNjqJIoCuY6jLWZDd2YMB
         RV9KFxCP3xGfOphO3w09zlPbq0q3WyWssq/1/l1TIPr64CXFVz9+02MkQ2DNPnIN+tjt
         1KPgF3yzWLRMBKwrj3Rfgs0FBjJAVKt/+zAcYuKA/AoYUTZ2n+ikxTMHTxb6NhehkrVD
         XW+tMc7XbWVHxtTAgNmf7iPcNSNmCFRXcqnqsSU81lCTE+IC5TP1/ic9AgTtCHhWi7P5
         UTiaTqse4SdBbngtBrz95q08JzzekndvoCqvLqa5gjXowwZK+O49ybMoDkXlRyhE7c3I
         zJrQ==
X-Received: by 10.68.21.66 with SMTP id t2mr5237127pbe.151.1378158953045;
        Mon, 02 Sep 2013 14:55:53 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id py4sm18034950pbc.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 14:55:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <66A16BF0137D40568A34C316DDA6D32E@PhilipOakley>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233662>

Hi,

Philip Oakley wrote:

> Does `hash-object` do the inverese of `cat-file commit`?
>
> I didn't find the hash-object(1) man page very informative on that matter

Hm.  The manpage says:

	Computes the object ID value for an object with specified type
	with the contents of the named file [...], and optionally writes
	the resulting object into the object database.

And then:

	-w
		Actually write the object into the object database.

Any ideas for making this clearer?

Thanks,
Jonathan
