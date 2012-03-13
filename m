From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] test: use test_i18ncmp when checking --stat output
Date: Tue, 13 Mar 2012 01:13:43 -0500
Message-ID: <20120313061343.GB16784@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
 <20120313045404.GA12550@burratino>
 <7vzkblkpkk.fsf@alter.siamese.dyndns.org>
 <7vvcm9kpcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 07:14:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Kzm-0002tJ-G2
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 07:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758943Ab2CMGN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 02:13:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43527 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758802Ab2CMGNz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 02:13:55 -0400
Received: by gghe5 with SMTP id e5so182036ggh.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZnsgXNZ12WC7saczfMPMqdc8zdfUk8oeyyysQuIe1yY=;
        b=m49W8AXXQWyYilx1byez3CmyeazOdQ7EStw/gV0cMlBU5uZlVEmouOZXFg/5OC0wDp
         YL3Afm2vZrPJ8uoRMwetlt8bdVx39I7dLZK8vEGL3iOAAnWzVndQlT13qFMqU67mBhSO
         9IM0olmbSb5pbF83I8CY27AKyspIB3h4uXG1mpWRJ5pJqru03Wot2nPTWx/xCgHe1Tvp
         2LGT1pOss/OyROZbnOm9p8w6NnKssG7oNJ0cLugZeTREY10DnDxF6Qq7cGQRJGWXff5+
         1YnWGBs7hf2cxr7UCPDE+7mpXVX43PRNd86x9Gp5QDDYP3/TcDdkkOtOZjhmpjVZlfX8
         Meiw==
Received: by 10.182.1.1 with SMTP id 1mr10442100obi.32.1331619234994;
        Mon, 12 Mar 2012 23:13:54 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b6sm24612912obe.12.2012.03.12.23.13.53
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 23:13:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvcm9kpcs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192984>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> But I do not think the progress output from range cherry-pick needs
>> to be cast in stone even in C locale, hence the comments in the
>> first two paragraphs from me.
>
> Ahh, I spoke too early before reading them through.  You do touch
> them later in the series.
>
> Sorry for the noise, and thanks.

No problem.  Sorry for the crossed messages.
