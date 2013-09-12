From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] http-backend: provide Allow header for 405
Date: Wed, 11 Sep 2013 17:33:43 -0700
Message-ID: <20130912003343.GH4326@google.com>
References: <1378945801-122021-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jkoleszar@google.com,
	gitster@pobox.com, peff@peff.net
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 02:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJur1-0004xE-SC
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 02:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab3ILAds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 20:33:48 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38142 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab3ILAdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 20:33:47 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so9697585pbc.8
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=No8jOoPL4Nmc9cdl1dGdMD8go6HJPBaAVx2I4xI79Ek=;
        b=Fb2rYvNcsnQI04ybyX0tCIc4eTgHn5WKA5pmQZKAcEymIUUQW8OxUAAF0RzkVm1uYX
         Gw7TE8nAorKga+LL0YoUFWUce5mKWqf2+DF5N90vhsfOJRj7tHCeFpPqaxG7omJrfgHF
         TeHEX9NhusFvHOY3jCEZAYrz4yqADButgYJAiToLHPTkSHb/yhD7gGmrwUsgZyTXsM2g
         PHP+LPmQ36K6gO4qKd9+DKl8pciCKBiuU6JZmy6hXXP4ulSyfV4Hos2Xy27OIt9I7fYk
         JpzyzV5weskhd4NCWeBNYvNd5KgGAlfMSOv9LsZddilwoceNZEXdfj5gstvcEfTIl3zj
         t+PA==
X-Received: by 10.66.145.166 with SMTP id sv6mr6439093pab.31.1378946027402;
        Wed, 11 Sep 2013 17:33:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id f2sm722479pbg.44.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 17:33:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1378945801-122021-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234616>

brian m. carlson wrote:

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Thanks again for noticing.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
